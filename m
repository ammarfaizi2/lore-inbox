Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbULHN6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbULHN6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbULHN6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:58:38 -0500
Received: from [213.146.154.40] ([213.146.154.40]:21655 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261232AbULHN6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:58:25 -0500
Date: Wed, 8 Dec 2004 13:58:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick van de Lageweg <patrick@bitwizard.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, Eric Wood <eric@interplas.com>,
       bmckinlay@perle.com, tmckinlay@perle.com
Subject: Re: [PATCH] SX
Message-ID: <20041208135824.GC31975@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick van de Lageweg <patrick@bitwizard.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Eric Wood <eric@interplas.com>, bmckinlay@perle.com,
	tmckinlay@perle.com
References: <20041208133000.GD19937@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208133000.GD19937@bitwizard.nl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Not used anymore??? - PVDL */
> +#if 1
>  #ifdef CONFIG_PCI
>  static struct pci_device_id sx_pci_tbl[] = {
>  	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, PCI_ANY_ID, PCI_ANY_ID },
> @@ -258,6 +260,7 @@
>  };
>  MODULE_DEVICE_TABLE(pci, sx_pci_tbl);
>  #endif /* CONFIG_PCI */
> +#endif

this is nessecary for installers to autoprobe the driver.  But you
should absolutely convert the driver to the pci_driver model so it's
used inside the driver aswell.

