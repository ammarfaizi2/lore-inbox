Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUCKPxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUCKPxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:53:17 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:1998 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261425AbUCKPxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:53:12 -0500
Message-ID: <40508B5D.3020709@g-house.de>
Date: Thu, 11 Mar 2004 16:53:01 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kalle Lundgren <kalle@netzorz.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Spelling Error.
References: <20040311092851.6CE3A15646@texi.yes.nu>
In-Reply-To: <20040311092851.6CE3A15646@texi.yes.nu>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050208020400000600030003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050208020400000600030003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kalle Lundgren wrote:
| PROBLEM: Spelling error in Kconfig CONFIG_IRQBALANCE.
|
| Line 834:
| The defalut yes will allow the kernel to do irq load balancing.
|
| Should be:
| The default yes will allow the kernel to do irq load balancing.

and there are other places too:

arch/i386/Kconfig
Documentation/sound/alsa/ALSA-Configuration.txt
drivers/net/irda/via-ircc.c

...if this matters at all, i have attached patches.

Thanks,
Christian.
- --
BOFH excuse #310:

asynchronous inode failure
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAUItc+A7rjkF8z0wRAny2AKDKXCb/jCpG8g2LgYaBP7RlnhsjLwCePRKw
veA3nWRn4hQXvSAEoF0DA9Y=
=RBbU
-----END PGP SIGNATURE-----

--------------050208020400000600030003
Content-Type: text/plain;
 name="ALSA-Configuration-defalut.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ALSA-Configuration-defalut.diff"

--- linux-2.6/Documentation/sound/alsa/ALSA-Configuration.txt.orig	2004-03-11 16:47:10.000000000 +0100
+++ linux-2.6/Documentation/sound/alsa/ALSA-Configuration.txt	2004-03-11 16:47:26.000000000 +0100
@@ -1030,7 +1030,7 @@
     joystick	- Enable joystick (default off) [VIA686A/686B only]
     ac97_clock	- AC'97 codec clock base (default 48000Hz)
     dxs_support	- support DXS channels,
-		  0 = auto (defalut), 1 = enable, 2 = disable,
+		  0 = auto (default), 1 = enable, 2 = disable,
 		  3 = 48k only, 4 = no VRA
 		  [VIA8233/C,8235 only]
     ac97_quirk  - AC'97 workaround for strange hardware

--------------050208020400000600030003
Content-Type: text/plain;
 name="arch.i386.Kconfig-defalut.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch.i386.Kconfig-defalut.diff"

--- linux-2.6/arch/i386/Kconfig	2004-03-11 16:45:47.000000000 +0100
+++ linux-2.6/arch/i386/Kconfig.orig	2004-03-11 16:45:14.000000000 +0100
@@ -831,7 +831,7 @@
 	depends on SMP && X86_IO_APIC
 	default y
 	help
- 	  The default yes will allow the kernel to do irq load balancing.
+ 	  The defalut yes will allow the kernel to do irq load balancing.
 	  Saying no will keep the kernel from doing irq load balancing.
 
 config HAVE_DEC_LOCK

--------------050208020400000600030003
Content-Type: text/plain;
 name="via-ircc.c-defalut.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-ircc.c-defalut.diff"

--- linux-2.6/drivers/net/irda/via-ircc.c.orig	2004-03-11 16:48:43.000000000 +0100
+++ linux-2.6/drivers/net/irda/via-ircc.c	2004-03-11 16:49:05.000000000 +0100
@@ -69,7 +69,7 @@
 
 /* Module parameters */
 static int qos_mtt_bits = 0x07;	/* 1 ms or more */
-static int dongle_id = 9;	//defalut IBM type
+static int dongle_id = 9;	//default IBM type
 
 /* Resource is allocate by BIOS user only need to supply dongle_id*/
 MODULE_PARM(dongle_id, "i");

--------------050208020400000600030003--
