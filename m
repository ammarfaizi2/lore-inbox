Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267758AbUG3RYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267758AbUG3RYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267756AbUG3RYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:24:19 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:11785 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267753AbUG3RYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:24:14 -0400
Date: Fri, 30 Jul 2004 18:24:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730182410.A12171@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Jon Smirl <jonsmirl@yahoo.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <200407301010.29807.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200407301010.29807.jbarnes@engr.sgi.com>; from jbarnes@engr.sgi.com on Fri, Jul 30, 2004 at 10:10:29AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 10:10:29AM -0700, Jesse Barnes wrote:
> +	unsigned long start = dev->resource[PCI_ROM_RESOURCE].start;
> +	int size = dev->resource[PCI_ROM_RESOURCE].end -
> +		dev->resource[PCI_ROM_RESOURCE].start;

pci_resource_start and pci_resource_len please.

> +		.name = "rom",
> +		.mode = S_IRUGO | S_IWUSR,

do we really want it world readable if a read messes with pci config
space?

> +	if (pdev->resource[PCI_ROM_RESOURCE].start) {
> +		pci_rom_attr.size = pdev->resource[PCI_ROM_RESOURCE].end -
> +			pdev->resource[PCI_ROM_RESOURCE].start;

as above.

