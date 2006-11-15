Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966582AbWKOE2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966582AbWKOE2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966583AbWKOE2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:28:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15844
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S966582AbWKOE2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:28:13 -0500
Date: Tue, 14 Nov 2006 20:28:14 -0800 (PST)
Message-Id: <20061114.202814.70218466.davem@davemloft.net>
To: jeff@garzik.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: David Miller <davem@davemloft.net>
In-Reply-To: <455A9664.50404@garzik.org>
References: <455A938A.4060002@garzik.org>
	<20061114.201549.69019823.davem@davemloft.net>
	<455A9664.50404@garzik.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Tue, 14 Nov 2006 23:24:04 -0500

> I can't answer for the spec, but at least two independent device vendors 
> recommended to write an MSI driver that way (disable intx, enable msi).

Ok.

> Completely independent of MSI though, a PCI 2.2 compliant driver should 
> be nice and disable intx on exit, just to avoid any potential interrupt 
> hassles after driver unload.  And of course be aware that it might need 
> to enable intx upon entry.

This also sounds like it should occur in the generic PCI layer when a
PCI driver is unregistered.
