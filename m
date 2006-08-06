Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWHFC7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWHFC7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 22:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWHFC7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 22:59:16 -0400
Received: from terminus.zytor.com ([192.83.249.54]:30337 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751496AbWHFC7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 22:59:15 -0400
Message-ID: <44D55AEC.1090205@zytor.com>
Date: Sat, 05 Aug 2006 19:58:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
References: <1154771262.28257.38.camel@localhost.localdomain>	 <20060806023824.GA41762@muc.de> <1154832963.29151.21.camel@localhost.localdomain>
In-Reply-To: <1154832963.29151.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> You mean the l and ll variants?  The 64 bit variants are rdmsrl and
> rdtscll, not to be confused with rdtscl, which returns the lower 32
> bits.  This confusion caused the x86_64 bug in gameport.c which the
> patch comment mentioned (at least, seems to be a bug to me).
> 
> See why I want to fix these names?
> 
> So if you would prefer u64 rdtsc64(), u32 rdtsc_low(), u64 rdmsr64(int
> msr), u32 rdmsr_low(int msr), I can convert everyone to that, although
> it's a more invasive change...

rdmsrl is really misnamed.  It should have been rdmsrq to be consistent, 
and have rdmsrl return the low 32 bits.

	-hpa

