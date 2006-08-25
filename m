Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWHYHnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWHYHnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWHYHnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:43:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3784 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751235AbWHYHnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:43:22 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Incorrect alignment assumptions in x86_64 stacktrace 
In-reply-to: Your message of "Fri, 25 Aug 2006 09:33:53 +0200."
             <200608250933.53623.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 Aug 2006 17:43:01 +1000
Message-ID: <14016.1156491781@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Fri, 25 Aug 2006 09:33:53 +0200) wrote:
>On Friday 25 August 2006 08:59, Keith Owens wrote:
>> 2.6.18-rc4 arch/x86_64/kernel/stacktrace.c::get_stack_end() incorrectly
>> assumes that the irqstackptr is IRQSTACKSIZE aligned.
>> 
>> 	stack_end = (unsigned long)cpu_pda(cpu)->irqstackptr;
>> 	if (stack_end) {
>> 		stack_start = stack_end & ~(IRQSTACKSIZE-1);
>> 
>> irqstackptr is only guaranteed to be page aligned, not IRQSTACKSIZE
>> (4*PAGE_SIZE) aligned.
>
>Thanks. I have already removed that code post 2.6.18 (the standard backtracer
>now does both stacktrace and show_trace) 
>
>You think it is important enough for 2.6.18?

Depends if any x86_64 distributions are going to be based on 2.6.18.  I
hear rumours, but no facts.

