Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVIFBjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVIFBjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVIFBjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:39:11 -0400
Received: from waste.org ([216.27.176.166]:23523 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S965080AbVIFBjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:39:09 -0400
Date: Mon, 5 Sep 2005 18:38:58 -0700
From: Matt Mackall <mpm@selenic.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [GIT PATCHES] kbuild updates
Message-ID: <20050906013858.GI27787@waste.org>
References: <20050905174150.GA17923@mars.ravnborg.org> <200509052035.14156.s0348365@sms.ed.ac.uk> <20050905201345.GA26106@mars.ravnborg.org> <200509052232.04135.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509052232.04135.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 10:32:04PM +0100, Alistair John Strachan wrote:
> On Monday 05 September 2005 21:13, Sam Ravnborg wrote:
> > On Mon, Sep 05, 2005 at 08:35:14PM +0100, Alistair John Strachan wrote:
> > > On Monday 05 September 2005 18:41, Sam Ravnborg wrote:
> > > > Hi Linus.
> > > >
> > > > kbuild updates as accumulated over the last few months.
> > > > All patches has been in -mm in one or several versions.
> > > >
> > > > Most noteworthy:
> > > > 1) -Wundef added to CFLAGS. This is the cause of several new warnings,
> > > >    which for the most part has been fixed for now.
> > > > 2) "PREEMPT" in UTS_VERSION. So we complain when dealing
> > > >    with modules compiled for a wrong kernel
> > >
> > > How is this different from the preempt module vermagic?
> > >
> > > ~$ modinfo agpgart | grep vermagic
> > > vermagic:       2.6.13 preempt gcc-4.0
> >
> > My bad. Adding PREEMT to UTS_VERSION makes it visible in uname -a.
> >
> 
> I see. I can understand adding an extraversion for SMP and experimental 
> patches (like Ingo's RT work), but why is it useful to differentiate (by 
> name) between preempt and non-preempt kernels? Do distributors wish to 
> package both in parallel?

I created the patch so that it would show up in oops reports and
elsewhere and avoid the inevitable question "was this a preempt
kernel?"

-- 
Mathematics is the supreme nostalgia of our time.
