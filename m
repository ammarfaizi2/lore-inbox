Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVCDGUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVCDGUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVCDGUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:20:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:12709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261571AbVCDGU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:20:26 -0500
Date: Thu, 3 Mar 2005 22:20:16 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       olof@austin.ibm.com, paulus@samba.org, rene@exactcode.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050304062016.GO5389@shell0.pdx.osdl.net>
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com> <20050303225542.GB16886@austin.ibm.com> <20050303175951.41cda7a4.akpm@osdl.org> <20050304022424.GA26769@austin.ibm.com> <20050304055451.GN5389@shell0.pdx.osdl.net> <20050303220631.79a4be7b.akpm@osdl.org> <4227FC5C.60707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4227FC5C.60707@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> Andrew Morton wrote:
> >Chris Wright <chrisw@osdl.org> wrote:
> >>Olof's patch is in the linux-release tree, so this brings up a point
> >>regarding merging.  If the quick fix is to be replaced by a better fix
> >>later (as in this case) there's some room for merge conflict.  Does this
> >>pose a problem for either -mm or Linus' tree?
> >
> >It depends who gets to Linus's tree first.  If linux-release merges first,
> >I just revert the temp fix while adding the real fix.  But the temp fix
> >should never have gone into Linus's tree in the first place.

Consider it first patch in fixup series ;-)

> >If I merge before linux-release, I guess Linus has some conflict resolving
> >to do when he pulls from linux-release.  That's OK for an obvious
> >two-liner, but would get out of control for more substantial things.
> >
> >Neither solution is acceptable, really.  I suspect the idea of pulling
> >linux-release into mainline won't work very well, and that making it a
> >backport tree would be more practical.
> 
> Maybe you're right, but I tend to think that "quick, get that fix out 
> immediately" fixes will appear before more substantial fixes.  That is 
> certainly the way things have worked up until now.
> 
> For the cases that we care about, putting that into linux-release and 
> then pulling would seem more appropriate.

Yes, and this case was on the border of a newly existing system.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
