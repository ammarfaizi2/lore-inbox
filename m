Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWJ1R3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWJ1R3o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 13:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWJ1R3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 13:29:44 -0400
Received: from colin.muc.de ([193.149.48.1]:16900 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751190AbWJ1R3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 13:29:43 -0400
Date: 28 Oct 2006 19:29:41 +0200
Date: Sat, 28 Oct 2006 19:29:41 +0200
From: Andi Kleen <ak@muc.de>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector for destroy_irq
Message-ID: <20061028172941.GA92790@muc.de>
References: <5986589C150B2F49A46483AC44C7BCA412D763@ssvlexmb2.amd.com> <m1ejsuqnyf.fsf@ebiederm.dsl.xmission.com> <86802c440610272244q750f35a7hcbed50e58546d97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610272244q750f35a7hcbed50e58546d97@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 10:44:36PM -0700, Yinghai Lu wrote:
> revised version according to Eric. and it can be applied clearly to
> current Linus's Tree.
> 
> Clear the irq releated entries in irq_vector, irq_domain and vector_irq
> instead of clearing irq_vector only. So when new irq is created, it
> could reuse that vector. (actually is the second loop scanning from
> FIRST_DEVICE_VECTOR+8). This could avoid the vectors are used up
> with enough module inserting and removing

Added thanks.

Does i386 need a similar patch?

-Andi
