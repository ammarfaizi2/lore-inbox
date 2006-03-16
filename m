Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWCPWQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWCPWQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWCPWQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:16:18 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:13519 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750866AbWCPWQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:16:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: does swsusp suck after resume for you?
Date: Thu, 16 Mar 2006 23:15:09 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, ck@vds.kolivas.org,
       Stefan Seyfried <seife@suse.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060316105054.GB9399@atrey.karlin.mff.cuni.cz> <200603170833.27114.kernel@kolivas.org>
In-Reply-To: <200603170833.27114.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603162315.09939.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 March 2006 22:33, Con Kolivas wrote:
> > > > > The tunable in /proc/sys/vm/swap_prefetch is now bitwise ORed:
> > > > > Thus if you set this value 
> > > > > to 3 it will prefetch aggressively and then drop back to the default
> > > > > of 1. This makes it easy to simply set the aggressive flag once and
> > > > > forget about it. I've booted and tested this feature and it's working
> > > > > nicely. Where exactly you'd set this in your resume scripts I'm not
> > > > > sure. A rolled up patch against 2.6.16-rc6-mm1 is here for
> > > > > simplicity:
> 
> correct url:
> http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_test.patch
> 
> > > 2 means aggressively prefetch as much as possible and then disable swap
> > > prefetching from that point on. Too confusing?
> >
> > Ahha... oops, yes, clever; no, I guess keep it.
> 
> Ok the patch works fine for me and the feature is worthwhile in absolute terms 
> as well as for improving resume. 
> 
> Pavel, while we're talking about improving behaviour after resume I had a look 
> at the mechanism used to free up ram before suspending and I can see scope 
> for some changes in the vm code that would improve the behaviour after 
> resuming. Is the mechanism used to free up ram going to continue being used 
> with uswsusp?

Yes.

> If so, I'd like to have a go at improving the free up ram vm  
> code to make it behave nicer after resume. I have some ideas about how best 
> to free up ram differently from normal reclaim which would improve behaviour 
> post resume.

That sounds really good to me. :-)

Greetings,
Rafael
