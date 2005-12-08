Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVLHN1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVLHN1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVLHN1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:27:07 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:43403 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750977AbVLHN1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:27:05 -0500
Date: Thu, 8 Dec 2005 13:26:57 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051208132657.GA21529@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org> <20051208091542.GA9538@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208091542.GA9538@infradead.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 09:15:42AM +0000, Christoph Hellwig wrote:

> NACK.  ACPI-specific hacks do not have any business at all in the scsi layer.

Ok. What's the right layer to do this? The current ACPI/anything else 
glue depends on specific knowledge about the bus concerned, and needs 
callbacks registered before devices are added to that bus. Doing it in 
the sata layer would have the potential for unhappiness on mixed 
sata/scsi machines.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
