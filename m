Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWBVTEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWBVTEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWBVTEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:04:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43395 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751394AbWBVTEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:04:11 -0500
Date: Wed, 22 Feb 2006 11:07:11 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Corey Minyard <minyard@acm.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with NETIF_F_HIGHDMA
Message-ID: <20060222190711.GB27645@sorel.sous-sol.org>
References: <43FCB1B3.8090101@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FCB1B3.8090101@acm.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Corey Minyard (minyard@acm.org) wrote:
> I was looking at a problem with a new system we are trying to get up and
> running.  It has a 32-bit only PCI network device, but is a 64-bit
> (x86_64) system.  Looking at the code for NETIF_F_HIGHDMA (which, when
> not set on a PCI network device, means that it cannot do 64-bit
> accesses) in net/core/dev.c, it seems wrong to me.

Why would NETIF_F_HIGHDMA if it's 32-bit only PCI network device?
Typically net drivers do pci_set_dma_mask, and set features accordingly.
Then pci_map_* should just work.

thanks,
-chris
