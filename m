Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbULWRZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbULWRZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbULWRZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 12:25:57 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:39537 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261273AbULWRZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 12:25:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rYk3GZGh6LQ1Rwv5Ftzm+Yd2iHHmHOi7m10Gk6nmURuDMzU1+FEcSJWfS9u2uwZcsVUhM5IqlMxxhIqfND7icLcGNxJGp1oND0YKFblacOZ+nCc8Qey+UzKluyylIw+PwpQ9OiMLnVVRRcaNRFn06I6nYTNPhw9fhCM56VmTcMA=
Message-ID: <58cb370e0412230925548c0701@mail.gmail.com>
Date: Thu, 23 Dec 2004 18:25:49 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Fred Emmott <mail@fredemmott.co.uk>
Subject: Re: [PATCH] SATA DVD Writer on SiI 3114 controller
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412231548.31080.mail@fredemmott.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412231548.31080.mail@fredemmott.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004 15:48:30 +0000, Fred Emmott <mail@fredemmott.co.uk> wrote:
> The sata-sil driver supports the controller, however it doesn't support ATAPI
> devices. Here's patches for the siimage controller (needs sata support in ide
> config enabled) to use this controller with the siimage module and atapi
> devices, against 2.6.9.

Have you tried some recent kernel (say 2.6.10-rc3) with sata_sil
and ATA_ENABLE_ATAPI defined in <linux/libata.h>?

[ ATAPI support was added to libata driver in 2.6.10-rc1. ]

> include/linux/pci_ids_h:
> 
> 923a924
> > #define PCI_DEVICE_ID_SII_3114                0x3114
> 
> drivers/ide/pci/siimage.c:
> 
> 48a49
> >               case PCI_DEVICE_ID_SII_3114:
> 1109c1110,1111
> <       /* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA")
> ---
> >       /* 2 */ DECLARE_SII_DEV("SiI3114 Serial ATA"),
> >       /* 3 */ DECLARE_SII_DEV("Adaptec AAR-1210SA")
> 1131c1133,1134
> <       { PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID,
> 0, 0, 2},
> ---
> >       { PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3114, PCI_ANY_ID, PCI_ANY_ID,
> 0,0, 2},
> >       { PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID,
> 0, 0, 3},

Please send unified diffs ('-u' option).

Bartlomiej
