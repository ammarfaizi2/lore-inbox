Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUKCCyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUKCCyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 21:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUKCCyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 21:54:07 -0500
Received: from cantor.suse.de ([195.135.220.2]:64215 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261352AbUKCCx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 21:53:59 -0500
Date: Wed, 3 Nov 2004 03:49:45 +0100
From: Andi Kleen <ak@suse.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.9: Only handle system NMIs on the BSP
Message-ID: <20041103024944.GA8907@wotan.suse.de>
References: <Pine.LNX.4.58L.0411030125340.32079@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0411030125340.32079@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:07:43AM +0000, Maciej W. Rozycki wrote:
> Hello,
> 
>  While discussing races in the NMI handler's trailer fiddling with RTC
> registers, I've discovered we incorrectly attempt to handle NMIs coming
> from the system (memory errors, IOCHK# assertions, etc.) with all
> processors even though the interrupts are only routed to the bootstrap
> processor.  If one of these events coincides with a NMI watchdog tick it

Where is this documented/guaranteed that only APs get such NMIs? 

I don't see such a guarantee in the AMD documentation for example ... 

-Andi
