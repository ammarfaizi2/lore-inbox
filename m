Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKVJ2S>; Wed, 22 Nov 2000 04:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQKVJ2I>; Wed, 22 Nov 2000 04:28:08 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:9815 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S129231AbQKVJ14>;
	Wed, 22 Nov 2000 04:27:56 -0500
Message-ID: <3A1B8A5D.1869C463@vz.cit.alcatel.fr>
Date: Wed, 22 Nov 2000 09:57:02 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
Organization: xgen@linuxstart.com
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: cooker@linux-mandrake.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Cooker] Re: [CHRPM] modutils-2.3.20-1mdk
In-Reply-To: <20001116153044.0339B5F405@kenobi.mandrakesoft.com>
		<3A153C8F.E752B931@vz.cit.alcatel.fr>
		<20001117113729.F26481@mandrakesoft.com>
		<3A192A32.4DA063D0@vz.cit.alcatel.fr>
		<20001120160822.A7489@mandrakesoft.com>
		<m38zqes0fv.fsf@matrix.mandrakesoft.com>
		<3A1A3B94.FD5EC61B@vz.cit.alcatel.fr> <m3g0kl2v5h.fsf@matrix.mandrakesoft.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chmouel Boudjnah a écrit :

> i have no idea what's happen here, but gonna to look at this.

The problem is in modules.conf
Most users do not use "depfile" and "path" commands
So they have not seen this problem.
Other have not read the man.
As I have tested the new 2.4 kernel, and I wanted to be able
to load and run modules, I have a big modules.conf using
theese commands.

The man for modules.conf says:

DEFAULT CONFIGURATION
         depfile=/lib/modules/`uname -r`/modules.dep
         pcimapfile=/lib/modules/`uname -r`/modules.pcimap
         isapnpmapfile=/lib/modules/`uname -r`/modules.isapnpmap
         usbmapfile=/lib/modules/`uname -r`/modules.usbmap

         path[boot]=/lib/modules/boot
         path[toplevel]=/lib/modules/`uname -r`
         path[toplevel]=/lib/modules/`kernelversion`
         path[toplevel]=/lib/modules/default

This was true for modutils-2.3.19, and older versions.
With modutils-2.3.20 the syntax have changed.
Anything in ChangeLog?
`uname -r` has to be changed in $(uname -r)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
