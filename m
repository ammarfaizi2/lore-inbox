Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRI2Vyc>; Sat, 29 Sep 2001 17:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269326AbRI2VyX>; Sat, 29 Sep 2001 17:54:23 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:21220 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S268861AbRI2VyN>; Sat, 29 Sep 2001 17:54:13 -0400
Date: Sat, 29 Sep 2001 18:01:10 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: boot/root floppies in modern times?
Message-ID: <Pine.LNX.4.33.0109291737270.1713-100000@clubneon.clubneon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a few people on l-k know, I run my own custom Linux install on my
machines.  I followed the same route as a few others, started out with a
Slackware install (version 3.4 was the last I installed) and gradually
recompiled everything as new versions came out, mutated verious scripts,
eventually I had a system that did not have one file in common with the
orginal.

I've even come up with a crude install process that lets me take my base
installation and copy onto a new machine using NFS.

Coming from the Slackware world I made myself a set of boot and root
floppies.  The boot one gets a custom kernel tailored for the machine that
I'm going to install on, the root is pretty generic, with just enough
tools to partition, format, mount, and copy.

Also following in Slackware's footsteps, I use a compressed ramdisk on my
root floppy.  This has worked just fine until today.

I got a new Thinkpad, it doesn't have an internal floppy drive.  Instead
it has a USB floppy.  It can boot from the floppy just fine, I can get my
custom boot disk's kernel loaded.  But when it comes to loading the root
image I run into trouble.

I've made a lot of headway today, but it has taken me 4 hours to get this
far and it is almost dinner time, so I figured I'd post here before I beat
my head too much more.

Obviously (but not to me initally) the USB floppy isn't a real floppy
controlled by a floppy controller, but it is a USB mass storage device.
Got the kernel seeing that much, finds a SCSI0 and has the floppy
attatched to it.  Because it doesn't have a partition table, I'm assuming
the kernel is going to want me to mount /dev/sda.  But I'm not certain,
cause I've never used a laptop running Linux let alone messed with a USB
floppy, so I'm feeling around rather blindly trying to pass the right
root= to the kernel in an attempt to get something mounted.

But then I run into more trouble, cause the normal parameters for mounting
a gziped root image from a floppy don't work with SCSI devices.  For one
it won't wait for me to flop disks.  I have fast fingers so that isn't a
problem, I can change disks while the kernel is booting.  But I have a
feeling I'm barking up the wrong tree here.

I've seen the initrd option in the kernel config along with the other RAM
disk stuff.  I have a feeling that is the path I'm going to need to go
down, but I've never delt with it before (I know Linus is gung-ho about
initrd from posts I've seen by him here).  So I figure I'd better learn
about it sooner or later.

So anyway, this isn't super kernel releated, but I figured it was enough
that a post here wouldn't hurt too much (just this one has gone on longer
than I initially intended).  I'm just looking for any pointers or ideas,
to what has become an interesting problem to me.

Thanks a lot,
Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

