Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbUKCFCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbUKCFCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 00:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUKCFCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 00:02:07 -0500
Received: from cantor.suse.de ([195.135.220.2]:18127 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261431AbUKCFCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 00:02:05 -0500
Date: Wed, 3 Nov 2004 05:55:47 +0100
From: Andi Kleen <ak@suse.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.9: Only handle system NMIs on the BSP
Message-ID: <20041103045547.GA25334@wotan.suse.de>
References: <Pine.LNX.4.58L.0411030125340.32079@blysk.ds.pg.gda.pl> <20041103024944.GA8907@wotan.suse.de> <Pine.LNX.4.58L.0411030255410.32079@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0411030255410.32079@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 03:04:06AM +0000, Maciej W. Rozycki wrote:
> On Wed, 3 Nov 2004, Andi Kleen wrote:
> 
> > >  While discussing races in the NMI handler's trailer fiddling with RTC
> > > registers, I've discovered we incorrectly attempt to handle NMIs coming
> > > from the system (memory errors, IOCHK# assertions, etc.) with all
> > > processors even though the interrupts are only routed to the bootstrap
> > > processor.  If one of these events coincides with a NMI watchdog tick it
> > 
> > Where is this documented/guaranteed that only APs get such NMIs? 
> 
>  Only the BSP gets them (not APs) and it's we who arrange for that. ;-)  
> We only enable LVT1 on the BSP -- APs have this input masked.  See 
> setup_local_APIC().

Ok, then it's fine for me. Thanks. 

-Andi
