Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVCIVXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVCIVXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVCIUdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:33:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:4290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261587AbVCIUQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:16:45 -0500
Date: Wed, 9 Mar 2005 12:16:31 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <greg@kroah.com>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309201631.GC5389@shell0.pdx.osdl.net>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <20050309182822.GU5389@shell0.pdx.osdl.net> <20050309194401.GD17918@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309194401.GD17918@muc.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@muc.de) wrote:
> On Wed, Mar 09, 2005 at 10:28:22AM -0800, Chris Wright wrote:
> > * Andi Kleen (ak@muc.de) wrote:
> > > Greg KH <greg@kroah.com> writes:

> > > One rule I'm missing:
> > > 
> > > - It must be accepted to mainline. 
> > 
> > This can violate the principle of keeping fixes simple for -stable tree.
> > And Linus/Andrew don't want to litter mainline with patch series that
> > do simple fix followed by complete fix meant for developement branch.
> 
> But it risks code drift like we had in 2.4 with older kernels 
> having more fixes than the newer kernel. And that way lies madness.
> 
> I think it is very very important to avoid this.
> 
> If you prefer you can rewrite the rule like
> 
> "Fix must in mainline first. In exceptional cases when the fix 
> in mainline is too intrusive or risky a simpler version of the patch
> can be applied to stable. In this case the mainline fix must be already
> accepted. For most cases the full fix should be applied to avoid code drift"

I think we've all agreed that's the intention.

> > I agree, it's a good rule, but these should be small, temporal diffs
> > from mainline.  For example, -ac tree will sometimes do the simpler fix,
> > whereas mainline does proper complete fix.
> 
> You make it sound like all patches are super complicated and 
> not suitable for backporting.

I didn't think I did, that's why I said 'sometimes'.  Just acknowledging
what does really happen.

> > They don't, the security patches should still be reviewed by subsystem
> > maintainer.  Point here is, sometimes there's disclosure coordination
> > happening as well.
> 
> Ok, how does it coordinate with the vendor-sec process? 
> And at what point is the subsystem maintainer notified.

That's part of the vendor coordination mentioned in the policy.  And
subsystem maintainer is notified as part of vetting the issue/solution,
as stated in the policy.

> The security thing seems to be still quite half backed to me...

Take a look at the policy I posted last night and give me suggestions
for improvements.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
