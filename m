Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278292AbRJMOGe>; Sat, 13 Oct 2001 10:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278293AbRJMOGZ>; Sat, 13 Oct 2001 10:06:25 -0400
Received: from colorfullife.com ([216.156.138.34]:32269 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S278292AbRJMOGF>;
	Sat, 13 Oct 2001 10:06:05 -0400
Message-ID: <3BC84A6B.C788C477@colorfullife.com>
Date: Sat, 13 Oct 2001 16:06:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Corrupt ext2/ext3 directory entries not recovered by e2fsck
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> I forgot to mention that both fsck.ext2 and fsck.ext3 report
> 
> 1: Entry 'sendmail.pid' in /var/run (686849) has
>		deleted/unused inode 688415.  CLEARED.
> /1: Entry 'crond.pid' in /var/run (686849) has
>		deleted/unused inode 688416.  CLEARED.
> /1: Entry 'xfs.pid' in /var/run (686849) has
>		deleted/unused inode 688417.  CLEARED.
> /1: Entry 'atd.pid' in /var/run (686849) has
>		deleted/unused inode 688418.  CLEARED.
> 
All inodes are in the same sector.
Could you try out if that sector is destroyed?

One of my broken harddisks showed similar behaviour:
* write operations succeeded.
* read operations immediately after the write (write 16 MB including the
damaged sector, then read all 16 MB) sometimes succeeded.
* read operations after 5 minutes always failed.

--
	Manfred
