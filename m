Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313621AbSDHNtI>; Mon, 8 Apr 2002 09:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313626AbSDHNtH>; Mon, 8 Apr 2002 09:49:07 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:49422 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S313621AbSDHNtH>;
	Mon, 8 Apr 2002 09:49:07 -0400
Date: Mon, 8 Apr 2002 14:49:23 +0100
From: Chris Wilson <chris@jakdaw.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: P4/i845 Strange clock drifting
Message-Id: <20020408144923.4566d3fc.chris@jakdaw.org>
In-Reply-To: <200204051752.TAA02715@harpo.it.uu.se>
Organization: Hah!
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mikael,

I've now applied your patch so that APIC's get enabled even though the
bios has disabled them. 

I really should have saved the dmi messages to another machine when the
machine first came up as it appears to have crashed now :(

The machine was completely idle other than for an ssh session running
ntpdate every ten minutes (my original problem is that the clock appears
to stop/slow down periodically). 

>From memory the dmi messages just had a bios date, and the mobo model
(Supermicro P4SBE). Once I've got the NOC to reboot the system I'll switch
it back to a kernel that doesn't attempt to enable the APIC and send you
the full dmi strings.

> This should work (and is known to work on many P6 and K7 boards),
> but your BIOS may have problems with the local APIC.
> - does apm --suspend work? does the resume afterwards work?

I don't have APM support compiled in and will have disabled anything power
management related in the BIOS setup.

I guess that I'm not going to get APIC going on this system then - does
anyone have any other suggestions on what to try next to debug the clock
drift problem? Short of dropping the server into the nearest skip....

Are the APIC thing and the clock thing likely to be related??


Cheers,

Chris
