Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269836AbRHGA7U>; Mon, 6 Aug 2001 20:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270019AbRHGA7K>; Mon, 6 Aug 2001 20:59:10 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:65114 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S269836AbRHGA66>;
	Mon, 6 Aug 2001 20:58:58 -0400
Message-ID: <20010807025913.A13266@win.tue.nl>
Date: Tue, 7 Aug 2001 02:59:13 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "C. Linus Hicks" <lhicks@nc.rr.com>, <Remy.Card@linux.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mkfs wrote to wrong partition
In-Reply-To: <006a01c11dce$b4338bb0$0a0a0a0a@k-6_iii-400.mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <006a01c11dce$b4338bb0$0a0a0a0a@k-6_iii-400.mindspring.com>; from C. Linus Hicks on Sun, Aug 05, 2001 at 12:50:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 12:50:16PM -0400, C. Linus Hicks wrote:

> The point of the following exercise was to move from a single CPU 400Mhz
> system to a dual 600Mhz and from an IDE disk to SCSI. I already had Redhat
> 7.1 with a 2.4.6 kernel running on the dual 600 and was replacing it with
> the system from the 400Mhz IDE system. All operations were performed on the
> dual 600.
> 
> While running the system booted with root=/dev/sda2 I made partitions on
> /dev/sdb just like on /dev/sda, then copied all files over. I modified the
> lilo.conf in /etc on /dev/sda2 to have boot=/dev/sdb and set the
> root=/dev/sdb2 for each image. I ran lilo then booted the system.
> 
> The system looked like I expected it to: mount showed /dev/sdb2 mounted as
> the root filesystem.

Note that this does not mean a thing:
If /etc/mtab is a link to /proc/mounts (bad idea) then the root fs is
usually just called /dev/root. Otherwise, mount will guess at the
appropriate name for the root filesystem by taking the one in /etc/fstab.

So, when mount showed /dev/sdb2 as root, this meant that you had
changed the root entry in /etc/fstab.

Probably you forgot to run lilo and booted the old kernel.
