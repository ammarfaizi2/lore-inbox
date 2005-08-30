Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVH3QXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVH3QXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVH3QXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:23:17 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:28887 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932203AbVH3QXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:23:17 -0400
Subject: Re: linux-2.6.13 PCI bogus resource allocation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508301118590.4347@chaos.analogic.com>
References: <Pine.LNX.4.61.0508301118590.4347@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Aug 2005 17:52:12 +0100
Message-Id: <1125420732.8276.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-30 at 11:21 -0400, linux-os (Dick Johnson) wrote:
> we have been starting at 0x30001000. Now, with
> Linux-2.6.13, I see that PCI/Bus resources are
> being allocated on top of this RAM!!! This should

2.6.13 redoes the bus assignments which might have indeed made mem= do
totally the wrong thing in this case.

> not be. In my BIOS I always check for RAM before
> allocating PCI resources. It's trivial, write 0L, read

Not a very safe idea for general purpose systems. Its neither reliable
nor safe. Fortunately we also know the BIOS idea of where the device
resources are allocated so we know which bits either thinks are RAM and
which to avoid.

Alan



