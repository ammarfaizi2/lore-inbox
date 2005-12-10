Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932776AbVLJCuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776AbVLJCuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbVLJCuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:50:35 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:65231 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932769AbVLJCue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:50:34 -0500
Date: Sat, 10 Dec 2005 02:50:04 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051210025004.GB31328@srcf.ucam.org>
References: <20051209114246.GB16945@infradead.org> <20051209114944.GA1068@havoc.gtf.org> <20051209115235.GB25771@srcf.ucam.org> <43997171.9060105@pobox.com> <20051209121124.GA25974@srcf.ucam.org> <439975AB.5000902@pobox.com> <20051209122457.GB26070@srcf.ucam.org> <439A23E8.3080407@pobox.com> <20051210023426.GA31220@srcf.ucam.org> <439A4070.2000500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439A4070.2000500@pobox.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 09:41:52PM -0500, Jeff Garzik wrote:

> Do you even know if this special case is applicable outside of Dell ICH5 
> boxes?  And I thought your previous messages were referring to ICH6?

Every laptop I have access to, whether it's SATA or PATA, fires an ACPI 
notification when a drive is removed from a bay. The ICH5 case is 
probably somewhat special-cased, but when we move over to driving PATA 
with libata it's going to be a lot more useful. If ICH6 can be managed 
without resorting to ACPI, it's less necessary in the short term, but I 
think PATA support is going to require it in the end anyway (especially 
since we probably want to call the _GTM and _STM methods on PATA 
devices)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
