Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316653AbSEUVlN>; Tue, 21 May 2002 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316655AbSEUVlM>; Tue, 21 May 2002 17:41:12 -0400
Received: from mail.invtools.com ([209.81.227.140]:26891 "EHLO
	mail.invtools.com") by vger.kernel.org with ESMTP
	id <S316653AbSEUVlL>; Tue, 21 May 2002 17:41:11 -0400
From: "Jon Hedlund" <JH_ML@invtools.com>
To: sct@redhat.com, akpm@zip.com.au
Date: Tue, 21 May 2002 16:40:06 -0500
Subject: 2.2 kernel - Ext3 & Raid patches
CC: linux-kernel@vger.kernel.org
Message-ID: <3CEA7866.23557.390B7FFC@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last September Stephan told someone on the linux-kernel list that 
Ext3 and Raid 1 didn't work together on the 2.2 kernel. 
Has this been fixed or have I just been lucky?  I've been using ext3 
on a Raid 1 array of two IBM 75GB ide drives with kernel 2.2.19.  
Three times in the last 9 months one of the drives reported errors 
and dropped offline, each time I have fdisked the bad drive, 
formatted it, fsck'ed it and found no problems, fdisked it again, and 
raidhotadd'ed it back in and it restored the array without problems.
Two questions:
1. Besides the faulty drive, is my data in danger from this software 
configuration and I've just been lucky or would this configuration not 
trigger the problems Stephan was warning about?
2. What is the "proper" fix for the patch collision between the raid 
patch and the ext3 patch in /include/linux/fs.h? I've just been 
changing the line
#define BH_LowPrio 8
to
#define BH_LowPrio 5
around line 198, it's been working but I don't know enough about the 
code to know if that might mess something else up or not work 
under some conditions.
Thanks,
JonH
