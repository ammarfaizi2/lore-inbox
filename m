Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270352AbUJTWIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270352AbUJTWIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270296AbUJTWHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:07:30 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:38665 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269013AbUJTWHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:07:01 -0400
Date: Wed, 20 Oct 2004 23:06:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Hanna Linder <hannal@us.ibm.com>, davej@codemonkey.org.uk,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: [KJ] [RFT 2.6] intel-agp.c: replace pci_find_device with pci_get_device
Message-ID: <20041020220638.GA26465@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, Hanna Linder <hannal@us.ibm.com>,
	davej@codemonkey.org.uk,
	kernel-janitors <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
References: <17420000.1098298334@w-hlinder.beaverton.ibm.com> <20041020220347.GZ16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020220347.GZ16153@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 11:03:47PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 20, 2004 at 11:52:14AM -0700, Hanna Linder wrote:
> > 
> > As pci_find_device is going away soon I have converted this file to use
> > pci_get_device instead. I have compile tested it. If anyone has this hardware
> > and could test it that would be great.
> 
> Should be converted to the pci_driver API.

No.  It's already using the pci_driver API, but the same device can be
handled differently depending on the presence of another one.  Maybe
pci_dev_present would fit here.

