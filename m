Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWBVAfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWBVAfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWBVAfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:35:33 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26279
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422639AbWBVAfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:35:32 -0500
Date: Tue, 21 Feb 2006 16:35:17 -0800 (PST)
Message-Id: <20060221.163517.61593616.davem@davemloft.net>
To: mchan@broadcom.com
Cc: jeffm@suse.com, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: [PATCH] tg3: netif_carrier_off runs too early; could still be
 queued when init fails
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1140559048.20584.20.camel@rh4>
References: <20060221.133947.05470613.davem@davemloft.net>
	<43FB9718.4050606@suse.com>
	<1140559048.20584.20.camel@rh4>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael Chan" <mchan@broadcom.com>
Date: Tue, 21 Feb 2006 13:57:28 -0800

> On Tue, 2006-02-21 at 17:41 -0500, Jeff Mahoney wrote:
> 
> > dmesg after modprobe tg3:
> > tg3.c:v3.49 (Feb 2, 2006)
> > ACPI: PCI Interrupt 0000:0a:02.0[A] -> GSI 24 (level, low) -> IRQ 201
> > Uhhuh. NMI received for unknown reason 21 on CPU 0.
> > Dazed and confused, but trying to continue
> > Do you have a strange power saving mode enabled?
> > tg3_test_dma() Write the buffer failed -19
> > tg3: DMA engine test failed, aborting.
> 
> You're getting an NMI during tg3_init_one() which means that the NIC is
> probably bad. I did a quick test on the same version of the 5701 NIC
> with the same tg3 driver and it worked fine.
> 
> Please find out if the NIC is known to be bad. Thanks.

I wonder if this is how this platform informs the cpu of master-abort
or target-abort cycles?  It could maybe also be an IRQ routing
problem...

