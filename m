Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVDMEZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVDMEZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVDMEW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 00:22:27 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:47755 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262568AbVDMES6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 00:18:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N0jxKZCRFhPerZU369Hh6qDvnk2mlKdaoDK5KE4dH3jNPeaaukegWBhiflUya4Vt1WS00MHX6tb/IQOuO5D6uNoHiv2Rn3UxnkCXWuWD4hrUsdi4kwGMJAyMtUSNrKfjjbt6YeZLwwIOlq0HAaEabnDDY5tPZrdXCPjyjDtgiNY=
Message-ID: <2cd57c9005041221186002c876@mail.gmail.com>
Date: Wed, 13 Apr 2005 12:18:54 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: [patch 006/198] arm: add comment about max_low_pfn/max_pfn
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk,
       rmk@arm.linux.org.uk
In-Reply-To: <2cd57c900504122010430af248@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504121030.j3CAUie5005135@shell0.pdx.osdl.net>
	 <2cd57c900504122010430af248@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI
http://lkml.org/lkml/2004/6/29/57

On 4/13/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> I told rmk about this long time ago.
> 
> On 4/12/05, akpm@osdl.org <akpm@osdl.org> wrote:
> >
> > From: Russell King <rmk+lkml@arm.linux.org.uk>
> >
> > Oddly, max_low_pfn/max_pfn end up being the number of pages in the system,
> > rather than the maximum PFN on ARM.  This doesn't seem to cause any problems,
> > so just add a note about it.
> >
> > Signed-off-by: Russell King <rmk@arm.linux.org.uk>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> >
> >  25-akpm/arch/arm/mm/init.c |    3 +++
> >  1 files changed, 3 insertions(+)
> >
> > diff -puN arch/arm/mm/init.c~arm-add-comment-about-max_low_pfn-max_pfn arch/arm/mm/init.c
> > --- 25/arch/arm/mm/init.c~arm-add-comment-about-max_low_pfn-max_pfn     2005-04-12 03:21:04.967381744 -0700
> > +++ 25-akpm/arch/arm/mm/init.c  2005-04-12 03:21:04.971381136 -0700
> > @@ -223,6 +223,9 @@ find_memend_and_nodes(struct meminfo *mi
> >          * This doesn't seem to be used by the Linux memory
> >          * manager any more.  If we can get rid of it, we
> >          * also get rid of some of the stuff above as well.
> > +        *
> > +        * Note: max_low_pfn and max_pfn reflect the number
> > +        * of _pages_ in the system, not the maximum PFN.
> >          */
> >         max_low_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);
> >         max_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);
> > _
> 
> --
> Coywolf Qi Hunt
> http://sosdg.org/~coywolf/
> 


-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
