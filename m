Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280871AbRKYNO2>; Sun, 25 Nov 2001 08:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280873AbRKYNOS>; Sun, 25 Nov 2001 08:14:18 -0500
Received: from smtp-rt-4.wanadoo.fr ([193.252.19.156]:30897 "EHLO
	areca.wanadoo.fr") by vger.kernel.org with ESMTP id <S280872AbRKYNOH>;
	Sun, 25 Nov 2001 08:14:07 -0500
Message-ID: <3C00EEA0.F43E95AA@wanadoo.fr>
Date: Sun, 25 Nov 2001 14:14:08 +0100
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.16-pre1 : e2fsck, File size limit exceeded (core dumped)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I've two partitions. /dev/hda1 where I can boot 2.2.20 or 2.4.16-pre1,
/dev/hda3 
with only 2.4.16-pre1.

When I boot 2.2 one the first one and I try a e2fsck on the second one,
I get :

[root@debian-f5ibh] ~ # e2fsck -f /dev/hda3
e2fsck 1.25 (20-Sep-2001)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/hda3: 79176/250368 files (1.5% non-contiguous), 277317/500023
blocks


Now, if I boot 2.4.16-pre1, I have the following :

e2fsck 1.25 (20-Sep-2001)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/hda3: 79176/250368 files (1.5% non-contiguous), 277317/500023
blocks
File size limit exceeded (core dumped)

I tried a e1fsck -f /dev/hda1 from 2.4.16-pre1, I get :

[root@debian-f5ibh] ~ # e2fsck -f /dev/hda1
e2fsck 1.25 (20-Sep-2001)
Pass 1: Checking inodes, blocks, and sizes
Special (device/socket/fifo) inode 1342156 has non-zero size.  Fix<y>?
yes

File size limit exceeded (core dumped)

If I do the e2fsck from 2.2.20, all is right and the sero-sized inod is
fixed.

Does anybody is interested by the core  ;-)
---------
Regards
		jean-Luc
