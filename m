Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSKKXUx>; Mon, 11 Nov 2002 18:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSKKXUx>; Mon, 11 Nov 2002 18:20:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:38383 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263188AbSKKXUw>;
	Mon, 11 Nov 2002 18:20:52 -0500
Message-ID: <3DD03CDC.562D7C0@digeo.com>
Date: Mon, 11 Nov 2002 15:27:24 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: CaT <cat@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 / unusual ext3 fs errors
References: <20021111231053.GA1518@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 23:27:24.0562 (UTC) FILETIME=[E3FB9720:01C289D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:
> 
> Under 2.5.x I seem to be getting a lot of fs errors on fsck, mainly
> dealing with bad inode counts in groups. Just now though, I had /var
> remounted read-only due to the following:
> 
> t_transaction: Journal has aborted
> EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
> EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
> EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
> ...
> EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
> EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
> EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
> 
> And again, on reboot into single user mode and a full fsck bad inode
> count errors were present. There were no errors detected whilst testing
> the disk with -c.

There was a problem in 2.5.46 which mucked up these counters.  On disk.

2.5.47 fixed that bug, and now you have fixed the on-disk mess which 2.5.46
created, all should be well.
