Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSLHChA>; Sat, 7 Dec 2002 21:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSLHChA>; Sat, 7 Dec 2002 21:37:00 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:34308 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S265108AbSLHChA>; Sat, 7 Dec 2002 21:37:00 -0500
Date: Sat, 7 Dec 2002 21:47:13 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Anu <avaidya@unity.ncsu.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: writing to raw device
In-Reply-To: <Pine.GSO.4.44.0212072056460.7992-100000@sun.cesr.ncsu.edu>
Message-ID: <Pine.LNX.4.44.0212072144410.717-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Dec 2002, Anu wrote:

> ok -- what I meant is this:
>
> I have a software RAID-5 array with 5 disks (sdd1,2,3,4, sdb1,2) and one
> parity disk.. (sdb2). the device is md0.
>
> I am trying to see if I can figure out the stripe size of the raid-5
> (although I already know it because i configured it) by writing
> consecutively larger blocks on the "/dev/md0" file.. But, I have some
> bizare and random errors (I should get neat dips in the curve once it hits
> the stripe size -- but at best, what I currently get is random).

The first problem you're going to have is that putting multiple RAID
'physical devices' on the same disk will make your performance go to shit.
Try it with just one partition per disk.

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu


