Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269337AbUIYOLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269337AbUIYOLw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 10:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUIYOLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 10:11:52 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:55996 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S269337AbUIYOLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 10:11:50 -0400
Subject: Re: Sluggishness in 2.6.7 caused by IDE stack
From: Kenneth Johansson <ken@kenjo.org>
To: Scott A Crosby <scrosby@cs.rice.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <oydsm964jro.fsf@bert.cs.rice.edu>
References: <oydsm964jro.fsf@bert.cs.rice.edu>
Content-Type: text/plain
Date: Sat, 25 Sep 2004 16:11:25 +0200
Message-Id: <1096121485.2760.5.camel@tiger>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-25 at 07:26 -0500, Scott A Crosby wrote:
> Much of the CPU time was spent in system mode. I setup a quick
> oprofile, which blamed the function task_no_data_intr, but an
> opannotate reports confusing results, possibly from interrupts? dmesg
> reported nothing interesting.
> 
> 
> Scott
> 
> 
> *** vmstat output ***
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  1  1 410496   8520  14224 1253716    0    0  2180    16  409   633 10 43  0 48
>  7  1 410496   6920  14236 1255380    0    0  1668    20  589   832  9 18  0 73
>  3  0 410496   8264  14232 1253988    0    0  2436    80  334   438 18 82  0  0
>  0  1 410496   8384  14244 1253860    0    0  1932     0  464   706 13 35  0 52
>  5  1 410496   8056  14264 1253872  328    0  2280     0  717   965 14 20  0 65
>  8  1 410496   7352  14268 1254640    0    0  2692     0  351   485 17 83  0  0
>  2  2 410496   6968  14264 1255036   32    0  2336     0  332   522 17 83  0  0
>  5  0 410496   8568  14276 1253384    0    0  2192    12  464   794 19 33  0 48

I think you have the same problem as me. The interrupt rate drops under
1000 during use of the DVD and that is strange as the HZ is 1000 and
that should be the lowest possible value unless I misunderstood
something.  





