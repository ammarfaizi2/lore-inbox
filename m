Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbUAVQkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 11:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUAVQkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 11:40:53 -0500
Received: from colo.lackof.org ([198.49.126.79]:45247 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S264565AbUAVQkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 11:40:51 -0500
Date: Thu, 22 Jan 2004 09:40:49 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       Andi Kleen <ak@colin2.muc.de>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040122164049.GB13354@colo.lackof.org>
References: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 03:51:22PM +0530, Durairaj, Sundarapandian wrote:
> I tested it on our i386 platform. 

Any chance Intel can test this on an IA64 box?

...
>  /*
> + *We map full Page size on each request. Incidently that's the size we
> + *have for config space too.
> + */

"full Page size" != 4k on several architectures.
PCI Express is going to be implemented on ia64 and power as well.

...
> diff -Naur linux-2.6.0/include/asm-i386/pci.h
...
> +#ifdef CONFIG_PCI_EXPRESS
> +/*
> + *Variable used to store the base address of the last pciexpress device
> + *accessed.
> + */
> +static u32 pcie_last_accessed_device;

Andi is right - this is a definite no-no.

grant
