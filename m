Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752065AbWFWVMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbWFWVMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWFWVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:12:46 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:34994 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752065AbWFWVMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:12:45 -0400
Date: Fri, 23 Jun 2006 16:12:42 -0500
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: netdev@vger.kernel.org, john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: e1000: Janitor: Use #defined values for literals
Message-ID: <20060623211242.GQ8866@austin.ibm.com>
References: <20060623163624.GM8866@austin.ibm.com> <449C49F9.6090005@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449C49F9.6090005@intel.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 01:07:21PM -0700, Auke Kok wrote:
> Linas Vepstas wrote:
> >Minor janitorial patch: use #defines for literal values.
> >
> >-	pci_enable_wake(pdev, 3, 0);
> >-	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
> >+	pci_enable_wake(pdev, PCI_D3hot, 0);
> >+	pci_enable_wake(pdev, PCI_D3cold, 0);
> > 
> I Acked this but that's silly - the patches sent yesterday already change 
> the code above and this patch is no longer needed (thanks Jesse for 
> spotting this).
> 
> This patch would conflict with them so please don't apply.

Oh, OK, I didn't see the patches sent yesterday, I tripped over this
on an unrelated code walk.

--linas
