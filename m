Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUDHETY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 00:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDHETY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 00:19:24 -0400
Received: from ozlabs.org ([203.10.76.45]:490 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261568AbUDHETW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 00:19:22 -0400
Date: Thu, 8 Apr 2004 13:56:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org,
       anton@samba.org, paulus@samba.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-ID: <20040408035645.GC29551@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org, ak@suse.de,
	linux-kernel@vger.kernel.org, anton@samba.org, paulus@samba.org,
	linuxppc64-dev@lists.linuxppc.org
References: <20040407074239.GG18264@zax> <20040407143447.4d8f08af.ak@suse.de> <1081386710.1401.86.camel@gaston> <20040407190126.06a9c38f.akpm@osdl.org> <20040408030923.GA29551@zax> <20040407202443.78078b59.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407202443.78078b59.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 08:24:43PM -0700, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > > I don't see much in the COW code which is ppc64-specific.  All the hardware
> >  > needs to do is to provide a way to make the big pages readonly.  With a bit
> >  > of an abstraction for the TLB manipulation in there it should be pretty
> >  > straightforward.
> >  > 
> >  > Certainly worth the attempt, no?
> > 
> >  Yes, you have a point.  However doing it in a cross-arch way will
> >  require building more of a shared abstraction about hugepage pte
> >  entries that exists currently.  And that will mean making significant
> >  changes to all the archs to create that abstraction.  I don't know
> >  enough about the other archs to be confident of debugging such
> >  changes, but I'll see what I can do.
> 
> Well the first step is to consolidate the existing duplication in 2.6.5
> before thinking about new features.  That's largely a cut-n-paste job which
> I've been meaning to get onto but alas have not.  I don't want to dump it
> on you just because you want to tend to your COWs so if you have other
> things to do, please let me know.

Well, I do have other things to do, so I'll try to look at the
consolidation when I get a chance.

> We could use the `weak' attribute in mm/hugetlbpage.c for those cases where
> one arch really needs to do something different.

Yes, that's an idea.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
