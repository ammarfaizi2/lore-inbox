Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbSK3Sml>; Sat, 30 Nov 2002 13:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbSK3Sml>; Sat, 30 Nov 2002 13:42:41 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:46852 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S267284AbSK3Smi> convert rfc822-to-8bit;
	Sat, 30 Nov 2002 13:42:38 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.50, APM] "apm -s" doesn't put TP 600 to sleep
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
Date: Sat, 30 Nov 2002 14:55:50 +0100
Message-ID: <87ptsnrwk9.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I use a Thinkpad 600 here, 2.4 APM works quite well.  With 2.5.50 I
get when running "apm -s":

Nov 30 15:51:44 gswi1164 bad: scheduling while atomic!
Nov 30 15:51:44 gswi1164 kernel: Call Trace: [schedule+61/712]
[schedule_timeout+132/164]  [process_timeout+0/12]  [<c6abefa1>]
[<c6abf33b>]  [<c6ac1287>]  [<c6ab0f4c>]  [start_request+154/344]
[start_request+249/344]  [ide_do_request+724/820]  [schedule+616/712]
[journal_cancel_revoke+243/364]  [ext3_get_block_handle+182/776]
[journal_cancel_revoke+243/364]  [journal_cancel_revoke+243/364]
[journal_cancel_revoke+243/364]  [do_get_write_access+1272/1308]
[journal_dirty_metadata+423/472]  [ext3_free_inode+835/968]
[ext3_free_inode+922/968]  [__wake_up+32/64]  [journal_stop+596/612]
[ext3_delete_inode+0/404]  [ext3_destroy_inode+19/24]
[destroy_inode+61/84]  [generic_delete_inode+194/200]
[generic_drop_inode+16/32]  [iput+102/108]  [d_delete+106/192]
[dput+25/340]  [sys_unlink+224/288]  [capable+27/60]
[sys_ioctl+541/628]  [syscall_call+7/11]
Nov 30 15:51:44 gswi1164 kernel: drivers/usb/core/hcd-pci.c: suspend 00:07.2 to state 3
Nov 30 15:51:44 gswi1164 kernel: atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.
Nov 30 15:51:44 gswi1164 kernel: apm: suspend: Unable to enter requested state
Nov 30 15:51:44 gswi1164 kernel: drivers/usb/core/hcd-pci.c: resume 00:07.2

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
