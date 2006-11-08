Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754628AbWKHR6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbWKHR6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbWKHR6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:58:41 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34961 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754628AbWKHR6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:58:40 -0500
Message-ID: <45521ACE.9050606@garzik.org>
Date: Wed, 08 Nov 2006 12:58:38 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci quirks: Sort out the VIA mess once and for all	(hopefully)
References: <1163003156.23956.40.camel@localhost.localdomain>
In-Reply-To: <1163003156.23956.40.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/include/linux/libata.h linux-2.6.19-rc4-mm1/include/linux/libata.h
> --- linux.vanilla-2.6.19-rc4-mm1/include/linux/libata.h	2006-10-31 21:11:50.000000000 +0000
> +++ linux-2.6.19-rc4-mm1/include/linux/libata.h	2006-11-07 10:07:10.000000000 +0000
> @@ -109,11 +109,6 @@
>  /* defines only for the constants which don't work well as enums */
>  #define ATA_TAG_POISON		0xfafbfcfdU
>  
> -/* move to PCI layer? */
> -#define PCI_VDEVICE(vendor, device)		\
> -	PCI_VENDOR_ID_##vendor, (device),	\
> -	PCI_ANY_ID, PCI_ANY_ID, 0, 0
> -
>  static inline struct device *pci_dev_to_dev(struct pci_dev *pdev)
>  {


nit:  don't remove the "move to PCI layer?" comment, it also applies to 
code below that which you are moving.

Patch overall seems sane to me.

	Jeff


