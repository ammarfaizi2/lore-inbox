Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbVIVQqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbVIVQqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbVIVQqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:46:03 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:59371 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP
	id S1030441AbVIVQqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:46:02 -0400
X-ORBL: [67.124.117.85]
Date: Thu, 22 Sep 2005 09:09:02 -0700
From: Chris Wedgwood <cw@f00f.org>
To: David Sanchez <david.sanchez@lexbox.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: How to Force PIO mode on sata promise (Linux 2.6.10)
Message-ID: <20050922160902.GA14098@taniwha.stupidest.org>
References: <17AB476A04B7C842887E0EB1F268111E026FBD@xpserver.intra.lexbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026FBD@xpserver.intra.lexbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 10:03:10AM +0200, David Sanchez wrote:

> I add my card into the dma_black_list of the libata to force DMA
> disabled and the problem seems to no more appear...maybe PIO is so
> slow that the data has no time to be corrupted...  But I can NOT
> affirm that the problem is the DMA.

> I try the linux kernel 2.4,2.6.11, 2.6.12 and 2.6.13. More I try 2
> different toolchains and the problem persists...

I doubt any of those will help.  It sounds like a driver bug wrt to
non-coherent PCI.  Presumably this will also hit sparc people if they
use this hardware and some PPC too.

Does the driver use the *dma_sync* API(s)?  You might want to read
over Documentation/DMA-API.txt and see if the driver is doing the
right things.
