Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318928AbSICVZM>; Tue, 3 Sep 2002 17:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSICVZM>; Tue, 3 Sep 2002 17:25:12 -0400
Received: from hacksaw.org ([216.41.5.170]:23456 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S318928AbSICVZL>; Tue, 3 Sep 2002 17:25:11 -0400
Message-Id: <200209032132.g83LWKOO020742@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-reply-to: Your message of "Tue, 03 Sep 2002 15:05:52 MDT."
             <Pine.LNX.4.44.0209031456210.3373-100000@hawkeye.luckynet.adm> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 17:32:20 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Disk-backed raid config storage can do that just as well. I don't really 
> think a partition table is the thing you'll want in order to store your 
> raid config.

Don't mix the two. I want the RAID to store it's configuration on disk. 
Additionally, I want the OS to be able to do what it wants with the disk, 
which may well mean logically dividing the disks presented by the RAID into 
logical partitions.

In fact, the two systems (RAID controller and OS) should not have anything to 
do with each other. The OS should just see disks, and the controller should 
just see raw data for it to put where ever the OS says to put it.

> As mentioned -- there may still be bad hardware out there. And why can't 
> the people just live with it? I mean you can't resize disks either.

Business requirement say you can't live with it. And yes you can resize disks, 
especially if you don't mind hosing the data thereon.

You 
> could even assign a number of disks of different size to the users, and if 
> one of them needs to get to another level of disk space, shall he. A pool 
> of disks can save you resizes.

We bought disk space like it was going out of style, but don't believe for an 
instant we had *any* left over. It was often assigned before we ever even got 
the disks in house. And when one guys wants his 20G as one big block, and 
another guy wants 5 4G slices, I have to accomodate him. And when he later 
wants his 5 slices made into two bigs ones, I have to be able to do that.

> (I still wonder how often you resize your partitions, per second.)

Not often. I probably changed disk setup once a week. Even still, I want it to 
take me almost zero time, and the RAID as a whole must remain up at all times, 
24/7.

> I was talking about saving your time. And I've presented the theory of no 
> partition tables on raid, which reduces the whole thing to backup work on 
> PC, or few seeking on small disks, up to 200 GiB. Yes, currently.

The theory doesn't match my experience. Maybe ten years from now it will. But 
I doubt it seriously. In ten years I think we'll have PC's shipping with 4TiB 
disks that are still damned slow.

And my time could include every developer. At $250 an hour, 70 idle developers 
= $17,500 for an hour of down time.
-- 
We recognise in others what we know most deeply in ourselves.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


