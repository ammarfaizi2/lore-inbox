Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbREWWOF>; Wed, 23 May 2001 18:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263292AbREWWNz>; Wed, 23 May 2001 18:13:55 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:1038 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S263291AbREWWNp>;
	Wed, 23 May 2001 18:13:45 -0400
Message-ID: <20010524001335.A11589@win.tue.nl>
Date: Thu, 24 May 2001 00:13:35 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Dave Mielke <dave@mielke.cc>
Cc: "Linux Kernel (mailing list)" <linux-kernel@vger.kernel.org>
Subject: Re: nfs mount by label not working.
In-Reply-To: <20010523231213.A11564@win.tue.nl> <Pine.LNX.4.30.0105231728430.995-100000@dave.private.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0105231728430.995-100000@dave.private.mielke.cc>; from Dave Mielke on Wed, May 23, 2001 at 05:34:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 05:34:22PM -0400, Dave Mielke wrote:

> I presume that you're assuming that my /proc/partitions is empty because its
> size shows as 0:
>
>     ls -l /proc/partitions
>     -r--r--r--   1 root     root            0 May 23 17:31 /proc/partitions

Ah, yes, sorry - I was too quick here.

> It does, however, have several lines in it.
>
>     cat /proc/partitions
>     major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq
>
>        3     0    6297480 hda      119 141 520 1790 0 0 0 0 0 1180 1790

But this is full of strange numbers that someone saw fit to add to /proc/partitions.
What a bad idea!

If someone changes /proc/partitions then probably the old utilities that used it
are broken. I do not have a memory, but it seems I recall fixing this already.
Try a recent mount, say from util-linux 2.11d.

[But you show IDE disks, but the subject line talks about NFS mounts?]

Andries
