Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWAQMWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWAQMWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWAQMWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:22:33 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:38580 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932448AbWAQMWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:22:32 -0500
Date: Tue, 17 Jan 2006 06:22:30 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev@ozlabs.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060117122230.GB20632@sergelap.austin.ibm.com>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060115230557.0f07a55c.akpm@osdl.org> <200601170000.58134.michael@ellerman.id.au> <20060116153748.GA25866@sergelap.austin.ibm.com> <20060116215252.GA10538@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116215252.GA10538@cs.umn.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave C Boutcher (sleddog@us.ibm.com):
> On Mon, Jan 16, 2006 at 09:37:48AM -0600, Serge E. Hallyn wrote:
> > Quoting Michael Ellerman (michael@ellerman.id.au):
> > > On Mon, 16 Jan 2006 18:05, Andrew Morton wrote:
> > > > "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > > > > On my power5 partition, 2.6.15-mm4 hangs on boot
> > 
> > boot: quicktest
> > Please wait, loading kernel...
> 
> ...
> 
> > Page orders: linear mapping = 24, others = 12
> >  -> smp_release_cpus()
> >  <- smp_release_cpus()
> >  <- setup_system()
> > 
> > So setup_system() at least finishes, though I don't see the
> > printk's at the bottom of that function.
> 
> 2.6.15-mm4 won't boot on my power5 either.  I tracked it down to the
> following mutex patch from Ingo: kernel-kernel-cpuc-to-mutexes.patch
> 
> If I revert just that patch, mm4 boots fine.  Its really not obvious to
> me at all why that patch is breaking things though...

FWIW this fixes mine as well.

-serge
