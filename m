Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280898AbRKCAtg>; Fri, 2 Nov 2001 19:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280899AbRKCAtZ>; Fri, 2 Nov 2001 19:49:25 -0500
Received: from intra.cyclades.com ([209.81.55.6]:50447 "HELO
	intra.cyclades.com") by vger.kernel.org with SMTP
	id <S280898AbRKCAtM>; Fri, 2 Nov 2001 19:49:12 -0500
Date: Fri, 2 Nov 2001 16:51:44 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Annoying msgs about hda
Message-ID: <Pine.LNX.4.30.0111021629480.742-100000@intra.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

[*** Please CC your answer to me directly, as I'm currently not subscribed
to lkml ***]

I'm building a tiny Linux system of my own (no distro, although I'm using
Debian as a "sample"), which boots from a CompactFlash and uncompresses a
RAMDisk into RAM. The CompactFlash remains usually unmounted (except
during boot, when I want to save the system's configuration, upgrade the
RAMDIsk image, etc.). I'm using kernel 2.4.9.

I've noticed that every time I mount, fsck, or do any other "low-level"
access to the CompactFlash (which is seen as a HD, /dev/hda), I get the
following msgs:

# mount /flash/config
 hda: hda1 hda2 hda3  <--+---- These msgs (yes, they always show up twice)
 hda: hda1 hda2 hda3  <--+
#


If I place the _same_ CF in a Debian Potato system using the same kernel,
I don't get these msgs when mounting the CF. I'm pretty sure these msgs
come from the kernel (I believe from the check_partition() function on
linux/fs/partitions/check.c), but it's really annoying to get these msgs
every time I mount the device!!

Is there a way to prevent this?!?! Or ... why doesn't it happen on a
"regular" distro (like my Debian system)??

TIA for any advice/comment/insight.

Later,
Ivan

