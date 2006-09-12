Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWILOFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWILOFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWILOFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:05:05 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:18663 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S964986AbWILOFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:05:03 -0400
Date: Tue, 12 Sep 2006 07:04:53 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Message-ID: <20060912140453.GB2491@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com> <p733bbn7m6o.fsf@verdi.suse.de> <20060825124905.GD5330@frankl.hpl.hp.com> <200608251513.58729.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608251513.58729.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, Aug 25, 2006 at 03:13:58PM +0200, Andi Kleen wrote:

> > Are we already running with cr4.pce set today?
> 
> Not yet. But soon.
>  
> > The cr4.pce allows all PMC (counter) to be read at user level, not just perfctr0.
> > When enabled all counters are readable at user level from any process. A process
> > can see the value accumulated by another process (assuming monitoring in per-thread
> > mode).
> 
> Yes, we'll have to live with that.
> 
> > Some people may see this as a security risk.
> 
> Maybe some paranoiacs, but we normally don't design software for these people's
> obsessions.
> 
> > On the other hand all you see  
> > is counts.
> 
> Exactly. And you always have RDTSC anyways.
> 
> 
> > So as long as the i386/x86_64 PMU only collect counts, this could be 
> > fine. The day they can capture addresses, this becomes more problematic, I think.
> 
> We can worry about it when it happens. Whenever anyone adds that capability
> to the hardware they will hopefully add new separate ring 3 control bits.
> 
Just a follow-up on this. It already exists.

On the P4, I am planning on exporting the Last Brnch Record Stack (LBR Stack) to users of perfmon.
This provides some branch buffer similar to what we have on Itanium. Obviously, the MSRs do contains
addresses (source/target of branches).

--
-Stephane
