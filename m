Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTIIUES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTIIUES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:04:18 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:30081
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264363AbTIIUEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:04:12 -0400
Date: Tue, 9 Sep 2003 16:02:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable
 data
In-Reply-To: <20030909204803.N4216@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0309091559110.14426@montezuma.fsmlabs.com>
References: <20030909204803.N4216@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Russell King wrote:

> --- orig/drivers/char/watchdog/amd7xx_tco.c	Sat Jun 14 22:33:48 2003
> +++ linux/drivers/char/watchdog/amd7xx_tco.c	Tue Sep  9 20:45:16 2003
> @@ -294,7 +294,7 @@
>  	.fops	= &amdtco_fops
>  };
>  
> -static struct pci_device_id amdtco_pci_tbl[] __initdata = {
> +static struct pci_device_id amdtco_pci_tbl[] = {
>  	/* AMD 766 PCI_IDs here */
>  	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7443, PCI_ANY_ID, PCI_ANY_ID, },
>  	{ 0, }

That's not a bug.

> --- orig/drivers/char/watchdog/i810-tco.c	Sun Aug  3 11:21:11 2003
> +++ linux/drivers/char/watchdog/i810-tco.c	Tue Sep  9 20:45:16 2003
> @@ -301,7 +301,7 @@
>   * register a pci_driver, because someone else might one day
>   * want to register another driver on the same PCI id.
>   */
> -static struct pci_device_id i810tco_pci_tbl[] __initdata = {
> +static struct pci_device_id i810tco_pci_tbl[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },

Neither is that.

> --- orig/drivers/char/hw_random.c	Sat Jun 14 22:33:46 2003
> +++ linux/drivers/char/hw_random.c	Tue Sep  9 20:45:16 2003
> @@ -149,7 +149,7 @@
>   * register a pci_driver, because someone else might one day
>   * want to register another driver on the same PCI id.
>   */
> -static struct pci_device_id rng_pci_tbl[] __initdata = {
> +static struct pci_device_id rng_pci_tbl[] = {
>  	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
>  	{ 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },

This too
