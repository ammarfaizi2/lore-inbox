Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281907AbRKZQTG>; Mon, 26 Nov 2001 11:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281908AbRKZQS4>; Mon, 26 Nov 2001 11:18:56 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:47109 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S281907AbRKZQSq>; Mon, 26 Nov 2001 11:18:46 -0500
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
In-Reply-To: <6893478.1006329318464.JavaMail.ground12@jippii.fi>
	<20011121111811.P1308@lynx.no>
	<200111261456.fAQEuDg01515@deathstar.prodigy.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 27 Nov 2001 01:17:43 +0900
In-Reply-To: <200111261456.fAQEuDg01515@deathstar.prodigy.com>
Message-ID: <87elmlo6ag.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davidsen@tmr.com (bill davidsen) writes:

> In article <E166e8A-0000t2-00@mrvdom02.schlund.de> linux-kernel@borntraeger.net wrote:
> | > > Machine booted ok and everything seemed to be ok, but i noticed a few
> | > > weird messages in boot messages right before mounting the root-partition:
> | > > FAT: bogus logical sector size 0
> | > > FAT: bogus logical sector size 0
> | > When the kernel is booting, it doesn't know the filesystem type of the
> | > root fs, so it tries to mount the root device using all of the compiled-in
> | > fs drivers, in the order they are listed in fs/Makefile.in.
> | > It appears that the fat driver doesn't even check for a magic when it
> | > starts trying to mount the filesystem, so it proceeds directly to
> | 
> | To be complete we should also apply this patch.
> 
> To be totally honest I think this is the wrong way to go. Like masking
> the symptoms instead of treating the disease. The problem is that the
> FAT driver seems to not check f/s type before claiming a f/s as its own.
> The better solution is to put in a check before going forward with using
> the f/s as FAT.

FAT doesn't have the field like the magic number, AFAIK.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
