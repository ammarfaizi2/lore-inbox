Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318852AbSICR6T>; Tue, 3 Sep 2002 13:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318897AbSICR5t>; Tue, 3 Sep 2002 13:57:49 -0400
Received: from hacksaw.org ([216.41.5.170]:7835 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S318861AbSICR5a>; Tue, 3 Sep 2002 13:57:30 -0400
Message-Id: <200209031804.g83I4YXC017714@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-reply-to: Your message of "Tue, 03 Sep 2002 11:23:01 MDT."
             <Pine.LNX.4.44.0209031118300.3373-100000@hawkeye.luckynet.adm> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 14:04:34 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The users who still need partition tables
My main gripe was my impression that you wanted to do away entirely with 
partition tables, which I am now taking as a misread.

I can certainly imagine a few different ways to have partition tables that 
make more sense than the typical Wintel version.

>Maybe divide the raid into smaller disks?!

Absolutely, if that is your requirement. I have done this. It gives you the 
usefulness of smaller disks with the speed and reliability of the RAID.

More importantly, The hardware should be considered largely immutable. For 
reliability reason, I want the hardware to have its settings in the safest 
manner possible, which means not taxing flash ram with too many rewrites. The 
place for the logical layout of the disks is in the partition table on the 
disk. One reason for this: what if the controller dies? In fact, I'd like the 
controller to store its RAID setup on the disk as well. Maybe even on all of 
them. Of course, if the partition equals the entire disk, great. The table 
will be really short.

In fact, I want a number of backup partition tables (a la backup superblocks). 
If you've ever had 70 people waiting to be able to do any work while you try 
and restore a disk that had the partition table scribbled on, you appreciate 
what I am saying.
-- 
The highest quality of attention we may give is love.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


