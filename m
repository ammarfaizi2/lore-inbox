Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTFEErZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 00:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTFEErZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 00:47:25 -0400
Received: from static-ctb-203-29-86-71.webone.com.au ([203.29.86.71]:13829
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264460AbTFEErX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 00:47:23 -0400
Message-ID: <3EDECE66.8040508@cyberone.com.au>
Date: Thu, 05 Jun 2003 15:00:22 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [BENCHMARK] AIM7 fserver regressed in 2.5.70*
References: <20030605024940.GA14406@rushmore>
In-Reply-To: <20030605024940.GA14406@rushmore>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



rwhron@earthlink.net wrote:

>Summary:
>AIM7 fileserver workload behaviour changed with 2.5.70.
>At low task counts (load average), 2.5.70* takes 40% 
>longer than 2.5.69.  As task count increases, regression
>disappears.
>
>Hardware has (4) 700 mhz P3 Xeons.
>3.75 GB RAM
>RAID 0 LUN (hardware raid)
>
>Background:
>AIM7 fserver is the only regressed workload.  In general, 
>2.5.70* has better numbers than 2.5.69* for a variety of
>benchmarks.
>
>
[snip]

>AIM7 fserver workload
>kernel             Tasks  Jobs/Min      Real       CPU
>2.5.69               4	 120.9	      200.5	  32.8
>2.5.69-bk1           4	 122.3	      198.2	  33.8
>2.5.69-mm3           4	 122.3	      198.3	  37.9
>2.5.69-mm5           4	 124.0	      195.5	  38.0
>
      ^^^^^^
I think this was the last kernel Joel tested before a
similar magnitude dropoff in WimMark performance.

>
>2.5.70               4	  79.0	      306.9	  34.2
>2.5.70-mjb1          4	  83.4	      290.8	  33.6
>2.5.70-mm3           4	  71.7	      338.0	  34.9
>2.5.70-mm4	     4    73.9        328.0       33.9
> 
>

I don't know what sort of disk IO fserver does, but it
could be the same problem.

