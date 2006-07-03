Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWGCTab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWGCTab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWGCTab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:30:31 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:16018 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751240AbWGCTaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:30:30 -0400
Date: Mon, 3 Jul 2006 12:22:12 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060703192212.GC5471@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <p73bqsax0iu.fsf@verdi.suse.de> <20060703094948.GA4460@frankl.hpl.hp.com> <200607032125.48727.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607032125.48727.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Mon, Jul 03, 2006 at 09:25:48PM +0200, Andi Kleen wrote:
> On Monday 03 July 2006 11:49, Stephane Eranian wrote:
> > Andi,
> > 
> > Here is a first cut at the patch to simplify the context
> > switch for the common case and also touch 2 cachelines (instead of 3).
> > There are 2 new TIF flags. I just tried this on x86_64 but I believe
> > we could do the same on i386.
> > 
> > Is that what you were thinking about?
> 
> Yes, looks good.
> 
I have worked on this some more and I also looked at i386.
They seem to handle the io bitmap differently there. At least
they seem to have some lazy scheme whereby you do not reinstall
if new task is the last owner of tss. Is there a reason for not
having this in place for x86-64?

-- 
-Stephane
