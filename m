Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVKKUN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVKKUN1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVKKUN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:13:27 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19378
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751136AbVKKUN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:13:27 -0500
Date: Fri, 11 Nov 2005 12:13:27 -0800 (PST)
Message-Id: <20051111.121327.57756233.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Cc: agx@sigxcpu.org, linux-kernel@vger.kernel.org
Subject: Re: sparc64: Oops in pci_alloc_consistent with cingergyT2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1131738080.3174.33.camel@localhost.localdomain>
References: <20051111153354.GA19838@bogon.ms20.nix>
	<1131738080.3174.33.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 11 Nov 2005 19:41:20 +0000

> The DMA channel in question is the PCI hub to which the device is
> connected. So it should not be using NULL, it should be passing the pci
> device id of the bus controller to whom it is attached

We have USB buffer allocation routines for drivers which abstract this
away and perform all the calls correctly, so none of this knowledge
needs to be in a USB driver.
