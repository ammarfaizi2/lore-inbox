Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbRB0Bj0>; Mon, 26 Feb 2001 20:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbRB0BjR>; Mon, 26 Feb 2001 20:39:17 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:43541 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129429AbRB0BjG>;
	Mon, 26 Feb 2001 20:39:06 -0500
Message-ID: <20010227023905.A17956@win.tue.nl>
Date: Tue, 27 Feb 2001 02:39:05 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: "Carlos Fernandez Sanz" <cfernandez@myalert.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: Problem creating filesystem
In-Reply-To: <11dd01c0a04e$98b92e60$f40237d1@MIACFERNANDEZ>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <11dd01c0a04e$98b92e60$f40237d1@MIACFERNANDEZ>; from Carlos Fernandez Sanz on Mon, Feb 26, 2001 at 06:48:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 06:48:16PM -0500, Carlos Fernandez Sanz wrote:

> I have just purchased a new HD and I'm getting problems creating a
> filesystem for it.  The HD is a Maxtor 80 Gb
> 
> Disk /dev/hde: 16 heads, 63 sectors, 15871 cylinders
> Units = cylinders of 1008 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hde1             1     15871   7998952+  83  Linux
> 
> Command (m for help): w
> The partition table has been altered!
> 
> Calling ioctl() to re-read partition table.
> 
> Syncing disks.
> ------------------
> When trying to create the filesystem, I get this:
> 
> [root@alhambra /sbin]# ./mke2fs /dev/hde1
> mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> /dev/hde1: Invalid argument passed to ext2 library while setting up
> superblock
> -------------------
> 
> I'm using
> Linux version 2.2.17-14 (root@porky.devel.redhat.com)

Reboot. Look at the boot messages. You should see your disk mentioned
and the partitions listed (hde: hde1).
If they disappear too quickly, say "dmesg | grep hde".

Test the size of hde1 with "blockdev --getsize /dev/hde1"
or "fdisk -s /dev/hde1" or so. If you get 0 that explains
the mke2fs error.

Make sure your tools are up to date. Old versions often have
an overflow somewhere.
