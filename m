Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276397AbRJURfl>; Sun, 21 Oct 2001 13:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRJURfc>; Sun, 21 Oct 2001 13:35:32 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:11392 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S276411AbRJURfV>; Sun, 21 Oct 2001 13:35:21 -0400
Date: Mon, 22 Oct 2001 01:35:50 +0800 (PHT)
From: Federico Sevilla III <jijo@leathercollection.ph>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686b Bug - once again :(
In-Reply-To: <200110211326.PAA01192@mail.mwi-online.de>
Message-ID: <Pine.LNX.4.40.0110220126580.21933-100000@gusi.leathercollection.ph>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2001 at 13:26, Volker Dierks wrote:
> OK, 2 month ago, I bought a Abit KG7 MOBO (VIA 686b southbridge) and
> yesterday I ended up with the second data corruption within these two
> month.

Just so you know I've got an Asus motherboard also with the VIA 686b
Southbridge. I'm using 2.4.12-xfs and it's been doing pretty well. I don't
use the IDE controller on the drive that often (althoug the kernel is
built with support in particlar for the VIA chipset) as it's only for the
CD-ROM drive. I have a 3ware 6400 and four IBM hard drives.

First of all the IBM-DTLA-307030 drives are bad. Really bad. I've had one
hard drive (of four in hardware RAID5) go down a number of times already.
Fortunately the IBM DFT (Drive Fitness Tool) has been able to "repair" the
drive and so I'm still using it now.

I also ran into XFS corruption before, but this was because of a firmware
bug that got triggered when a drive went down during filesystem activity.
I flashed the firmware on the 3ware controller and the problem went away.
It had nothing to do with XFS or the kernel (although every 3ware firmware
upgrade comes with a driver upgrade and hence a kernel update).

> I'm going to buy a 3ware 6410(B) IDE raid controller .. can I suspect
> a failure safe system (in aspect to the 686b problems) when all discs
> are connected to the 3ware controller?

I recommend you get the 7xxx series instead. There are a number of
improvements there and you might overall be much happier with that.
Especially if you decide to go RAID5, as the 6xxx controller and buffer
are too small to do decent RAID5 (so the performance of my system sucks).

RAID is also not "failure safe". You still need regular backups. But it
helps because it allows you to recover from small hardware failure that
would otherwise have been significant. Like one hard drive going down.
Normally I have enough time to pull out the drive (I have a hot swap bay,
made in Taiwan or China, and the 3ware controller handles IDE hot swap
nicely), plug it in a workstation, reboot with the IBM DFT disk, and fix
it. Then I plug the drive back in and rebuild the array on the fly. This
whole process takes a few hours, but is hopefully invisible to most users
(although performance drops significantly because of the drive activity).

It's hard to get replacements from IBM in my country, though. So if the
DFT can't fix a drive some day, I'll just have to replace it. And with
RAID5, if any two drives go down at the same time (or one after the other
as long as you have more than one drive down), you're still dead. :(

Good luck.

 --> Jijo

--
Federico Sevilla III  :: jijo@leathercollection.ph
Network Administrator :: The Leather Collection, Inc.
GnuPG Key: <http://jijo.leathercollection.ph/jijo.gpg>

