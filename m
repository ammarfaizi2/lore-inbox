Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268655AbUIMS0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268655AbUIMS0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUIMS0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:26:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42916 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268655AbUIMS0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:26:09 -0400
Subject: Re: 2.6.9-rc1-mm5 compile errors
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040913173031.GG12514@krispykreme>
References: <1095093355.3628.152.camel@dyn318077bld.beaverton.ibm.com>
	 <20040913173031.GG12514@krispykreme>
Content-Type: text/plain
Organization: 
Message-Id: <1095099747.3628.156.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Sep 2004 11:22:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep. Need this.

Thanks,
Badari

On Mon, 2004-09-13 at 10:30, Anton Blanchard wrote:
> Hi,
> 
> > arch/ppc64/kernel/pSeries_pci.c: In function `pcibios_fixup_bus':
> > arch/ppc64/kernel/pSeries_pci.c:607: error: redeclaration of `dev'
> > arch/ppc64/kernel/pSeries_pci.c:604: error: `dev' previously declared
> > here
> > arch/ppc64/kernel/pSeries_pci.c:604: warning: unused variable `dev'
> 
> I sent this to Andrew earlier.
> 
> Anton
> 
> diff -puN arch/ppc64/kernel/pSeries_pci.c~fix_pseries arch/ppc64/kernel/pSeries_pci.c
> --- 2.6.9-rc1-mm5/arch/ppc64/kernel/pSeries_pci.c~fix_pseries	2004-09-13 19:58:29.941874428 +1000
> +++ 2.6.9-rc1-mm5-anton/arch/ppc64/kernel/pSeries_pci.c	2004-09-13 19:59:21.967773089 +1000
> @@ -601,7 +601,6 @@ EXPORT_SYMBOL(pcibios_fixup_device_resou
>  void __devinit pcibios_fixup_bus(struct pci_bus *bus)
>  {
>  	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
> -	struct pci_dev *dev;
>  
>  	/* XXX or bus->parent? */
>  	struct pci_dev *dev = bus->self;
> _
> 

