Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVCTRAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVCTRAv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 12:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVCTRAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 12:00:51 -0500
Received: from jade.aracnet.com ([216.99.193.136]:7898 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261240AbVCTRAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 12:00:41 -0500
Date: Sun, 20 Mar 2005 09:00:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling changes in -mm tree
Message-ID: <533200000.1111338032@[10.10.2.4]>
In-Reply-To: <20050319140754.23d76496.akpm@osdl.org>
References: <505920000.1111249137@[10.10.2.4]> <20050319140754.23d76496.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Saturday, March 19, 2005 14:07:54 -0800):

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>> I don't think these are doing much for performance. Or at least 
>> *something* in your tree isn't ...
>> 
>> Kernbench: 
>>                                      Elapsed    System      User       CPU
>>  elm3b67      2.6.11                   50.24    146.60   1117.61   2516.67
>>  elm3b67      2.6.11-mm1               52.27    141.14   1099.91   2374.33
>>  elm3b67      2.6.11-mm2               51.88    142.41   1104.85   2403.67
>>  elm3b67      2.6.11-mm4               51.23    145.04   1100.70   2431.00
>> 
>> (elm3b67 is a 16x x440 ia32 NUMA system + HT)
> 
> Sounds like the CPU scheduler, yes
> 
>> Is there an easy way to just test those sched changes alone?
> 
> Nick has tossed out and redone all the scheduler patches from -mm4, but I
> assume it's all pretty much the same.
> 
> At http://www.zip.com.au/~akpm/linux/patches/stuff/mbligh.gz is a rollup
> (against 2.6.12-rc1) of

Kernbench: 
                                    Elapsed    System      User       CPU
elm3b67      2.6.12-rc1               49.02    147.91   1105.49   2556.00
elm3b67      mbligh                   52.30    142.24   1105.83   2385.33

That doesn't seem like an improvement ;-) (last run is just adding above patch)
I'll try to get you results on a couple more machines, but I'm fighting
with the test harness to get it to behave (plus I now have to rerun all
the tests with CONFIG_BROKEN turned on to get CONFIG_SCSI_QLOGIC_ISP to 
work).

M.

