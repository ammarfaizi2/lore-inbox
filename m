Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVLHJPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVLHJPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 04:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVLHJPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 04:15:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55224 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750859AbVLHJPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 04:15:47 -0500
Date: Thu, 8 Dec 2005 09:15:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051208091542.GA9538@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpi-devel@lists.sourceforge.net
References: <20051208030242.GA19923@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208030242.GA19923@srcf.ucam.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 03:02:42AM +0000, Matthew Garrett wrote:
> Hi!
> 
> The included patch does three things:
> 
> 1) It adds basic support for binding SCSI and SATA devices to ACPI 
> device handles. At the moment this is limited to hosts, and in practice 
> it's probably limited to SATA ones (ACPI doesn't spec how SCSI devices 
> should appear in the DSDT, so I'm guessing that in general they don't). 
> Given a host, you can DEVICE_ACPI_HANDLE(dev) it to get the handle to 
> the ACPI device - this should be handy for implementing suspend 
> functions, since the methods should be in a standard location underneath 
> this.


NACK.  ACPI-specific hacks do not have any business at all in the scsi layer.

