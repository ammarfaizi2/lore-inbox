Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVCIUKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVCIUKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVCIUGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:06:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:45544 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262371AbVCIUEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:04:01 -0500
Date: Wed, 9 Mar 2005 12:03:40 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309200340.GB28312@kroah.com>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <20050309183408.GB26902@kroah.com> <20050309193936.GC17918@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309193936.GC17918@muc.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 08:39:36PM +0100, Andi Kleen wrote:
> On Wed, Mar 09, 2005 at 10:34:08AM -0800, Greg KH wrote:
> > On Wed, Mar 09, 2005 at 10:56:33AM +0100, Andi Kleen wrote:
> > > Greg KH <greg@kroah.com> writes:
> > > >
> > > > Rules on what kind of patches are accepted, and what ones are not, into
> > > > the "-stable" tree:
> > > >  - It must be obviously correct and tested.
> > > >  - It can not bigger than 100 lines, with context.
> > > 
> > > This rule seems silly. What happens when a security fix needs 150 lines? 
> > 
> > Then we bend the rules and accept it :)
> > 
> > We'll take these as a case-by-case basis...
> > 
> > > >  - Security patches will be accepted into the -stable tree directly from
> > > >    the security kernel team, and not go through the normal review cycle.
> > > >    Contact the kernel security team for more details on this procedure.
> > > 
> > > This also sounds like a bad rule. How come the security team has more
> > > competence to review patches than the subsystem maintainers?  I can
> > > see the point of overruling maintainers on security issues when they
> > > are not responsive, but if they are I think the should be still the
> > > main point of contact.
> > 
> > Security fixes go from the security team to Linus's tree directly, and
> > usually the subsystem maintainer has already been notified and has
> > reviewedit.  At that point in time, they are public and accepted into
> 
> What guarantees that?

The kernel security team's proceedures.

> Basically what I would like to avoid is that the security team
> merges something through the backdoor that the maintainer considers crap.
> 
> If anything you should have a rule like
> 
> "Send to maintainer. If he doesn't ACK in 24h send it directly"
> 
> 
> > mainline, and need to be made availble to the -stable users as soon as
> > possible.
> > 
> > That is why the "fast track" is going to happen, the patch really was
> > reviewed properly, just not in public :)
> 
> Well, when you really want to have such formal rules (which is a novelty in 
> Linux space BTW, for many years we did fine with unwritten rules)  then you
> should spell it out completely. Or alternatively drop all the formal
> rules and do it informally like it was always done.

I'd love to do it informally, but the rules are going to be used to make
our lives easier, by having something to point to when we want to reject
something, and having something that everyone can refer to when trying
to understand what it is we are attempting to do here.

If they get too complex, or large, we will have to revisit them.

So, let's stop arguing about the semantics of the rules, and see if what
we have proposed actually works in real-life.  If that doesn't work out,
we can revisit it then.

thanks,

greg k-h
