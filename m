Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVG2Hs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVG2Hs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVG2Hq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:46:59 -0400
Received: from ns1.suse.de ([195.135.220.2]:3810 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262487AbVG2HoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:44:21 -0400
Date: Fri, 29 Jul 2005 09:44:19 +0200
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: sync_tsc fix the race (so we can boot)
Message-ID: <20050729074419.GB3726@bragg.suse.de>
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 10:03:04PM -0600, Eric W. Biederman wrote:
> I believe this patch suffers from apicid versus logical cpu number confusion.
> I copied the basic logic from smp_send_reschedule and I can't find where
> that translates from the logical cpuid to apicid.  So it isn't quite
> correct yet.  It should be close enough that it shouldn't be too hard
> to finish it up.
> 
> More bug fixes after I have slept but I figured I needed to get this
> one out for review.

Thanks looks good. This should fix the unexplained
hang for various people. Logical<->apicid  is actually ok, the low
level _mask function takes care of that (it differs depending on the 
APIC mode anyways) 

There are some style problems, but that can be fixed later.

How did you track that nasty it down? 

-Andi

