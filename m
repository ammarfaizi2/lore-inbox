Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVCJGTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVCJGTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 01:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVCIT7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:59:09 -0500
Received: from colin2.muc.de ([193.149.48.15]:17159 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261912AbVCITjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:39:37 -0500
Date: 9 Mar 2005 20:39:36 +0100
Date: Wed, 9 Mar 2005 20:39:36 +0100
From: Andi Kleen <ak@muc.de>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309193936.GC17918@muc.de>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <20050309183408.GB26902@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309183408.GB26902@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:34:08AM -0800, Greg KH wrote:
> On Wed, Mar 09, 2005 at 10:56:33AM +0100, Andi Kleen wrote:
> > Greg KH <greg@kroah.com> writes:
> > >
> > > Rules on what kind of patches are accepted, and what ones are not, into
> > > the "-stable" tree:
> > >  - It must be obviously correct and tested.
> > >  - It can not bigger than 100 lines, with context.
> > 
> > This rule seems silly. What happens when a security fix needs 150 lines? 
> 
> Then we bend the rules and accept it :)
> 
> We'll take these as a case-by-case basis...
> 
> > >  - Security patches will be accepted into the -stable tree directly from
> > >    the security kernel team, and not go through the normal review cycle.
> > >    Contact the kernel security team for more details on this procedure.
> > 
> > This also sounds like a bad rule. How come the security team has more
> > competence to review patches than the subsystem maintainers?  I can
> > see the point of overruling maintainers on security issues when they
> > are not responsive, but if they are I think the should be still the
> > main point of contact.
> 
> Security fixes go from the security team to Linus's tree directly, and
> usually the subsystem maintainer has already been notified and has
> reviewedit.  At that point in time, they are public and accepted into

What guarantees that?

Basically what I would like to avoid is that the security team
merges something through the backdoor that the maintainer considers crap.

If anything you should have a rule like

"Send to maintainer. If he doesn't ACK in 24h send it directly"


> mainline, and need to be made availble to the -stable users as soon as
> possible.
> 
> That is why the "fast track" is going to happen, the patch really was
> reviewed properly, just not in public :)

Well, when you really want to have such formal rules (which is a novelty in 
Linux space BTW, for many years we did fine with unwritten rules)  then you
should spell it out completely. Or alternatively drop all the formal
rules and do it informally like it was always done.


-Andi
