Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSKFQor>; Wed, 6 Nov 2002 11:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSKFQor>; Wed, 6 Nov 2002 11:44:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:5821 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265815AbSKFQoq>;
	Wed, 6 Nov 2002 11:44:46 -0500
Message-ID: <3DC94885.AD5B8A3B@digeo.com>
Date: Wed, 06 Nov 2002 08:51:17 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vasya vasyaev <vasya197@yahoo.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine's high load when HIGHMEM is enabled
References: <F2DBA543B89AD51184B600508B68D4000F2ED497@fmsmsx103.fm.intel.com> <20021106101445.42142.qmail@web20502.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 16:51:17.0840 (UTC) FILETIME=[B9D8DD00:01C285B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vasya vasyaev wrote:
> 
> Hello,
> It seems "mem=2016M" is what we need, box works
> approximately as fast as without enabled HIGHMEM.
> Thank you!
> 
> BTW, we are using 4x512 Mb ECC Registered memory
> modules, so they seems not to be mixed...

For some reason your mtrr table was not covering the last 32 megabytes
of memory.  Probably you could also have fixed this by altering the
mtrr settings.  See Documentation/mtrr.txt in the kernel source tree.

> As this problem has gone, there is last question (I
> hope ;-):
> How can I control amount of memory used for disk cache
> in recent kernels (2.4.18, 19)?
> ("Cached:" field in `cat /proc/meminfo`)
> I have to be sure that free memory is not used for
> caching of disk operations (or how many of it is used
> for caching)

You have to use it for something else :)

Sorry, Linux will only leave a few megabytes of memory unused,
for emergency and interrupt-time allocations.

Why is this a problem?
