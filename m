Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132614AbREIVPH>; Wed, 9 May 2001 17:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbREIVO6>; Wed, 9 May 2001 17:14:58 -0400
Received: from idiom.com ([216.240.32.1]:14603 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S132614AbREIVOy>;
	Wed, 9 May 2001 17:14:54 -0400
Message-ID: <3AF950C0.DA8D3BEA@namesys.com>
Date: Wed, 09 May 2001 07:14:25 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Podlejski <underley@witch.underley.eu.org>
CC: linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs> <20010509195357Z5310367-757+3@witch.underley.eu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Podlejski wrote:

> In linux-kernel, martin@bugs.unl.edu.ar wrote:
> :  We are waiting for a server with dual PIII, RAID 1,0 and 5 18Gb scsi disks to
> :  come so we can change our proxy server, that will run on Linux with Squid.
> :  One disk will go inside (I think?) and the other 4 on a tower conected to the
> :  RAID, which will be have the cache of the squid server.
>
> Reiser is not good idea for squid cache. Why ? Squids cache is hashed
> by default to minimize "big directory effect". Reiserfs is fast on
> realy big directories, but it eat more cpu than ext2. On high loaded
> cache servers cpu utilization on reiser can be realy big.
> Better way is make more subdirectories in squid cache, and use
> filesystem, that eat less of cpu.
>
> --
> Daniel Podlejski <underley@underley.eu.org>
>    ... I am immortal, I have inside me blood of kings,
>    I have no rival, No man can bemy equal ...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Nice theory, but the benchmarks say the opposite.  Turn off tails, use reiserfs
raw, and we are the fastest way to do squid, which is still way slower than the
proprietary solutions that don't use squid.  (squid's user space architecture is
poorly threaded, and that becomes the bottleneck.)

Hans

