Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313787AbSDIDPs>; Mon, 8 Apr 2002 23:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313799AbSDIDPr>; Mon, 8 Apr 2002 23:15:47 -0400
Received: from 66-133-183-62.fod.frontiernet.net ([66.133.183.62]:32640 "EHLO
	66-133-183-62.fod.frontiernet.net") by vger.kernel.org with ESMTP
	id <S313787AbSDIDPr>; Mon, 8 Apr 2002 23:15:47 -0400
Message-Id: <200204090252.g392qNb24499@66-133-183-62.fod.frontiernet.net>
Content-Type: text/plain; charset=US-ASCII
From: Russell Miller <rmiller@duskglow.com>
Reply-To: rmiller@duskglow.com
Organization: If you only saw my house...
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 data corruption issues
Date: Mon, 8 Apr 2002 20:52:20 -0600
X-Mailer: KMail [version 1.3.2]
Cc: barry@Know-Where.com (Barry Bakalor)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not subscribed to the list, so please CC me on any responses.

I am running the stock 2.4.18 kernel, downloaded a few days ago from the 
kernel mailing list.  The kernel was custom-built to my specifications, using 
the default RH7.2 gcc (config available upon request).  The machine is a dual 
pentium-III 1000 MHz, one scsi drive (sym53cxxx criver) and two ide drives.  
All filesystems are ext3 journaling.

We copied several very large partitions from one machine to another in an 
attempt to put a new machine in service.  Just for kicks, we attempted to 
verify the copy.  It turns out that a small amount of files, about 60 to 100 
on a 17 gig partition, are corrupted.  Mod times are exactly the same, 
owners, even file size.  It turns out that pretty consistently four null 
characters (and occasionally other characters and a different number) are 
appended to the beginning of the file, and the last four characters are 
rolled off the end.  We ran the copy (and rsync and stuff) multiple times.  
Each time different files were modified, in a seemingly random fashion, but 
with a fairly consistent pattern of corruption.

I have turned off DMA on the disk drives to no effect.  I have replaced the 
ide cables with higher quality cables.  The problem seems to be occuring on 
both the scsi and ide drives, which to me eliminates the ide or scsi 
controllers, drivers, or anything on the back end of them as the source of 
the problem.This same machine was in service previously, minus one disk 
drive, and this problem never manifested itself, leading me to believe it is 
either something to do with the ext3 jfs, or with the 2.4.18 kernel.

Does anyone have any tips on how to debug this?  I have administrative access 
to the machine, and although it is running production, I am very keen on 
getting this resolved and will provide any information you need.  If this is 
a kernel or ext3 problem as I suspect I imagine you want to get this resolved 
as much as I do.

Thank you in advance for your help.

--Russell



-- 
Russell Miller
rmiller@duskglow.com
Somewhere in Northwestern Iowa
