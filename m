Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWGCTge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWGCTge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWGCTge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:36:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:50861 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751246AbWGCTge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:36:34 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Date: Mon, 3 Jul 2006 21:36:28 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <200607032125.48727.ak@suse.de> <20060703192212.GC5471@frankl.hpl.hp.com>
In-Reply-To: <20060703192212.GC5471@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607032136.28068.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 21:22, Stephane Eranian wrote:
> Andi,
> 
> On Mon, Jul 03, 2006 at 09:25:48PM +0200, Andi Kleen wrote:
> > On Monday 03 July 2006 11:49, Stephane Eranian wrote:
> > > Andi,
> > > 
> > > Here is a first cut at the patch to simplify the context
> > > switch for the common case and also touch 2 cachelines (instead of 3).
> > > There are 2 new TIF flags. I just tried this on x86_64 but I believe
> > > we could do the same on i386.
> > > 
> > > Is that what you were thinking about?
> > 
> > Yes, looks good.
> > 
> I have worked on this some more and I also looked at i386.
> They seem to handle the io bitmap differently there. At least
> they seem to have some lazy scheme whereby you do not reinstall
> if new task is the last owner of tss. Is there a reason for not
> having this in place for x86-64?

There was a reason but I can't remember it right now :/ Something
in the new scheme didn't fit well or it was just too complicated.

-Andi

