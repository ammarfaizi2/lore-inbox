Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWJ1UIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWJ1UIy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 16:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWJ1UIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 16:08:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14295 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964809AbWJ1UIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 16:08:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@muc.de>
Cc: Yinghai Lu <yinghai.lu@amd.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector for destroy_irq
References: <5986589C150B2F49A46483AC44C7BCA412D763@ssvlexmb2.amd.com>
	<m1ejsuqnyf.fsf@ebiederm.dsl.xmission.com>
	<86802c440610272244q750f35a7hcbed50e58546d97@mail.gmail.com>
	<20061028172941.GA92790@muc.de>
Date: Sat, 28 Oct 2006 14:06:06 -0600
In-Reply-To: <20061028172941.GA92790@muc.de> (Andi Kleen's message of "28 Oct
	2006 19:29:41 +0200, Sat, 28 Oct 2006 19:29:41 +0200")
Message-ID: <m1r6wsnr2p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Fri, Oct 27, 2006 at 10:44:36PM -0700, Yinghai Lu wrote:
>> revised version according to Eric. and it can be applied clearly to
>> current Linus's Tree.
>> 
>> Clear the irq releated entries in irq_vector, irq_domain and vector_irq
>> instead of clearing irq_vector only. So when new irq is created, it
>> could reuse that vector. (actually is the second loop scanning from
>> FIRST_DEVICE_VECTOR+8). This could avoid the vectors are used up
>> with enough module inserting and removing
>
> Added thanks.
>
> Does i386 need a similar patch?

i386 is good, as it doesn't deal with per cpu vectors, so it doesn't
have the additional data structures.

Eric
