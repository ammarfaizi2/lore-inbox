Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVCDGt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVCDGt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVCDGtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:49:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:9130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261354AbVCDGsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:48:07 -0500
Date: Thu, 3 Mar 2005 22:47:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, jgarzik@pobox.com, olof@austin.ibm.com,
       paulus@samba.org, rene@exactcode.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050304064759.GP5389@shell0.pdx.osdl.net>
References: <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com> <20050303225542.GB16886@austin.ibm.com> <20050303175951.41cda7a4.akpm@osdl.org> <20050304022424.GA26769@austin.ibm.com> <20050304055451.GN5389@shell0.pdx.osdl.net> <20050303220631.79a4be7b.akpm@osdl.org> <4227FC5C.60707@pobox.com> <20050304062016.GO5389@shell0.pdx.osdl.net> <20050303222335.372d1ad2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303222335.372d1ad2.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> >  * Jeff Garzik (jgarzik@pobox.com) wrote:
> >  > Andrew Morton wrote:
> >  > >Chris Wright <chrisw@osdl.org> wrote:
> >  > >>Olof's patch is in the linux-release tree, so this brings up a point
> >  > >>regarding merging.  If the quick fix is to be replaced by a better fix
> >  > >>later (as in this case) there's some room for merge conflict.  Does this
> >  > >>pose a problem for either -mm or Linus' tree?
> >  > >
> >  > >It depends who gets to Linus's tree first.  If linux-release merges first,
> >  > >I just revert the temp fix while adding the real fix.  But the temp fix
> >  > >should never have gone into Linus's tree in the first place.
> > 
> >  Consider it first patch in fixup series ;-)

Actually I meant fix 1/2 == quick, fix 2/2 == more complete.

> Here's the second, and this is much more critical.
> 
> And it's untested.

I'd rather it be tested.../me keeps wishing
If it's untested, are we even sure it fixes the problem?  Or are you
worried about the umpteen other non-Dell laptops that could have
problems with the patch?

> And it's a temp-fix - it'll be addressed by other means in 2.6.12.
> 
> What do we do?

IMO, we have to rely on Dmitry's judgement.  Is it critical (i.e. broke
laptops how)?  Can it be worked around with the i8042.noacpi boot param?
If so, I don't think it fits the bill as critical.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
