Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWHFDME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWHFDME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 23:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWHFDMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 23:12:03 -0400
Received: from terminus.zytor.com ([192.83.249.54]:33975 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751504AbWHFDMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 23:12:01 -0400
Message-ID: <44D55DF9.6020706@zytor.com>
Date: Sat, 05 Aug 2006 20:11:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
References: <1154771262.28257.38.camel@localhost.localdomain>	 <20060806023824.GA41762@muc.de>	 <1154832963.29151.21.camel@localhost.localdomain>	 <44D55AEC.1090205@zytor.com> <1154833800.29151.24.camel@localhost.localdomain>
In-Reply-To: <1154833800.29151.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>>>
>>> So if you would prefer u64 rdtsc64(), u32 rdtsc_low(), u64 rdmsr64(int
>>> msr), u32 rdmsr_low(int msr), I can convert everyone to that, although
>>> it's a more invasive change...
>> rdmsrl is really misnamed.  It should have been rdmsrq to be consistent, 
>> and have rdmsrl return the low 32 bits.
> 
> I prefer the more explicit linux-style naming of rdmsr_low32/rdmsr64,
> myself, even though this is x86-specific code.  Noone has an excuse for
> misunderstanding then...
> 

Well, we *do* have readb/readw/readl/readq etc.

	-hpa

