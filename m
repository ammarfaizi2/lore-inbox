Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278615AbRJSTVH>; Fri, 19 Oct 2001 15:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278616AbRJSTU6>; Fri, 19 Oct 2001 15:20:58 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:18181 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S278615AbRJSTUt>;
	Fri, 19 Oct 2001 15:20:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbol hotplug_path in usbcore.o as a module (2.4.12)
Date: Fri, 19 Oct 2001 20:21:17 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15ufCs-0007pL-00@roo.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am not subscribed to the list please cc me on any reply

I have built the the 2.4.12 kernel with CONFIG_HOTPLUG set and the usb stuff 
all compiled as modules.

depmod -e  shows that usbcore.o has an unresolved symbol (which of course 
fails when the module tries to load) of hot_plug path. 

Looking through the code I can see that this gets defined in kmod.c - and 
there is an entry in System.map (I don't know each line means but 
hotplug_path is there).  I can also see the kmod.h (included by usb.c which 
eventually gets built into usbcore) defines it as an external reference.

What I have been unable to figure out is why depmod doesn't link usbcore.o to 
it.
- -- 

  Alan - alan@chandlerfamily.org.uk
http://www.chandlerfamily.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE70H0x1mf3M5ZDr2kRAkXtAKC2t3yxEGhFya9baq3JHo54K+sLVgCgrToe
/PRFjU0H6h04DS4cCxfSA00=
=AiTR
-----END PGP SIGNATURE-----
