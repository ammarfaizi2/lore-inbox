Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278630AbRKMTuQ>; Tue, 13 Nov 2001 14:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278639AbRKMTuG>; Tue, 13 Nov 2001 14:50:06 -0500
Received: from mail303.mail.bellsouth.net ([205.152.58.163]:56846 "EHLO
	imf03bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278630AbRKMTtx>; Tue, 13 Nov 2001 14:49:53 -0500
Message-ID: <3BF1794B.D5E584D0@mandrakesoft.com>
Date: Tue, 13 Nov 2001 14:49:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Differences between 2.2.x and 2.4.x initrd
In-Reply-To: <20011113143947.F329@visi.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> Basically what we have is a kernel image with ramdisk and initrd
> enabled, and a root disk image slapped on the end that is loaded via
> initrd.
> 
> On 2.2.x, this works without problems; the ramdisk is loaded, and
> /sbin/init is executed. However, with 2.4.x, it's quite different.
> 
> It loads the initial ramdisk, mounts it fine, tries to execute /linuxrc
> (same as in 2.2.x, but it isn't there, so it continues), and then
> complains with this:
> 
> VFS: Mounted root (ext2 filesystem).
> VFS: Cannot open root device "" or 02:00
> 
> For some reason it is trying to mount /dev/fd, and totally forgets
> about /dev/ram. If I pass root=/dev/ram to the command line, it works
> fine, but I don't want to have to do this :)

hrm, if your root filesystem is indeed in RAM, then root=/dev/ram seems
appropriate on both 2.2.x and 2.4.x.  That's what 2.2.x and 2.4.x
Documentation/initrd.txt seem to indicate to me, anyway.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

