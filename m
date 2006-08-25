Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWHYROs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWHYROs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWHYROs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:14:48 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:32828 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1030214AbWHYROr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:14:47 -0400
Date: Fri, 25 Aug 2006 10:14:46 -0700 (LDT)
Message-Id: <20060825.101446.01368169.toyoa@mvista.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] x86_64: Adjust the timing of initializing
 cyc2ns_scale.
From: Toyo <toyoa@mvista.com>
In-Reply-To: <200608251855.57671.ak@suse.de>
References: <200608251645.k7PGjCj9003096@dhcp119.mvista.com>
	<200608251855.57671.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH -mm] x86_64: Adjust the timing of initializing cyc2ns_scale.
Date: Fri, 25 Aug 2006 18:55:57 +0200

> On Friday 25 August 2006 18:45, Toyo Abe wrote:
> > The x86_64-mm-monotonic-clock.patch in 2.6.18-rc4-mm2 made a change to
> > the updating of monotonic_base. It now uses cycles_2_ns().
> > 
> > I suggest that a set_cyc2ns_scale() should be done prior to the setup_irq().
> > Because cycles_2_ns() can be called from the timer ISR right after the irq0
> > is enabled.
> 
> Added thanks. I folded it into the original patch.
> 
> Did you actually see a failure or was this just from code review?
> -Andi
> 
I didn't see any failure on it. It was just a speculation. But I think
it's better thing here.

Best Regards,
toyo
