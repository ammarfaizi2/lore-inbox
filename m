Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTELHrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 03:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTELHrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 03:47:06 -0400
Received: from dialup-5.156.221.203.acc50-nort-cbr.comindico.com.au ([203.221.156.5]:33028
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261985AbTELHrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 03:47:05 -0400
Message-ID: <3EBF538B.50501@cyberone.com.au>
Date: Mon, 12 May 2003 17:55:55 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.69-mm3 with contest
References: <200305111655.35543.kernel@kolivas.org>
In-Reply-To: <200305111655.35543.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

snip

>io_load:
>Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
>2.5.68              3   492     15.9    167.1   19.7    6.23
>2.5.68-mm1          4   128     59.4    47.6    19.4    1.62
>2.5.68-mm2          4   131     58.8    47.0    18.9    1.64
>2.5.68-mm3          4   271     28.4    89.2    17.9    3.39
>2.5.69              4   343     22.7    120.5   19.8    4.29
>2.5.69-mm3          4   319     24.5    105.3   18.1    4.04
>
snip

>
>dbench_load:
>Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
>2.5.68              3   412     18.4    5.3     47.6    5.22
>2.5.68-mm1          4   361     21.1    5.5     54.0    4.57
>2.5.68-mm2          4   345     22.0    4.8     49.3    4.31
>2.5.68-mm3          4   721     10.5    6.8     33.6    9.01
>2.5.69              4   374     20.3    5.0     48.1    4.67
>2.5.69-mm3          4   653     11.6    6.2     34.0    8.27
>
>Very similar to 2.5.68-mm3
>
Thanks again Con. These two benchmarks especially are fairly suboptimal
compared with the 68-mm2 days... I hope it is just the larger request queue
size in place in the rq-dyn patch in mm. If you get some time, could you
possibly change include/linux/blkdev.h:BLKDEV_MAX_RQ from 1024 to 128 and
bench these two loads on that setting.

Cheers,
Nick

