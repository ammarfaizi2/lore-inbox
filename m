Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263249AbSKFKII>; Wed, 6 Nov 2002 05:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSKFKII>; Wed, 6 Nov 2002 05:08:08 -0500
Received: from web20502.mail.yahoo.com ([216.136.226.137]:34060 "HELO
	web20502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263249AbSKFKIH>; Wed, 6 Nov 2002 05:08:07 -0500
Message-ID: <20021106101445.42142.qmail@web20502.mail.yahoo.com>
Date: Wed, 6 Nov 2002 02:14:45 -0800 (PST)
From: vasya vasyaev <vasya197@yahoo.com>
Subject: RE: Machine's high load when HIGHMEM is enabled
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000F2ED497@fmsmsx103.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
It seems "mem=2016M" is what we need, box works
approximately as fast as without enabled HIGHMEM.
Thank you!

BTW, we are using 4x512 Mb ECC Registered memory
modules, so they seems not to be mixed...



As this problem has gone, there is last question (I
hope ;-):
How can I control amount of memory used for disk cache
in recent kernels (2.4.18, 19)?
("Cached:" field in `cat /proc/meminfo`)
I have to be sure that free memory is not used for
caching of disk operations (or how many of it is used
for caching)

Thanks and please CC.



--- "Nakajima, Jun" <jun.nakajima@intel.com> wrote:
> To me it looks this MTRR does not cover the memory
> range reported by E820.
> 
> > reg05: base=0x7c000000 (1984MB), size=  32MB:
> > write-back, count=1
> 
> This covers [0x7c000000 - 0x7e000000).
> 
> >  BIOS-e820: 0000000000100000 - 000000007f800000
> > (usable)
> But it says memory is available up to 0x7f800000. 
> So try mem=2016M ?  
> (2048 - 32 = 2016)
> 
> I guess you are mixing various memory modules.
> 
> Jun


__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/
