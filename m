Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271091AbTHLT0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 15:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271094AbTHLT0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 15:26:20 -0400
Received: from [66.212.224.118] ([66.212.224.118]:20231 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271091AbTHLT0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 15:26:19 -0400
Date: Tue, 12 Aug 2003 15:14:28 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Subject: Re: Updated MSI Patches
In-Reply-To: <3F393697.8000508@pobox.com>
Message-ID: <Pine.LNX.4.53.0308121512040.2373@montezuma.mastecende.com>
References: <7F740D512C7C1046AB53446D3720017304AE94@scsmsx402.sc.intel.com>
 <3F393697.8000508@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Jeff Garzik wrote:

> So, IMO, do_IRQ is one special case where copying code may be preferred 
> over common code.
> 
> And I also feel the same way about do_MSI().  However, I have not looked 
> at non-ia32 MSI implementations to know what sort of issues exist.

The main reason i have a preference for a seperate MSI handling path is so 
that we don't have to do the platform_irq thing in do_IRQ and we know 
what to expect wrt irq or vector. If platform_irq stays we should at 
least try and pick up on what the IA64 folks have done, But that would be 
even harder to get done right now.

	Zwane

