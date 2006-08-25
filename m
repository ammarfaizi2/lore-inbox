Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422627AbWHYQ4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422627AbWHYQ4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWHYQ4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:56:05 -0400
Received: from ns.suse.de ([195.135.220.2]:13003 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422627AbWHYQ4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:56:02 -0400
From: Andi Kleen <ak@suse.de>
To: Toyo Abe <toyoa@mvista.com>
Subject: Re: [PATCH -mm] x86_64: Adjust the timing of initializing cyc2ns_scale.
Date: Fri, 25 Aug 2006 18:55:57 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200608251645.k7PGjCj9003096@dhcp119.mvista.com>
In-Reply-To: <200608251645.k7PGjCj9003096@dhcp119.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608251855.57671.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 18:45, Toyo Abe wrote:
> The x86_64-mm-monotonic-clock.patch in 2.6.18-rc4-mm2 made a change to
> the updating of monotonic_base. It now uses cycles_2_ns().
> 
> I suggest that a set_cyc2ns_scale() should be done prior to the setup_irq().
> Because cycles_2_ns() can be called from the timer ISR right after the irq0
> is enabled.

Added thanks. I folded it into the original patch.

Did you actually see a failure or was this just from code review?
-Andi

