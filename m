Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265451AbTFSU3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265453AbTFSU3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:29:11 -0400
Received: from web14802.mail.yahoo.com ([216.136.224.218]:15457 "HELO
	web14802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265451AbTFSU3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:29:09 -0400
Message-ID: <20030619204308.39271.qmail@web14802.mail.yahoo.com>
Date: Thu, 19 Jun 2003 13:43:08 -0700 (PDT)
From: Venkat <rpraneshnews@yahoo.com>
Subject: Linux IDE & RAID Rebuid Issue
To: linux-kernel@vger.kernel.org
Cc: srikumarss@yahoo.com, rpraneshnews@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have two IDE controllers in my mother board 
(Serverworks and Silicon Image CMD 680) . I have two
Maxtor IDE Drives(same model, same capacity) connected
to the IDE controllers (One drive per controller). 
Linux detects the drives but the number of heads
reported by the controller/BIOS/Linux is different.
For one drive linux reports 64 heads and for the other
drive it reports 255 heads. This is causing a problem
with RAID rebuilding. The below text explains the
problem in detail.

I create a RAID drive across both the drives.I want to
create a 512 MB partition on both the drives, but
Redhat installatiion program creates 512MB partition
on one drive and 520MB partition on the other drive. I
assume that this discrepanies is due to different Head
count.

This is OK when the RAID drives are created, because
the RAID drive takes the smallest size(512MB)

But the problem happens when the one of the drives is
pulled out and a new partition of same size is created
and the RAID drives are rebuilt. When i create the
same size partition on the new drive using FDISK, it
is not exactly the size i want (512MB). It creates a
509 MB Partition on the new drive. This causes the MD
RAID driver to fail the rebuild.
The new drive is also of the same type and same model
as the drive pulled out.

So i assume that if Linux reports the same head count
for the both the drives, the problem should be solved.
I am not an expert on Linux IDE subtree. Can anyone
explain or give a fix?

If anyone needs more info please feel free to contact
me.
Thanks
Venkatesh
PS:
Please CC me on replies as i am not subsribed to the list.

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
