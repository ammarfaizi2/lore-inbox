Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275421AbRJATjc>; Mon, 1 Oct 2001 15:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275434AbRJATjW>; Mon, 1 Oct 2001 15:39:22 -0400
Received: from post.aecom.yu.edu ([129.98.1.4]:6552 "EHLO post.aecom.yu.edu")
	by vger.kernel.org with ESMTP id <S275421AbRJATjP>;
	Mon, 1 Oct 2001 15:39:15 -0400
Mime-Version: 1.0
Message-Id: <a05100310b7de4e632992@[129.98.91.150]>
Date: Mon, 1 Oct 2001 15:39:36 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: [HANG] Checking root filesystem and then...
Cc: hch@ns.caldera.de
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running on a Netfinity x340 box (single PIII, ServRAID card and 
Adaptec 29160LP card, boot disk is ext2 and is attached to the 
ServRAID card), a stock 2.4.10 kernel gets to the point of "Checking 
root filesystem" and the system simply stops dead in its tracks.

It stops at the line initlog -c "fsck -T -a $fsckoptions /" If I 
remove the "initlog", it still stops. If I remove the "fsck", it 
stops at the next line (mount -n -o remount, rw /)!

I have systematically tried a number of different kernels and have 
discovered that

2.4.10-pre5 works
2.4.10-pre6 hangs

2.4.9-ac7 works
2.4.9-ac8 hangs

How many others are seeing this behavior?

Does anyone recognize something that changed in these kernels that 
could be responsible? The only thing I notice in common in the change 
logs are references to gendisk. (I am not sure how that could be 
responsible as the boot disk is a SCSI disk managed the ServRAID 
driver.)

Does anyone have any idea how this could be further investigated?
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
