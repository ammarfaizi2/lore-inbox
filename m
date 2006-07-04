Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWGDVyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWGDVyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWGDVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:54:00 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:53947 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S932209AbWGDVyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:54:00 -0400
Date: Tue, 4 Jul 2006 14:45:39 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] i386 TIF flags for debug regs and io bitmap in ctxsw
Message-ID: <20060704214539.GB7078@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200607041719_MC3-1-C420-EC5A@compuserve.com> <200607042347.00598.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607042347.00598.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 11:47:00PM +0200, Andi Kleen wrote:
> On Tuesday 04 July 2006 23:19, Chuck Ebbert wrote:
> > In-Reply-To: <20060704072939.GC5902@frankl.hpl.hp.com>
> >
> > On Tue, 4 Jul 2006 00:29:39 -0700, Stephane Eranian wrote:
> > > Following my discussion with Andi. Here is a patch that introduces
> > > two new TIF flags to simplify the context switch code in __switch_to().
> > > The idea is to minimize the number of cache lines accessed in the common
> > > case, i.e., when neither the debug registers nor the I/O bitmap are used.
> >
> > I get a 5-10% speedup in task switch times with this patch.
> 
> That sounds too much. How did you measure it?
> 
> Note that lmbench tends to be unstable for this.
> 
Yes, that is my observation as well. Anybody knows of a better
benchmark for ctxsw?

-- 

-Stephane
