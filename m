Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWKDGfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWKDGfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 01:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWKDGfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 01:35:30 -0500
Received: from dsl093-039-086.pdx1.dsl.speakeasy.net ([66.93.39.86]:61144 "EHLO
	mauritius.dodds.net") by vger.kernel.org with ESMTP id S932429AbWKDGf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 01:35:29 -0500
Date: Fri, 3 Nov 2006 22:35:12 -0800
From: Steve Langasek <vorlon@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Eki <eki@sci.fi>, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, thias.lelourd@gmail.com,
       jharrison@linuxbs.org
Subject: Re: [patch] video: support for VGA hoses on alpha TITAN, TSUNAMI systems (ES45, DS25)
Message-ID: <20061104063510.GA7268@mauritius.dodds.net>
References: <20061102083718.GC12267@mauritius.dodds.net> <20061102131443.918d6c2e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102131443.918d6c2e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for the feedback.  I'll incorporate your comments and Ivan's into an
updated patch and re-test.  What's the procedure afterwards -- should I
re-submit as a follow-up to this thread or start a new thread?

On Thu, Nov 02, 2006 at 01:14:43PM -0800, Andrew Morton wrote:

> > From: Jay Estabrook <jay.estabrook@hp.com>

> > Add working support for VGA hoses on Alpha, which is required in order to
> > use a VGA console on TITAN- and TSUNAMI-class Alpha systems.  This also
> > generalizes support for non-standard VGA offsets on Alpha to cover the
> > Marvel class of alphas without special-casing.  Includes recognizing an
> > additional model of TITAN-class Alpha.

> > Tested successfully on an ES45 and a DS25 with a vanilla 2.6.18 kernel,
> > also tested on an LX164 with the Debian 2.6.18 kernel with no regressions. 
> > Included in Alpha Core distribution for some time.

> It would be appropriate for both yourself and Jay to provide signoffs for
> this work, as per section 11 of Documentation/SubmittingPatches, please.

Ok, will ask Jay for this.

> What is a "hose"?

Ivan's comment, that this is effectively a PCI domain, is consistent with my
(limited) understanding.

> > +/* wait until after includes to test for this, to allow arch-specific mod. */
> > +#ifndef vga_request_resource
> > +# define vga_request_resource request_resource
> > +#endif
> > +

> erk.

Yeah. :/  Suggestions welcome.

> So we actually need to include asm/pci.h in these files?

Uhm, appears not.  Thanks for noticing.

-- 
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
vorlon@debian.org                                   http://www.debian.org/
