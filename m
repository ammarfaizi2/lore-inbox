Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVHDOKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVHDOKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVHDOH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:07:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:9438 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262555AbVHDOGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:06:21 -0400
Date: Thu, 4 Aug 2005 16:06:20 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       amitkale@linsyssoft.com
Subject: Re: [patch 07/15] Basic x86_64 support
Message-ID: <20050804140620.GW8266@wotan.suse.de>
References: <resend.6.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org> <resend.7.2972005.trini@kernel.crashing.org> <20050803130531.GR10895@wotan.suse.de> <20050803133756.GA3337@smtp.west.cox.net> <20050804123900.GR8266@wotan.suse.de> <20050804140445.GB3337@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804140445.GB3337@smtp.west.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 07:04:45AM -0700, Tom Rini wrote:
> On Thu, Aug 04, 2005 at 02:39:00PM +0200, Andi Kleen wrote:
> > > > That doesn't make much sense here. tasklet will only run when interrupts
> > > > are enabled, and that is much later. You could move it to there.
> > > 
> > > Where?  Keep in mind it's really only x86_64 that isn't able to break
> > > sooner.
> > 
> > The local_irq_enable() call in init/main.c:start_kernel()
> 
> But as I say, only x86_64 needs this kind of delay.

I don't think that's correct. Interrupts should be disabled on all
architectures until that.

-Andi
