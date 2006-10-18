Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWJRQ1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWJRQ1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWJRQ1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:27:45 -0400
Received: from ns1.suse.de ([195.135.220.2]:28039 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422643AbWJRQ1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:27:22 -0400
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
References: <1160596462.5973.12.camel@localhost.localdomain>
	<20061011142646.eb41fac3.akpm@osdl.org>
	<Pine.LNX.4.64N.0610181650001.28841@blysk.ds.pg.gda.pl>
From: Andi Kleen <ak@suse.de>
Date: 18 Oct 2006 18:27:14 +0200
In-Reply-To: <Pine.LNX.4.64N.0610181650001.28841@blysk.ds.pg.gda.pl>
Message-ID: <p73y7rdbndp.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@linux-mips.org> writes:

> On Wed, 11 Oct 2006, Andrew Morton wrote:
> 
> > So this patch has the potential to screw up people who have 2-way or 4-way,
> > no hpet/pm-timer and dodgy TSCs.
> 
>  Note that all APIC-based SMP systems (even these rare i486 beasts) by 
> definition do have local APIC timers, one per CPU, with a reasonable 
> resolution which could likely be used instead. 

It wouldn't work on dual core laptop chipsets which support C3 and where
the APIC timer stops during C3.

I had a apicrunsmaintimer option for some time on x86-64 but it broke
on a few other non laptop machines for unknown reasons too, so I cannot 
really recommend it.

-Andi
