Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129371AbQKUQBd>; Tue, 21 Nov 2000 11:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQKUQBX>; Tue, 21 Nov 2000 11:01:23 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:25704 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129371AbQKUQBG>; Tue, 21 Nov 2000 11:01:06 -0500
To: elenstev@mesatop.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_TOSHIBA Configure.help for 2.4.0-test11
In-Reply-To: <00112018440600.00911@localhost.localdomain>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Date: 21 Nov 2000 16:31:02 +0100
In-Reply-To: Steven Cole's message of "Mon, 20 Nov 2000 18:44:06 -0700"
Message-ID: <7yk89x8hqh.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> writes:

> I noticed that for 2.4.0-test11 there is no help
> for CONFIG_TOSHIBA, although there is for 2.2.17.
> 
> The following patch borrows the words for CONFIG_TOSHIBA
> from the 2.2.17 Documentation/Configure.help, dropping
> an extraneous "the" from the first line.
> 
> This patch applies to 2.4.0-test11.
> 

you can apply this too:

--- linux/Documentation/Configure.help.orig	Wed Sep 27 03:37:40 2000
+++ linux/Documentation/Configure.help	Wed Sep 27 03:39:02 2000
@@ -268,6 +268,11 @@
   Most normal users won't need the RAM disk functionality, and can
   thus say N here.
 
+Default RAM disk size
+CONFIG_BLK_DEV_RAM_SIZE
+  The default value is 4096. Only change this if you know what are
+  you doing. If you are using IBM S/390, then set this to 8192.
+
 Initial RAM disk (initrd) support
 CONFIG_BLK_DEV_INITRD
   The initial RAM disk is a RAM disk that is loaded by the boot loader
@@ -14209,6 +14209,11 @@
   driver as a module you have to specify the MPU I/O base address with
   the parameter 'mpu_base=0xNNN'.
 
+C-Media PCI (CMI8338/8378)
+CONFIG_SOUND_CMPCI
+  Say Y or M if you have a PCI sound card using the CMI8338
+  or the CMI8378 chip.set.
+
 Creative EMU10K1 based PCI sound cards
 CONFIG_SOUND_EMU10K1
   Say Y or M if you have a PCI sound card using the EMU10K1
--- linux/Documentation/sound/CMI8330.orig	Wed Sep 27 03:36:34 2000
+++ linux/Documentation/sound/CMI8330	Wed Sep 27 03:37:09 2000
@@ -57,7 +57,7 @@
 ------------------------------------------
 Stefan Laudat <Stefan.Laudat@asit.ro>
 
-[Note: The CMI 8338 is unrelated and right now unsupported]
+[Note: The CMI 8338 is unrelated and is supported by cmpcpi.o]
 
 	
 	In order to use CMI8330 under Linux  you just have to use a proper isapnp.conf, a good isapnp and a little bit of patience.  I use isapnp 1.17, but

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
