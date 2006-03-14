Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWCNVYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWCNVYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWCNVYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:24:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:19408
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751009AbWCNVYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:24:19 -0500
Date: Tue, 14 Mar 2006 13:24:15 -0800
From: Greg KH <greg@kroah.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch 0/9] Per-task delay accounting
Message-ID: <20060314212414.GA22202@kroah.com>
References: <1142296834.5858.3.camel@elinux04.optonline.net> <20060314192824.GB27012@kroah.com> <44172C4C.3020107@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44172C4C.3020107@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 03:49:16PM -0500, Shailabh Nagar wrote:
> Greg KH wrote:
> 
> >On Mon, Mar 13, 2006 at 07:40:34PM -0500, Shailabh Nagar wrote:
> > 
> >
> >>This is the next iteration of the delay accounting patches
> >>last posted at
> >>	http://www.ussg.iu.edu/hypermail/linux/kernel/0602.3/0893.html
> >>   
> >>
> >
> >Do you have any benchmark numbers with this patch applied and with it
> >not applied? 
> >
> None yet. Wanted to iron out the collection/utility aspects a bit before 
> going into
> the performance impact.
> 
> But this seems as good a time as any to collect some stats
> using the usual suspects lmbench, kernbench, hackbench etc.
> 
> >Last I heard it was a measurable decrease for some
> >"important" benchmark results...
> > 
> >
> Might have been from an older iteration where schedstats was fully enabled.
> But no point speculating....will run with this set of patches and see 
> what shakes out.
> 
> One point about the overhead is that it depends on the frequency with 
> which data is
> collected. So a proper test would probably be a comparison of a 
> non-patched kernel
> with
> a) patches applied but delay accounting not turned on at boot i.e. cost 
> of the checks
> b) delay accounting turned on but not being read

This is probably the most important one, as that is what distros will be
looking at.  They will have to enable the option, but will not "turn it
on".

> c) delay accounting turned on and data read for all tasks at some 
> "reasonable" rate
> 
> Will that be good  ? Other suggestions welcome.

How about real benchmarks?  The ones that the big companies look at?  I
know you have access to them :)

thanks,

greg k-h
