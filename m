Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272935AbSISUgX>; Thu, 19 Sep 2002 16:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272936AbSISUgX>; Thu, 19 Sep 2002 16:36:23 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:59560 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S272935AbSISUgW>;
	Thu, 19 Sep 2002 16:36:22 -0400
Message-ID: <3D8A3654.50201@us.ibm.com>
Date: Thu, 19 Sep 2002 13:40:52 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bond, Andrew" <Andrew.Bond@hp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TPC-C benchmark used standard RH kernel
References: <45B36A38D959B44CB032DA427A6E106402D09E43@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bond, Andrew wrote:
 > This isn't as recent as I would like, but it will give you an idea.
 > Top 75 from readprofile.  This run was not using bigpages though.
 >
 > 00000000 total                                      7872   0.0066
 > c0105400 default_idle                               1367  21.3594
 > c012ea20 find_vma_prev                               462   2.2212
 > c0142840 create_bounce                               378   1.1250
 > c0142540 bounce_end_io_read                          332   0.9881
 > c0197740 __make_request                              256   0.1290
 > c012af20 zap_page_range                              231   0.1739
 > c012e9a0 find_vma                                    214   1.6719
 > c012e780 avl_rebalance                               160   0.4762
 > c0118d80 schedule                                    157   0.1609
 > c010ba50 do_gettimeofday                             145   1.0069
 > c0130c30 __find_lock_page                            144   0.4500
 > c0119150 __wake_up                                   142   0.9861
 > c01497c0 end_buffer_io_kiobuf_async                  140   0.6250
 > c0113020 flush_tlb_mm                                128   1.0000
 > c0168000 proc_pid_stat                               125   0.2003

Forgive my complete ignorane about TPC-C...  Why do you have so much 
idle time?  Are you I/O bound? (with that many disks, I sure hope not 
:) )  Or is it as simple as leaving profiling running for a bit before 
or after the benchmark was run?

Earlier, I got a little over-excited because I thinking that the 
machines under test were 8-ways, but it looks like the DL580 is a 
4xPIII-Xeon, and you have 8 of them.  I know you haven't published it, 
but do you do any testing on 8-ways?

For most of our work (Specweb, dbench, plain kernel compiles), the 
kernel tends to blow up a lot worse at 8 CPUs than 4.  It really dies 
on the 32-way NUMA-Qs, but that's a whole other story...

-- 
Dave Hansen
haveblue@us.ibm.com

