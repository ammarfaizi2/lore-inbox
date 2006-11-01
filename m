Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946743AbWKAJsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946743AbWKAJsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946741AbWKAJsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:48:00 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47590 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946738AbWKAJr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:47:59 -0500
Message-ID: <45486D47.9020803@pobox.com>
Date: Wed, 01 Nov 2006 04:47:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Peer Chen <pchen@nvidia.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] sata_nv: Add nvidia SATA controllers of MCP67support
 to sata_nv.c
References: <15F501D1A78BD343BE8F4D8DB854566B0C54F590@hkemmail01.nvidia.com>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C54F590@hkemmail01.nvidia.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer Chen wrote:
> Attached the patch cause my mail client always wrap the plain text format.
> Check attachment for patch,thanks.

Need one more modification:

It is the libata policy to prefer use of numeric hexidecimal constants
for the PCI device id, rather than always defining a symbol in
include/linux/pci_ids.h.  The PCI device ID is a single-use "magic
number" that is only used in the PCI ID table.

Therefore, when your patch changes the hex numbers to constants, it is
reversing that policy.

Instead, please submit a patch that simply adds more hexidecimal PCI
device ids.

	Jeff



