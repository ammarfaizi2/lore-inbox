Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLFR4M>; Wed, 6 Dec 2000 12:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLFR4C>; Wed, 6 Dec 2000 12:56:02 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:12556 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129325AbQLFRzs>; Wed, 6 Dec 2000 12:55:48 -0500
Message-ID: <3A2E767B.D74B24B5@Hell.WH8.TU-Dresden.De>
Date: Wed, 06 Dec 2000 18:25:15 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Trashing ext2 with hdparm
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Following the discussion in another thread where someone
reported fs corruption when enabling DMA with hdparm, I've
played around with hdparm and found that even the rather
harmless hdparm operations are capable of trashing an ext2
filesystem quite nicely.

hdparm version is 3.9

hdparm -tT /dev/hdb1 does the trick here.

After that, several files are corrupted, such as /etc/mtab.
Reboot+fsck fixes the problem, however e2fsck never finds
any errors in the fs on disk.

I'm quite sure that earlier kernel versions didn't exhibit
this kind of behaviour, although I'm not quite sure at
which point things started to break. I have test12-pre6
here atm, but I have test-11 still lying around and will
test that in a bit.

The drive in question is an IBM-DTLA307030 running in
UDMA Mode 5 on a PDC20265, chipset revision 2.

I haven't seen any other corruption other than that which
hdparm reliably triggers. Might as well be a bug in hdparm,
so someone else might also want to check...

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
