Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264882AbUGIO0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbUGIO0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUGIO02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:26:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:50403 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264770AbUGIOXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:23:35 -0400
Date: Fri, 09 Jul 2004 07:23:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Autotune swappiness
Message-ID: <13490000.1089383007@[10.10.2.4]>
In-Reply-To: <40EDE956.80705@kolivas.org>
References: <40EC13C5.2000101@kolivas.org>	<40EC1930.7010805@comcast.net>	<40EC1B0A.8090802@kolivas.org>	<20040707213822.2682790b.akpm@osdl.org>	<cone.1089268800.781084.4554.502@pc.kolivas.org>	<20040708001027.7fed0bc4.akpm@osdl.org>	<cone.1089273505.418287.4554.502@pc.kolivas.org>	<20040708010842.2064a706.akpm@osdl.org>	<40ED7534.4010409@kolivas.org> <20040708094406.2b0293ea.akpm@osdl.org> <40EDE956.80705@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Here is another try at providing feedback to tune the vm_swappiness.
>> 
>> 
>> I spent some time yesterday trying to demonstrate performance improvements
>> from those two patches.  Using
>> 
>> 	make -j4 vmlinux with mem=64m
>> 
>> and
>> 
>> 	qsbench -p 4 -m 96 with mem=256m
>> 
>> and was not able to do so, which is what I expected.
>> 
>> We do need more quantitative testing on this work.
> 
> Sure thing.
> 
> I need to point out a few things:
> The point of this patch was to improve the swap behaviour on desktop like loads.
> The fact that it improved the "when swap is thrashing" scenario (in my testing) was an unintentional bonus.
> I dont think your load of j4 will induce quite the same swap thrash as what I was testing. I actually suspect the faster cpu & more jobs over fixed memory shows it more.
> I need someone with more varied hardware to test it for me. I can recreate equivalent results on my current machine which has similar hardware, but I think results showing improvement on different machines   and different loads is what you're looking for... and since I'm currently quite low on hardware I can only offer results from this one (and my wife is hating it being offline o_0)
> 
> Anyone willing to offer to do some tests?

What kind of mem pressure are you looking for? kernel compile is easy to run, 
and straight "-j" should kill a small system fairly well ... you want it just
into swap, or thrashing the crap out of it?

M.

