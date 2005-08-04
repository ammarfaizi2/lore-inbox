Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVHDOPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVHDOPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVHDOPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:15:23 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:52360 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262556AbVHDOOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:14:38 -0400
Date: Thu, 4 Aug 2005 07:14:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@linsyssoft.com
Subject: Re: [patch 07/15] Basic x86_64 support
Message-ID: <20050804141437.GC3337@smtp.west.cox.net>
References: <resend.6.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org> <resend.7.2972005.trini@kernel.crashing.org> <20050803130531.GR10895@wotan.suse.de> <20050803133756.GA3337@smtp.west.cox.net> <20050804123900.GR8266@wotan.suse.de> <20050804140445.GB3337@smtp.west.cox.net> <20050804140620.GW8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804140620.GW8266@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 04:06:20PM +0200, Andi Kleen wrote:
> On Thu, Aug 04, 2005 at 07:04:45AM -0700, Tom Rini wrote:
> > On Thu, Aug 04, 2005 at 02:39:00PM +0200, Andi Kleen wrote:
> > > > > That doesn't make much sense here. tasklet will only run when interrupts
> > > > > are enabled, and that is much later. You could move it to there.
> > > > 
> > > > Where?  Keep in mind it's really only x86_64 that isn't able to break
> > > > sooner.
> > > 
> > > The local_irq_enable() call in init/main.c:start_kernel()
> > 
> > But as I say, only x86_64 needs this kind of delay.
> 
> I don't think that's correct. Interrupts should be disabled on all
> architectures until that.

Right, but we can run sooner elsewhere.  It's only x86_64 where we can't
run when our commandline bits are parsed and need to wait.

-- 
Tom Rini
http://gate.crashing.org/~trini/
