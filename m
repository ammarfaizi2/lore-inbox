Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVF2BEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVF2BEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVF2BCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:02:44 -0400
Received: from mail.tyan.com ([66.122.195.4]:44560 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262390AbVF2A5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:57:24 -0400
Message-ID: <3174569B9743D511922F00A0C94314230AF973A5@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org
Subject: RE: 2.6.12 with dual way dual core ck804 MB
Date: Tue, 28 Jun 2005 18:01:15 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

some hints for you.
when using Opteron 875, the problem was more easily catched. 

in smp_callin in smpboot.c
if change
Dprintk("CPU#%d (phys ID: %d) waiting for CALLOUT\n", cpuid, phys_id);
to 
printk("CPU#%d (phys ID: %d) waiting for CALLOUT\n", cpuid, phys_id);
will have 50% to pass through.

if change
Dprintk("CALLIN, before setup_local_APIC().\n");
to 
printk("CALLIN, before setup_local_APIC().\n");

will pass through every time.

YH



> -----Original Message-----
> From: YhLu 
> Sent: Friday, June 24, 2005 4:44 PM
> To: 'Andi Kleen'
> Cc: Peter Buckingham; linux-kernel@vger.kernel.org
> Subject: RE: 2.6.12 with dual way dual core ck804 MB
> 
> start from 2.6.12.rc5.
> 
> YH 
> 
> > -----Original Message-----
> > From: Andi Kleen [mailto:ak@suse.de]
> > Sent: Friday, June 24, 2005 4:42 PM
> > To: YhLu
> > Cc: Andi Kleen; Peter Buckingham; linux-kernel@vger.kernel.org
> > Subject: Re: 2.6.12 with dual way dual core ck804 MB
> > 
> > On Fri, Jun 24, 2005 at 04:42:58PM -0700, YhLu wrote:
> > > Andi,
> > > 
> > > the timing problem come out from 2.6.12.rc5....
> > 
> > What do you mean? It's gone or it started there?
> > -Andi
> > 
