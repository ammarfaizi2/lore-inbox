Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318781AbSICTeK>; Tue, 3 Sep 2002 15:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318802AbSICTeK>; Tue, 3 Sep 2002 15:34:10 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:22145 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318781AbSICTeJ>; Tue, 3 Sep 2002 15:34:09 -0400
Date: Tue, 3 Sep 2002 13:38:47 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Hacksaw <hacksaw@hacksaw.org>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-Reply-To: <200209031804.g83I4YXC017714@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.44.0209031324340.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Sep 2002, Hacksaw wrote:
> >The users who still need partition tables
> 
> My main gripe was my impression that you wanted to do away entirely with 
> partition tables, which I am now taking as a misread.
> 
> I can certainly imagine a few different ways to have partition tables that 
> make more sense than the typical Wintel version.

Certainly. But there are some uses where you absolutely don't want them. 
Also are there lots of uses where you can't do away with the tight thing 
DOS gives you for i386. I'm happily using Sunish slices there.

> >Maybe divide the raid into smaller disks?!
> 
> Absolutely, if that is your requirement. I have done this. It gives you
> the usefulness of smaller disks with the speed and reliability of the
> RAID.

Possibly, but you can even put together smaller arrays then (at least on a 
sane controller). That's what the disk size setup is for. And that's, 
after all, nothing the OS needs to take care of. It just gets to see say 
16 disks of 1 TiB size each. Nothing mad.

But why have a partition table on each of these 16 pseudo disks?

> More importantly, The hardware should be considered largely immutable.

Why? There's a reason why raid is mutable.

> One reason for this: what if the controller dies?

I plug another in here and restore.

> In fact, I'd like the controller to store its RAID setup on the disk as
> well. Maybe even on all of them.

I don't see how partitioning could help you out here.

> Of course, if the partition equals the entire disk, great. The table
> will be really short.

...and pointless.

> If you've ever had 70 people waiting to be able to do any work while you
> try and restore a disk that had the partition table scribbled on, you
> appreciate what I am saying.

Well, there's absolutely no need to do that. There are tools which can
scribble together the old table, and these could even kick automagically.  
(Who else thinks the BIOS shall always be replaced with something sane?)
Once your table is restored, good luck.

On the i386 boxes that we run (recently reduced to 20) I don't change too 
much about the tables. I can use a perl script from a boot cd to scribble 
them together again. And here I agree with partition tables, because I 
mostly haven't got more than two disks -- and I need to have space for
swap, housings, workspace and the entire root.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

