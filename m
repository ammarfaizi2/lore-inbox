Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVLHOxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVLHOxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVLHOxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:53:06 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:22744 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932133AbVLHOxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:53:04 -0500
Date: Thu, 8 Dec 2005 14:52:57 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051208145257.GB21946@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org> <20051208091542.GA9538@infradead.org> <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <1134050498.17102.2.camel@localhost.localdomain> <20051208141811.GB21715@srcf.ucam.org> <1134052433.17102.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134052433.17102.17.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 02:33:53PM +0000, Alan Cox wrote:

> I would say your code belongs in the ACPI subtree. At most the core code
> wants to have the generic supporting functions for 'do a taskfile' and
> if need be to call an arch/platform resume function that any pm system
> can sensibly use.

How about the hotplug notification events?

> SCSI should not know detail about ACPI, APM or anything of that nature.

Hrm. I guess this can be implemented pretty much just by cutting and 
pasting the code into drivers/acpi rather than drivers/scsi. Would that 
be considered an improvement?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
