Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312895AbSDOFqr>; Mon, 15 Apr 2002 01:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312913AbSDOFqq>; Mon, 15 Apr 2002 01:46:46 -0400
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:56517 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S312895AbSDOFqp>;
	Mon, 15 Apr 2002 01:46:45 -0400
Message-ID: <3CBA6943.4000701@tmsusa.com>
Date: Sun, 14 Apr 2002 22:46:43 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
CC: J Sloan <joe@tmsusa.com>
Subject: Re: 2.5.8 final - another data point
In-Reply-To: <3CB9EF57.6010609@tmsusa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:

> Observations -
>
> The up-fix for the setup_per_cpu_areas compile
> issue apparently didn't make it into 2.5.8-final,
> so we had to apply the patch from 2.5.8-pre3
> to get it to compile.
>
> That said, however, everything works, all services
> are running, all devices working, Xfree is happy.

Stop me if you've heard this one before -

But there is one additional observation:

dbench performance has regressed significantly
since 2.5.8-pre1; the performance is equivalent
up to 8 instances, but at 16 and above, 2.5.8 final
takes a nosedive. Performance at 128 instances
is approximately 20% of the throughput of
2.5.8-pre1 - which is in turn not up to 2.4.xx
performance levels. I realize that the BIO has
been through heavy surgery, and nowhere near
optimized, but this is just a data point...

hdparm -t shows normal performance levels,
for what it's worth

2.5.8-pre1
--------------
Throughput 151.152 MB/sec (NB=188.94 MB/sec  1511.52 MBit/sec)  1 procs
Throughput 152.177 MB/sec (NB=190.221 MB/sec  1521.77 MBit/sec)  2 procs
Throughput 151.965 MB/sec (NB=189.957 MB/sec  1519.65 MBit/sec)  4 procs
Throughput 151.068 MB/sec (NB=188.835 MB/sec  1510.68 MBit/sec)  8 procs
Throughput 43.0191 MB/sec (NB=53.7738 MB/sec  430.191 MBit/sec)  16 procs
Throughput 9.65171 MB/sec (NB=12.0646 MB/sec  96.5171 MBit/sec)  32 procs
Throughput 37.8267 MB/sec (NB=47.2833 MB/sec  378.267 MBit/sec)  64 procs
Throughput 14.0459 MB/sec (NB=17.5573 MB/sec  140.459 MBit/sec)  80 procs
Throughput 16.2971 MB/sec (NB=20.3714 MB/sec  162.971 MBit/sec)  128 procs

2.5.8-final
---------------
Throughput 152.948 MB/sec (NB=191.185 MB/sec  1529.48 MBit/sec)  1 procs
Throughput 151.597 MB/sec (NB=189.497 MB/sec  1515.97 MBit/sec)  2 procs
Throughput 150.377 MB/sec (NB=187.972 MB/sec  1503.77 MBit/sec)  4 procs
Throughput 150.159 MB/sec (NB=187.698 MB/sec  1501.59 MBit/sec)  8 procs
Throughput 7.25691 MB/sec (NB=9.07113 MB/sec  72.5691 MBit/sec)  16 procs
Throughput 6.36332 MB/sec (NB=7.95415 MB/sec  63.6332 MBit/sec)  32 procs
Throughput 5.55008 MB/sec (NB=6.9376 MB/sec  55.5008 MBit/sec)  64 procs
Throughput 5.82333 MB/sec (NB=7.27916 MB/sec  58.2333 MBit/sec)  80 procs
Throughput 3.40741 MB/sec (NB=4.25926 MB/sec  34.0741 MBit/sec)  128 procs







