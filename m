Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313102AbSDOIOj>; Mon, 15 Apr 2002 04:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313109AbSDOIOj>; Mon, 15 Apr 2002 04:14:39 -0400
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:28358 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S313102AbSDOIOh>;
	Mon, 15 Apr 2002 04:14:37 -0400
Message-ID: <3CBA8BEC.4090707@tmsusa.com>
Date: Mon, 15 Apr 2002 01:14:36 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 final - another data point
In-Reply-To: <3CB9EF57.6010609@tmsusa.com> <3CBA6943.4000701@tmsusa.com> <3CBA7EC4.BA148E80@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>It's not related to BIO.  dbench is all about higher-level
>memory management, high-level IO scheduling and butterfly
>wings.
>
Yes, no doubt and a lot of other deep magic
which is only dimly perceived by the likes
of yours truly....

>>
>>Throughput 150.159 MB/sec (NB=187.698 MB/sec  1501.59 MBit/sec)  8 procs
>>Throughput 7.25691 MB/sec (NB=9.07113 MB/sec  72.5691 MBit/sec)  16 procs
>>Throughput 6.36332 MB/sec (NB=7.95415 MB/sec  63.6332 MBit/sec)  32 procs
>>
>
>It's obviously fallen over some cliff.  Conceivably the larger readahead
>window causes this.  How much memory does the machine have? 
>
The box has 512 MB RAM -

>`dbench 64'
>on a 512 meg setup certainly causes readahead thrashing.  You can
>stick a `printk("ouch");' into handle_ra_thrashing() and watch it...
>
hmm - OK, will try that -

Just for giggles, same machine with 2.4.19-pre4-ac4 -

Throughput 150.979 MB/sec (NB=188.723 MB/sec  1509.79 MBit/sec)  1 procs
Throughput 150.796 MB/sec (NB=188.496 MB/sec  1507.96 MBit/sec)  2 procs
Throughput 151.185 MB/sec (NB=188.982 MB/sec  1511.85 MBit/sec)  4 procs
Throughput 141.255 MB/sec (NB=176.568 MB/sec  1412.55 MBit/sec)  8 procs
Throughput 105.066 MB/sec (NB=131.332 MB/sec  1050.66 MBit/sec)  16 procs
Throughput 69.3542 MB/sec (NB=86.6928 MB/sec  693.542 MBit/sec)  32 procs
Throughput 32.4904 MB/sec (NB=40.613 MB/sec  324.904 MBit/sec)  64 procs
Throughput 30.4824 MB/sec (NB=38.103 MB/sec  304.824 MBit/sec)  80 procs
Throughput 19.0265 MB/sec (NB=23.7832 MB/sec  190.265 MBit/sec)  128 procs

>
>
>Patience.  2.5.later-on will perform well.  :)
>
Oh, yes -

It's already quite usable for some workloads, and the
latency for workstation use is quite good -  I am looking
forward to the maturation of this diamond in the rough

:-)

Joe


