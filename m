Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWDYLBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWDYLBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWDYLBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:01:18 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:5601 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932200AbWDYLBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:01:17 -0400
Date: Tue, 25 Apr 2006 12:01:06 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Yu, Luming" <luming.yu@intel.com>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reverse pci config space restore order
Message-ID: <20060425110106.GA26217@srcf.ucam.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13D48A5@pdsmsx411.ccr.corp.intel.com> <20060425104800.GA26109@srcf.ucam.org> <1145962261.3114.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145962261.3114.23.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:51:01PM +0200, Arjan van de Ven wrote:

> it has a second drawback: it assumes all devices HAVE a driver, which
> isn't normally the case...

Yeah, I guess there's a call for keeping a pci_save_entire_state type 
call and getting pci_device_suspend to use that in the no-driver case 
(also for the "Make my driver work again quickly" case, but still)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
