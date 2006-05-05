Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWEENgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWEENgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 09:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWEENgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 09:36:20 -0400
Received: from ns.suse.de ([195.135.220.2]:41173 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751566AbWEENgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 09:36:18 -0400
Date: Fri, 5 May 2006 06:34:37 -0700
From: Greg KH <greg@kroah.com>
To: Jes Sorensen <jes@sgi.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Brent Casavant <bcasavan@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org,
       jeremy@sgi.com
Subject: Re: [PATCH] Move various PCI IDs to header file
Message-ID: <20060505133437.GA24268@kroah.com>
References: <20060504180614.X88573@chenjesu.americas.sgi.com> <20060504173722.028c2b24.rdunlap@xenotime.net> <445AE690.5030700@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445AE690.5030700@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 07:45:52AM +0200, Jes Sorensen wrote:
> Randy.Dunlap wrote:
> >On Thu, 4 May 2006 18:09:45 -0500 (CDT) Brent Casavant wrote:
> >
> >>Move various QLogic, Vitesse, and Intel storage
> >>controller PCI IDs to the main header file.
> >>
> >>Signed-off-by: Brent Casavant <bcasavan@sgi.com>
> >>
> >>---
> >>
> >>As suggested by Andrew Morton and Jes Sorenson.
> >
> >as compared to:
> >http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9b860b8c4bde5949b272968597d1426d53080532
> 
> I guess Andrew and I should be blamed for that. I Andrew suggested
> putting the IDs in the 'right place' and I took the right place as being
> the pci_ids.h file.
> 
> Can't say I agree with the recommendation, having them in pci_ids.h is
> nice and clean and it allows one to go look through the list, instead
> they now really become random hex values :( Brent's patch is a perfect
> example of IDs being used in multiple places, ie. the qla1280 driver
> and in the IOC4 driver, so the claim in that Documentation/ file doesn't
> hold water.
> 
> Anyway, if this is the new rule, then I guess it's back to using the
> ugly patch :(

No, I agree with your patch, as you are having to reference the ids from
2 different files.  So because of that, I feel it's ok to have those ids
in the pci_id.h file.

Yes, the wording in the documentation file should be cleaned up a bit to
state this a bit better...

thanks,

greg k-h
