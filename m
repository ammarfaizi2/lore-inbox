Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbULJEr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbULJEr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbULJEr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:47:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:35230 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261702AbULJEr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:47:28 -0500
Subject: Re: [PATCH] Don't touch BARs of host bridges
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Chris Dearman <chris@mips.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61.0412092349560.6535@perivale.mips.com>
References: <Pine.LNX.4.61.0412092349560.6535@perivale.mips.com>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 15:46:38 +1100
Message-Id: <1102653999.22763.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 00:20 +0000, Maciej W. Rozycki wrote:
> Hello,
> 
>  BARs of host bridges often have special meaning and AFAIK are best left 
> to be setup by the firmware or system-specific startup code and kept 
> intact by the generic resource handler.  For example a couple of host 
> bridges used for MIPS processors interpret BARs as target-mode decoders 
> for accessing host memory by PCI masters (which is quite reasonable).  

Not very reasonable in fact imho but that happens on some embedded PPCs
was well :) So I agree, that would be useful to skip them. I'm not sure
about PCI_CLASS_NOT_DEFINED tho ...



