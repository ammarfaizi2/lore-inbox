Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUHFR57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUHFR57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHFRz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:55:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14255 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266073AbUHFRzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:55:00 -0400
Date: Fri, 6 Aug 2004 14:09:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vladislav Bolkhovitin <vst@vlnb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
Message-ID: <20040806170931.GA21683@logos.cnet>
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net> <20040806143359.GC20911@logos.cnet> <4113A579.5060702@vlnb.net> <20040806155328.GA21546@logos.cnet> <4113B752.7050808@vlnb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4113B752.7050808@vlnb.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 08:52:34PM +0400, Vladislav Bolkhovitin wrote:
> Marcelo Tosatti wrote:
> >On Fri, Aug 06, 2004 at 07:36:25PM +0400, Vladislav Bolkhovitin wrote:
> >
> >>Thanks.
> >>
> >>One more question, if you don't object. How after some variable 
> >>assigment to make other CPUs *immediatelly* see the assigned value, i.e. 
> >>to make current CPU immediately flush its write cache in memory? *mb() 
> >>seems deal with reordering, barrier() with the compiler optimization (am 
> >>I right?). 
> >
> >
> >Yes correct. *mb() usually imply barrier(). 
> >
> >About the flush, each architecture defines its own instruction for doing 
> >so,
> > PowerPC has  "sync" and "isync" instructions (to flush the whole cache 
> > and instruction cache respectively), MIPS has "sync" and so on..
> 
> So, there is no platform independent way for doing that in the kernel?

Not really. x86 doesnt have such an instruction.
