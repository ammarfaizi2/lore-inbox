Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUA0Syu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUA0Syu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:54:50 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:55438 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265149AbUA0Sys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:54:48 -0500
Message-ID: <4016B3F0.1060804@samwel.tk>
Date: Tue, 27 Jan 2004 19:54:40 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org, lkv@isg.de
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle
 disks? (to allow spin-downs)
References: <Pine.LNX.3.96.1040127133932.11664B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1040127133932.11664B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Well, it's the o.p. system, not mine, but I don't see how noatime will
> help him, the atime shouldn't change unless he's doing disk access, and
> if he's doing disk access the disk will spin up anyway.

> The place noatime helps is when actually doing reads to open files, and
> getting an inode update free with every read. His problem is that
> something really is accessing the drive, and he won't get the desired
> spindown until that's addressed.

If something really is accessing the drive, noatime might still help as 
long as the accesses are from the cache. BTW, it wasn't clear to me from 
his posts that he knows that something is _really_ accessing the drive, 
I thought he only had kjournald activity -- and that might be explained 
by atime updates. But I might have missed something of course!

> I hope the original poster is following this ;-)

I added him to the CC list again. That should fix it. :)

-- Bart
