Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319482AbSIGM5V>; Sat, 7 Sep 2002 08:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319483AbSIGM5V>; Sat, 7 Sep 2002 08:57:21 -0400
Received: from 62-190-217-162.pdu.pipex.net ([62.190.217.162]:17671 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S319482AbSIGM5U>; Sat, 7 Sep 2002 08:57:20 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209071308.g87D8sii000799@darkstar.example.net>
Subject: Re: ide drive dying?
To: degger@fhm.edu (Daniel Egger)
Date: Sat, 7 Sep 2002 14:08:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1031401883.12089.41.camel@sonja.de.interearth.com> from "Daniel Egger" at Sep 07, 2002 02:31:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The tests showed bad sectors, i'm currently running a disk erase.
> 
> This is exactly the mistake I've been meaning to warn you of.
> The disk will corrupt sooner or later again and you'll have to go
> through all the torture (possible backup/restore, missing data) again
> and if you're unlucky (which is quite possible with your frequency of
> use) the warranty is void until the problems appear the next time.

There are two separate issues here, though:

* Buggy firmware
* Unreliable media

We have confirmed, (I believe), that the drive did have the buggy firmware.  We do not know yet whether the media is defective or not, but we do know that the drives are not the best in the world.

Alan also confirmed that the errors were direct from the device, and so it is not a kernel bug.

However, I raise the question of whether the new kernel version caused different access patterns to the device, and showed up the firmware bug that was there all the time.  Or maybe the compilation of the new kernel thrashed the disk and showed up the firmware bug.  If the machine has been on for some time, (months), doing not very much, maybe a lot of disk data was cached in RAM, and the kernel compile caused it to be re-read from disk, showing up media defects.

I was hoping that he would actually post the output of:

smartctl -a /dev/hda?

because that tells you all sorts of things, like, for example, reallocated sector count, and calibration retry count.

Obviously, it is not a good idea to use the drive for anything important until it has been tested in a non-critical application first.

Besides, you *do* backup, don't you?  (Or do what Linus suggested a while ago, and upload your stuff to an ftp site that is mirrored worldwide.)

I don't see the point of returning a disk that turns out not to be faulty after the firmware upgrade, for replacement under the warranty, even if it qualifies for a warranty replacement, (which it shouldn't do), because you might be exchanging a good disk for a bad disk.

John.
