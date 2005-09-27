Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVI0Fgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVI0Fgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 01:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVI0Fgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 01:36:53 -0400
Received: from mail.tor.primus.ca ([216.254.136.21]:30131 "EHLO
	smtp-02.primus.ca") by vger.kernel.org with ESMTP id S964819AbVI0Fgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 01:36:52 -0400
Message-ID: <4338DA65.20600@dtbb.net>
Date: Mon, 26 Sep 2005 22:36:37 -0700
From: Tyler <pml@dtbb.net>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
CC: Brett Russ <russb@emc.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <4319AE7B.3010304@dtbb.net>
In-Reply-To: <4319AE7B.3010304@dtbb.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Brett Russ wrote:
>
>> Some (non-functional) cleanup modifications since the version 0.10
>> driver I sent out 2005-08-30.  Also adding signed-off-by for Jeff's
>> upstream push.  This is my libata compatible low level driver for
>> the Marvell SATA family.  Currently it successfully runs in PIO mode
>> on a 6081 chip.  EDMA support is in the works and should be done
>> shortly.  Review, testing (especially on other flavors of Marvell),
>> comments welcome.
>>
>> Thank you,
>> BR
>>
>> Signed-off-by: Brett Russ <russb@emc.com>
>>
> [snip..]
>
> Please find attached patches that add the Adaptec 1420SA controller to 
> the PCI ID list in the driver, and a small note in the kernel config 
> option to state so.  This is untested as of currently, if anyone has a 
> 1420SA to try, that would be great..  The one I had access to is now 
> gone to a remote location out of reach for testing.  I read in one 
> post I found with google, that the 1420SA uses a 6541 chip instead of 
> a 6041, but I am not able to verify this, and also don't know if it 
> may still work as a 6041.  The card is still a Sata2, PCI-X card, with 
> 4 ports, the same as the 6041 based cards.  This patch may or may not 
> be useful..  The card comes with a manufacturer ID of 9005 according 
> to a linux PCI-ID list, which is a secondary id of Adaptec's known as 
> ADAPTEC2, and an actual PCI Id of 0241.
>
> Signed-off-by: Tyler Guthrie <pml@dtbb.net>
>
>
> --- linux-2.6.13.orig/drivers/scsi/Kconfig      2005-09-03 
> 06:42:20.000000000 -0700
> +++ linux-2.6.13drivers/scsi/Kconfig    2005-09-03 06:44:29.000000000 
> -0700
> @@ -466,6 +466,8 @@
>          This option enables support for the Marvell Serial ATA family.
>          Currently supports 88SX[56]0[48][01] chips.
>
> +         Also Including Adaptec 1420SA Card (using marvell chip 
> pci-id 0x0241).
> +
>          If unsure, say N.
>
> config SCSI_SATA_NV
>
> --- linux-2.6.13.orig/drivers/scsi/sata_mv.c    2005-09-03 
> 06:40:07.000000000 -0700
> +++ linux-2.6.13/drivers/scsi/sata_mv.c         2005-09-03 
> 06:39:47.000000000 -0700
> @@ -286,6 +286,7 @@
>        {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
>        {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6080), 0, 0, chip_608x},
>        {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6081), 0, 0, chip_608x},
> +       {PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, 0x0241), 0, 0, chip_604x},
>        {}                      /* terminate list */
> };
>
>
>
> Tyler.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-------- Original Message --------
From: - Sun Sep 25 07:30:35 2005
Return-Path: <dekien@pandora.be>
Delivered-To: 1-pml@dtbb.net
(Postfix) with ESMTP id 0C44938138    for <pml@dtbb.net>; Sun, 25 Sep 
2005 16:25:31 +0200 (CEST)
Message-ID: <4336B356.3020600@pandora.be>
Date: Sun, 25 Sep 2005 16:25:26 +0200
From: Jeroen <dekien@pandora.be>
To: pml@dtbb.net
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
X-Antivirus: AVG for E-mail 7.0.344 [267.11.6]

Hi,

I have just tested you patch and i can confirm that is work with the
adaptec 1420SA.  If u would like any further information feel free to 
contact me.

thanks

Jeroen



-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.344 / Virus Database: 267.11.7/112 - Release Date: 9/26/2005

