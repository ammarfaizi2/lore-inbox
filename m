Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbTGIRSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268449AbTGIRSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:18:15 -0400
Received: from ns.suse.de ([213.95.15.193]:18 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268445AbTGIRSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:18:10 -0400
Date: Wed, 9 Jul 2003 19:32:46 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Readd BUG for SMP TLB IPI
Message-Id: <20030709193246.059ee57d.ak@suse.de>
In-Reply-To: <1057770255.6255.70.camel@dhcp22.swansea.linux.org.uk>
References: <20030709124915.3d98054b.ak@suse.de>
	<1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
	<20030709134109.65efa245.ak@suse.de>
	<1057769607.6262.63.camel@dhcp22.swansea.linux.org.uk>
	<20030709185823.1f243367.ak@suse.de>
	<1057770255.6255.70.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Jul 2003 18:04:15 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2003-07-09 at 17:58, Andi Kleen wrote:
> > > It can happen to any PII/PIII box, its just very very rare on others, so
> > > rare I guess such crashes are in the noise.
> > 
> > How do you know it an happen on them? Do you have backtraces?
> 
> I sat down with a BP6 owner and did lots of debugging.

I meant on the not known-to-be-nearly-unusable boards. Or are you saying that
on the other boards the APIC bus could be lossy too, but it's very unlikely? 

[my personal feeling would be to consider the lossy APIC bus to be a hardware
problem, like an MCE that cannot be really handled] 

> > If the BUG was there they wouldn't be in the noise.  With the incomplete/broken
> > handling it's just a silent hang.
> 
> I'm not arguing BUG is better than hang, but working right is better than BUG 8)

I suspect when you have a lossy APIC bug you will run into problems with other IPIs too,
it's really an uphill fight which you are likely to lose.

Anyways, having a clear BUG will make it easier to evaluate if there is really
a problem.

-Andi
