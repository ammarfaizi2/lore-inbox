Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbSKLJdz>; Tue, 12 Nov 2002 04:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbSKLJdz>; Tue, 12 Nov 2002 04:33:55 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:6016 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S266353AbSKLJdy> convert rfc822-to-8bit; Tue, 12 Nov 2002 04:33:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Jens Axboe <axboe@suse.de>, Giuliano Pochini <pochini@shiny.it>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Date: Tue, 12 Nov 2002 20:40:05 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
References: <3DD046BD.799F36D4@digeo.com> <XFMail.20021112095219.pochini@shiny.it> <20021112092045.GB832@suse.de>
In-Reply-To: <20021112092045.GB832@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211122040.13414.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>On Tue, Nov 12 2002, Giuliano Pochini wrote:
>> On 12-Nov-2002 Andrew Morton wrote:
>> > Con Kolivas wrote:
>> >> io_load:
>> >> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> >> 2.4.18 [3]              474.1   15      36      10      6.64
>> >> 2.4.19 [3]              492.6   14      38      10      6.90
>> >> 2.5.46 [1]              600.5   13      48      12      8.41
>> >> 2.5.46-mm1 [5]          134.3   58      6       8       1.88
>> >> 2.5.47 [3]              165.9   46      9       9       2.32
>> >> 2.5.47-mm1 [5]          126.3   61      5       8       1.77
>> >
>> > We've increased the kernel build speed by 3.6x while decreasing the
>> > speed at which writes are retired by 5.3x.
>>
>> Did the elevator change between .46 and .47 ?
>
>No, but the fifo_batch count (which controls how many requests are moved
>sort list to dispatch queue) was halved. This gives lower latency, at
>the possible cost of dimishing throughput.

Preempt also lowered this value, and ReiserFS changes may have affected it 
further (test machine running Reiser).

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE90Mx4F6dfvkL3i1gRAtNhAKCfIDch3dTao94+xTpEUDDYHkZFTQCdEeX9
280PvEgXnJDt4RxByJX/pnM=
=ct+I
-----END PGP SIGNATURE-----

