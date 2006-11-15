Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966112AbWKOEHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966112AbWKOEHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966506AbWKOEHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:07:19 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27285
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S966112AbWKOEHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:07:18 -0500
Date: Tue, 14 Nov 2006 20:07:19 -0800 (PST)
Message-Id: <20061114.200719.38322619.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: torvalds@osdl.org, jeff@garzik.org, linux-kernel@vger.kernel.org,
       tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: David Miller <davem@davemloft.net>
In-Reply-To: <1163563260.5940.205.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<1163563260.5940.205.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Nov 2006 15:01:00 +1100

> Out of curiosity. Are you sure there is no case of stupid bridge
> converting the MSI into some APIC/whatever interrupt for the CPU
> potentially before all previous DMA have been fully pushed to the
> coherent domain (still in some internal store queue for example) ?

That would really suck, wouldn't it :)

However, they have to do all the work of processing the memory
transation that the MSI is on the PCI bus, I don't think they would go
so far out of their way to reorder things even if they converted the
MSI packet into a PIN to the APIC, for example.
