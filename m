Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVLHNdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVLHNdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVLHNdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:33:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27870 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751181AbVLHNdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:33:10 -0500
Date: Thu, 8 Dec 2005 13:33:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051208133308.GA13267@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpi-devel@lists.sourceforge.net
References: <20051208030242.GA19923@srcf.ucam.org> <20051208091542.GA9538@infradead.org> <20051208132657.GA21529@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208132657.GA21529@srcf.ucam.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 01:26:57PM +0000, Matthew Garrett wrote:
> On Thu, Dec 08, 2005 at 09:15:42AM +0000, Christoph Hellwig wrote:
> 
> > NACK.  ACPI-specific hacks do not have any business at all in the scsi layer.
> 
> Ok. What's the right layer to do this? The current ACPI/anything else 
> glue depends on specific knowledge about the bus concerned, and needs 
> callbacks registered before devices are added to that bus. Doing it in 
> the sata layer would have the potential for unhappiness on mixed 
> sata/scsi machines.

Don't do it at all.  We don't need to fuck up every layer and driver for
intels braindamage.
