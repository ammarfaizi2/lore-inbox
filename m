Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTJVBnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 21:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263329AbTJVBnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 21:43:31 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:39093 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263295AbTJVBn3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 21:43:29 -0400
Message-ID: <3F95E0C3.6050608@cyberone.com.au>
Date: Wed, 22 Oct 2003 11:43:31 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, ricklind@us.ibm.com
Subject: Re: Nick's scheduler v16
References: <3F913704.5040707@cyberone.com.au> <56890000.1066770968@flay>
In-Reply-To: <56890000.1066770968@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>I'm starting to do some large SMP / NUMA testing. Fixed and changed quite
>>a bit. It isn't too bad, although I'm only testing dbench, tbench, and
>>volanomark at the moment.
>>
>>These SMP and NUMA changes are not tied to my interactivity stuff, so its
>>possible they could get included if they turn out well. If you find any
>>problems with it (high end or interactivity), please let me know.
>>
>
>Interesting ... some things get getter, some worse:
>
>Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
>                              Elapsed      System        User         CPU
>              2.6.0-test8       45.20      100.97      566.65     1476.25
>         2.6.0-test8-nick       44.81       93.98      568.49     1477.50
>        2.6.0-test8-nick2       44.78       94.69      568.81     1482.00
>
>elapsed is a tiny bit faster, system is significantly less, but with
>higher parallelism:
>
>
>Kernbench: (make -j vmlinux, maximal tasks)
>                              Elapsed      System        User         CPU
>              2.6.0-test8       45.86      119.41      569.66     1502.00
>         2.6.0-test8-nick       47.00      112.75      590.40     1495.00
>        2.6.0-test8-nick2       47.11      112.86      590.31     1491.50
>
>elapsed is definitely worse now.
>

I'll see if I can reproduce this and work out what is going on.
Thanks Martin.


