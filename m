Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSLBSde>; Mon, 2 Dec 2002 13:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSLBSde>; Mon, 2 Dec 2002 13:33:34 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:26633 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S264806AbSLBSdd> convert rfc822-to-8bit;
	Mon, 2 Dec 2002 13:33:33 -0500
To: Andries.Brouwer@cwi.nl, Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix wrong permissions for vfat directories
References: <UTC200211302136.gAULaq713410.aeb@smtp.cwi.nl>
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Mon, 02 Dec 2002 19:16:17 +0100
In-Reply-To: <UTC200211302136.gAULaq713410.aeb@smtp.cwi.nl> (Andries.Brouwer@cwi.nl's
 message of "Sat, 30 Nov 2002 22:40:09 +0100")
Message-ID: <8765ucffri.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:

>     From: Jochen Hein <jochen@jochen.org>
>
>     I do mount vfat with autofs, and options umask=002 there.  

> Fixed by the patch below.

I see it has been applied to -bk, Thanks.  Mind fixing the
documentation too?

Jochen

--- linux-2.5.50/Documentation/filesystems/vfat.txt.jh	2002-12-02 18:45:58.000000000 +0100
+++ linux-2.5.50/Documentation/filesystems/vfat.txt	2002-12-02 18:49:07.000000000 +0100
@@ -8,10 +8,12 @@
 
 VFAT MOUNT OPTIONS
 ----------------------------------------------------------------------
-umask=###     -- The permission mask (see umask(1)) for the regulare file.
+umask=###     -- The permission mask (for files and directories, see umask(1)).
                  The default is the umask of current process.
 dmask=###     -- The permission mask for the directory.
                  The default is the umask of current process.
+fmask=###     -- The permission mask for files.
+                 The default is the umask of current process.
 codepage=###  -- Sets the codepage for converting to shortname characters
 		 on FAT and VFAT filesystems.  By default, codepage 437
 		 is used.  This is the default for the U.S. and some

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
