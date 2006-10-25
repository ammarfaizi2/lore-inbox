Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423152AbWJYQ0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423152AbWJYQ0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 12:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423125AbWJYQ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 12:26:05 -0400
Received: from ozlabs.org ([203.10.76.45]:42674 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422972AbWJYQ0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 12:26:04 -0400
Date: Thu, 26 Oct 2006 02:21:27 +1000
From: Anton Blanchard <anton@samba.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc3 2/2] ehea: 64K page support fix
Message-ID: <20061025162126.GB25324@krispykreme>
References: <200610251312.01235.ossthema@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610251312.01235.ossthema@de.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> +#ifdef CONFIG_PPC_64K_PAGES
> +	/* To support 64k pages we must round to 64k page boundary */
> +	epas->kernel.addr =
> +		ioremap((paddr_kernel & 0xFFFFFFFFFFFF0000), PAGE_SIZE) +
> +		(paddr_kernel & 0xFFFF);
> +#else
>  	epas->kernel.addr = ioremap(paddr_kernel, PAGE_SIZE);
> +#endif

Cant you just use PAGE_MASK, ~PAGE_MASK and remove the ifdefs
completely?

Anton
