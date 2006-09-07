Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWIGORH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWIGORH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWIGORG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:17:06 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:56773 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932153AbWIGORE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:17:04 -0400
Date: Thu, 7 Sep 2006 15:16:59 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Paul Jackson <pj@sgi.com>
Cc: Mel Gorman <mel@skynet.ie>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       haveblue@us.ibm.com, apw@shadowen.org, ak@muc.de,
       benh@kernel.crashing.org, paulus@samba.org, kmannth@gmail.com,
       tony.luck@intel.com, kamezawa.hiroyu@jp.fujitsu.com,
       y-goto@jp.fujitsu.com
Subject: Re: x86_64 account-for-memmap patch in 2.6.18-rc4-mm3 doesn't boot.
In-Reply-To: <20060906151008.e84ffdd1.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0609071502001.31287@skynet.skynet.ie>
References: <20060831034638.4bfa7b46.pj@sgi.com> <Pine.LNX.4.64.0608311650410.13392@skynet.skynet.ie>
 <20060831100156.24fc0521.pj@sgi.com> <Pine.LNX.4.64.0609010933220.25057@skynet.skynet.ie>
 <20060901202430.0681f5c5.pj@sgi.com> <20060904094503.GA4475@skynet.ie>
 <20060906151008.e84ffdd1.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006, Paul Jackson wrote:

> Mel Gorman wrote:
>> I could do with those lines, but I believe there was enough information
>> printed to determine why it failed to boot. I've attached a patch that
>> should boot the machine and assuming it works, I just need the output of
>> dmesg.
>
> Yup - that patch booted it, and produced the output you asked for.
>
> Here's the dmesg output from booting your patch:
>
> <dmesg log snipped>

Thanks. Now it's *painfully* obvious what went wrong - memmap is not 
necessarily in one zone and in your machine memmap spanned two zones. A 
patch will follow this mail that fixes the underlying issue but keeps the 
underflow check in case. Please give it a test if you get the chance. It 
passes regression tests here.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
