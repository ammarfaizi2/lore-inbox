Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWBHIik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWBHIik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWBHIik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:38:40 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:14005 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1030271AbWBHIik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:38:40 -0500
Date: Wed, 8 Feb 2006 11:38:38 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Gabriele Gorla <gorlik@penguintown.net>
Cc: rth@twiddle.net, gregkh@suse.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.15.3] alpha/pci: set cache line size for cards ignored by SRM
Message-ID: <20060208113838.A28024@jurassic.park.msu.ru>
References: <37389.10.0.0.8.1139352883.squirrel@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <37389.10.0.0.8.1139352883.squirrel@mail>; from gorlik@penguintown.net on Tue, Feb 07, 2006 at 02:54:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 02:54:43PM -0800, Gabriele Gorla wrote:
> Set the cache line size in the PCI configuration space to a reasonable
> value. SRM does not seem to set this register for the PCI cards that it
> does not recognize. This makes drivers that expect cache line size to be
> set by the card bios work on alpha.

I don't see such drivers in the mainline.

Anyhow, the PCI_CACHE_LINE_SIZE setting is critical only for devices
that do memory-write-invalidate. In this case a driver must call
pci_set_mwi() which takes care of PCI_CACHE_LINE_SIZE.

The patch is NAKed.

Ivan.
