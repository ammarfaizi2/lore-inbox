Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277930AbRJITgG>; Tue, 9 Oct 2001 15:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277932AbRJITfy>; Tue, 9 Oct 2001 15:35:54 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:14856 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S277930AbRJITfs>;
	Tue, 9 Oct 2001 15:35:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] [2.4.10] echo "scsi add-single-device ..." corrupts /proc/partitions
Date: Tue, 9 Oct 2001 20:31:25 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01100920312501.01174@home01>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After booting my system with 3 internal SCSI disks /proc/partitions shows the 
right partition information. When I later turn on an external disk, and do an 
"echo add-single-device .." /proc/partitions seems to be ... bad. It shows 
the right SCSI partitions, including the ones on the external disk, but it 
repeats this information indefinitely.

The get_partition_list () seems to doesn't seem to return EOF or so, or the 
gendisk_head list may have become cyclic. I'm not sure.

Rolf

