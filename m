Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBBCJB>; Thu, 1 Feb 2001 21:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbRBBCIv>; Thu, 1 Feb 2001 21:08:51 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:4880
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129161AbRBBCIm>; Thu, 1 Feb 2001 21:08:42 -0500
Date: Thu, 1 Feb 2001 21:17:49 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 lvm reiserfs adaptec 2940uw noritake alpha
Message-ID: <20010201211749.A18693@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 3 2gb disks in an lvm group (vg is disks)
I have an lv of 1.6gb (misc) with reiserfs mounted /lvm/misc
I cp /dev/zero /lvm/misc

If these 3 drives are on the internal qlogic isp controller, I have no
problems.

If these 3 drives are on the adaptec aha-2940UW, I get an oops (reply for
oops as I have to do it again and capture it) and the system locks (in
interrupt handler, not syncing) when the copy completes.  I did a timed cp
the first time and it took 3.5 minutes and crashed as soon as I got the
prompt.  I'm assuming when the bufferes were flushed to the drives.

When I reboot and copy the file, it works.  I don't have any problems
copying files with these drives on either controller.

I have the adaptec card on the primary pci bus if that makes a difference


-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
