Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWHGM2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWHGM2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 08:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHGM2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 08:28:51 -0400
Received: from colin.muc.de ([193.149.48.1]:30473 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932078AbWHGM2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 08:28:50 -0400
Date: 7 Aug 2006 14:28:45 +0200
Date: Mon, 7 Aug 2006 14:28:45 +0200
From: Andi Kleen <ak@muc.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor@insightbb.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060807122845.GA85602@muc.de>
References: <1154771262.28257.38.camel@localhost.localdomain> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <200608062243.45129.dtor@insightbb.com> <20060807084850.GA67713@muc.de> <20060807110931.GM27757@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807110931.GM27757@suse.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 01:09:31PM +0200, Vojtech Pavlik wrote:
> On Mon, Aug 07, 2006 at 10:48:50AM +0200, Andi Kleen wrote:
> > On Sun, Aug 06, 2006 at 10:43:44PM -0400, Dmitry Torokhov wrote:
> > > On Saturday 05 August 2006 23:16, Andi Kleen wrote:
> > > > This whole thing is broken, e.g. on a preemptive kernel when the
> > > > code can switch CPUs 
> > > > 
> > > 
> > > Would not preempt_disable fix that?
> > 
> > Partially, but you still have other problems. Please just get rid
> > of it. Why do we have timer code in the kernel if you then chose
> > not to use it?
>  
> The problem is that gettimeofday() is not always fast. 

When it is not fast that means it is not reliable and then you're
also not well off using it anyways.

Please change that code.

-Andi
