Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310274AbSCGKXg>; Thu, 7 Mar 2002 05:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293508AbSCGKXc>; Thu, 7 Mar 2002 05:23:32 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:61944 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S310279AbSCGKXU>; Thu, 7 Mar 2002 05:23:20 -0500
Message-ID: <3C873F96.C91E3591@redhat.com>
Date: Thu, 07 Mar 2002 10:23:18 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hank Yang <hanky@promise.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
In-Reply-To: <014701c1c5b6$a0dfb620$59cca8c0@hank>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   {DEVID_PDC20268,"PDC20268", PCI_PDC202XX, ATA66_PDC202XX, INIT_PDC202XX,
> NULL,  {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 16 },
> - /* Promise used a different PCI ident for the raid card apparently to try
> and
> -    prevent Linux detecting it and using our own raid code. We want to
> detect
> -    it for the ataraid drivers, so we have to list both here.. */
> - {DEVID_PDC20268R,"PDC20268", PCI_PDC202XX, ATA66_PDC202XX, INIT_PDC202XX,
> NULL,  {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 16 },


Interesting. So you remove support for the raid drivers. Why ?

More places where you do this:

> @@ -774,7 +784,8 @@
>        IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265) ||
>        IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20267) ||
>        IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268) ||
> -      IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R) ||
> +      IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20269) ||
> +      IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20275) ||
>        IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6210) ||
>        IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||

> diff -urN linux-2.4.18.org/include/linux/pci_ids.h
> linux/include/linux/pci_ids.h
> --- linux-2.4.18.org/include/linux/pci_ids.h Tue Feb 26 03:38:13 2002
> +++ linux/include/linux/pci_ids.h Wed Feb 27 19:45:18 2002
> @@ -603,7 +603,6 @@
>  #define PCI_DEVICE_ID_PROMISE_20246 0x4d33
>  #define PCI_DEVICE_ID_PROMISE_20262 0x4d38
>  #define PCI_DEVICE_ID_PROMISE_20268 0x4d68
> -#define PCI_DEVICE_ID_PROMISE_20268R 0x6268
>  #define PCI_DEVICE_ID_PROMISE_20269 0x4d69
>  #define PCI_DEVICE_ID_PROMISE_20275 0x1275
>  #define PCI_DEVICE_ID_PROMISE_5300 0x5300
.org/lkml/
