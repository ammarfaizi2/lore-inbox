Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318916AbSICUm4>; Tue, 3 Sep 2002 16:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318917AbSICUm4>; Tue, 3 Sep 2002 16:42:56 -0400
Received: from hacksaw.org ([216.41.5.170]:35999 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S318916AbSICUmx>; Tue, 3 Sep 2002 16:42:53 -0400
Message-Id: <200209032050.g83Ko1CW019969@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-reply-to: Your message of "Tue, 03 Sep 2002 14:34:13 MDT."
             <Pine.LNX.4.44.0209031423260.3373-100000@hawkeye.luckynet.adm> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 16:50:01 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > But more importantly, I want controllers that survive total power down.
> 
> You can't get that with partition tables either. And by the way, we 

WHAT? Partition tables written onto the disk certainly do survive total power 
down.

> 
> Then give them two logical disks. Just a matter of management.

Again, with an annoying controller, and having the user change their 
requirements every so often (like once a day), I do not want to change the 
RAID setup lots. The last RAID I was working with took up to an hour to commit 
geometry changes to the disk.

> Yes, that's cool in case we'd possibly need one. But in the raid cases we 
> should get to a position where partition tables are not just theoretically 
> meaningless.

Again, I wouldn't want to depend on that, for the reasons above.

> I've still not said you'd have to do that. You can have a perl script do 
> your job scribbling the table together.

Please describe this algorithm? Would this potentially mean looking at every 
block on the disk, including the giant logical disk that a RAID might present? 
Even if you only have to look at the first few bytes of each block, this is a 
lot of seeking.
-- 
A decision changes the world.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


