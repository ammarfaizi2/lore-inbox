Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264629AbSKIDtH>; Fri, 8 Nov 2002 22:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSKIDtH>; Fri, 8 Nov 2002 22:49:07 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:12416 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S264629AbSKIDtG> convert rfc822-to-8bit; Fri, 8 Nov 2002 22:49:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Date: Sat, 9 Nov 2002 14:54:57 +1100
User-Agent: KMail/1.4.3
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <200211090444.44658.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <200211090444.44658.Dieter.Nuetzel@hamburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211091454.59322.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>Andreww Morton wrote:
>> Con Kolivas wrote:
>> > io_load:
>> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> > 2.4.18 [3]              474.1   15      36      10      6.64
>> > 2.4.19 [3]              492.6   14      38      10      6.90
>> > 2.4.19-ck9 [2]          140.6   49      5       5       1.97
>> > 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
>> > 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86
>>
>> 2.4.20-pre3 included some elevator changes.  I assume they are the
>> cause of this.  Those changes have propagated into Alan's and Andrea's
>> kernels.   Hence they have significantly impacted the responsiveness
>> of all mainstream 2.4 kernels under heavy writes.
>>
>> (The -ck patch includes rmap14b which includes the read-latency2 thing)
>
>No, the 2.4.19-ck9 that I have (the default?) include -AA and preemption
> (!!!)

Err I made the ck patchset so I think I should know. ck9 came only as one 
patch which included O(1),Low Latency, Preempt, Compressed Caching, 
Supermount, ALSA and XFS. CK10-13 on the otherhand had optional Compressed 
Caching OR AA OR Rmap. By default since they are 2.4 kernels they all include 
the vanilla aa vm, but the ck trunk with AA has the extra AA vm addons only 
available in the -AA kernel set. If you disabled compressed caching in ck9 
you got only the vanilla 2.4.19 vm.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9zIcRF6dfvkL3i1gRAoEmAJ9DxKp9y+Jx11G+k+rcaMYKrVsM5gCgn5NH
nMwKh/nfafNt5kMvLpm+Bsg=
=YwE8
-----END PGP SIGNATURE-----

