Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRKJRlp>; Sat, 10 Nov 2001 12:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278163AbRKJRlf>; Sat, 10 Nov 2001 12:41:35 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:39825 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277532AbRKJRlW>; Sat, 10 Nov 2001 12:41:22 -0500
Date: Sat, 10 Nov 2001 18:41:15 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.hbh.net
To: arjan@fenrus.demon.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: Numbers: ext2/ext3/reiser Performance (ext3 is slow)
In-Reply-To: <E162ZQN-00069u-00@fenrus.demon.nl>
Message-ID: <Pine.LNX.4.40.0111101831440.14552-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.27)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001 arjan@fenrus.demon.nl wrote:
> ext3 by default imposes stricter ordering than the other journalling
> filesystems in order to improve _data_ consistency (as opposed to just
> the guarantee of consistent metadata as most other filesystems do).
> if you mount the filesystem with
>
> mount -t ext3 -o data=writeback /dev/foo /mnt/bar
>
> will make it use the same level of guarantee as reiserfs does.
>
> mount -t ext3 -o data=journal /dev/foo /mnt/bar

test with writeback and journal a already running. But this will take some
time. as far as i can tell now writeback is really much faster.
The question is, when to use what mode. I would use data=journal on my
CVS-Archive, and maybe writeback on a news-server.
But what to use for an database like mysql ?
Someone mailed me and asked why use a journal for an database ?
Well, I think for speed of reboot after failover or crash.
I don't know if mysql journals data  itself.

Oktay Akbal


