Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272118AbTHNAYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 20:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272121AbTHNAYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 20:24:30 -0400
Received: from law14-f91.law14.hotmail.com ([64.4.21.91]:3844 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S272118AbTHNAYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 20:24:22 -0400
X-Originating-IP: [194.85.81.178]
X-Originating-Email: [john_r_newbie@hotmail.com]
From: "John Newbie" <john_r_newbie@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: ide drives performance issues, maybe related with buffer cache.
Date: Thu, 14 Aug 2003 04:24:20 +0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law14-F91fXLhMIGwUY0002d5ea@hotmail.com>
X-OriginalArrivalTime: 14 Aug 2003 00:24:21.0240 (UTC) FILETIME=[68148780:01C361FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys!

Sorry for my post, but i didnt recieve answer on it after some googling & 
posting to local Linux Users Group, and i am confident that it is related 
with kernel.
I am using linux quite long, tried (&tired of) many FS's on different 
hardware, and think this behavior is common.
So question is : why when i am copying file from one HD to another (for 
simplicity from /hda to /hdb)
the speed fall down ? Starting from about 27-30 MB/s (drives are in UDMA-4, 
hdparm -X68) it drops
down to 11-12 MB/s after 4-5s. In *indows transfer rate is almost constant 
and about 20-22 MB/s (same hardware). Why the h#ll we suck?
I feel that it's due to buffer cache, because when you use sync (while 
copying) transfer rate is so small or even 0.
Drives are tuned with hdparm to highest transfer rates, readahead, multiple 
sector count (hdparm
for details).
Tried different filesystems, from classic ext2/3 to modern xfs/reiserfs. The 
same results.
Pure kernel from kernel.org (2.4.{19,20,21}), vendors kernels - all the 
same.
Doing experiments with 'sysctl -a |grep vm' values didnt resolve the 
problem.
This behavior is general, i think.
And, damn, this is very annoying for end users, for example when copying 
large files (movies,iso's).
Beyond any doubt this is very bad for IDE based file servers.

So please help me, and sorry if this post is offtopic.

==
Linux needs grouppies !
(inspired by Almost Famous & recent akpm interview)

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

