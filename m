Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278097AbRJKFHN>; Thu, 11 Oct 2001 01:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278098AbRJKFHF>; Thu, 11 Oct 2001 01:07:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7394 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278096AbRJKFGv>;
	Thu, 11 Oct 2001 01:06:51 -0400
Date: Thu, 11 Oct 2001 01:07:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
Message-ID: <Pine.GSO.4.21.0110110106070.21168-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>  I recompiled (I used the same .10 conf) and rebooted, but my reboot halted 
>because /dev/sda9 didnt exist.  I checked this in fdisk, and it didnt see it. 
> I rebooted to the 2.4.10 kernel, and sda9 was there.  What happened?

Information from fdisk would help - from both versions (with 2.4.11 you'll
need to boot with init=/bin/sh, obviously).  It may be a bug in partition
code, it may be something fishy with guessing geometry (SCSI uses bread()
for that) and it may be something fishy in block devices in pagecache stuff.

If you have sfdisk, sfdisk /dev/sda -O /tmp/foo + mailing the result would
make debugging the thing much simpler (that one - from the 2.4.10).


