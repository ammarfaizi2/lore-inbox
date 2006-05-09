Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWEIPON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWEIPON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWEIPON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:14:13 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:35989 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750737AbWEIPOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:14:12 -0400
Date: Tue, 9 May 2006 16:13:57 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 22/35] subarch suport for idle loop (NO_IDLE_HZ for Xen)
Message-ID: <20060509151357.GH7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085156.694312000@sous-sol.org> <200605091521.19910.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605091521.19910.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 03:21:19PM +0200, Andi Kleen wrote:
> 
> > +extern void stop_hz_timer(void);
> > +extern void start_hz_timer(void);
> > +
> > +void xen_idle(void);
> > +
> >  static char * __init machine_specific_memory_setup(void)
> >  {
> >  	unsigned long max_pfn = xen_start_info->nr_pages;
> > @@ -65,4 +70,23 @@ static void __init machine_specific_arch
> >  		console_use_vt = 0;
> >  		conswitchp = NULL;
> >  	}
> > +
> > +	pm_idle = xen_idle;
> > +}
> > +
> > +void xen_idle(void)
> 
> I think that should be in some .c file, not a .h
> 
> Probably applies to more of your functions too.

I guess I agree, although I was mostly following the examples in other
mach setup_arch_*.h files.

    christian

