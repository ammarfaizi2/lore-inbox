Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbVCXSWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbVCXSWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCXSWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:22:04 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:53633 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S263144AbVCXSTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:19:37 -0500
In-Reply-To: <1111645464.5569.15.camel@gaston>
References: <1111645464.5569.15.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <6ab08e99eb9f0823f7f7fb12e728e90d@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc32/64: Map prefetchable PCI without guarded bit
Date: Thu, 24 Mar 2005 19:20:43 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619.2)
X-MIMETrack: Itemize by SMTP Server on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 24/03/2005 19:19:33,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 24/03/2005 19:19:35,
	Serialize complete at 24/03/2005 19:19:35
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While experimenting with framebuffer access performances, we noticed a
> very significant improvement in write access to it when not setting
> the "guarded" bit on the MMU mappings. This bit basically says that
> reads and writes won't have side effects (it allows speculation).

Unless the data is already in cache.

> It appears that it also disables write combining.

When the page is also cache-inhibited, it indeed does.


Btw, did you ever get to fix the problem with mapping the last page
of physical address space via /dev/mem ?


Segher

