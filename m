Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVCYHSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVCYHSx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVCYHSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:18:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33448 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261483AbVCYHSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:18:45 -0500
Message-ID: <4243BB48.3010505@pobox.com>
Date: Fri, 25 Mar 2005 02:18:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?S=F8ren_Lott?= <soren3@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 
References: <aa3a704505032423037a52ce53@mail.gmail.com>
In-Reply-To: <aa3a704505032423037a52ce53@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Søren Lott wrote:
> in the SATA kconfig menu, the help message from  
> Intel PIIX/ICH SATA support says:
> 
>  CONFIG_SCSI_ATA_PIIX:
> 
> This option enables support for ICH5 Serial ATA.
>  If PATA support was enabled previously, this enables
>  support for select Intel PIIX/ICH PATA host controllers.
> 
> anyone care to clarify if this mean that having enabled:
> 
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> i can use the PATA ports on a ICH5 controller through libata ?
> if not, which is exactly the meaning of "If PATA support was enabled
> previously" on this message ?

I agree it is quite confusing wording.  Probably should remove all 
reference to PATA in the CONFIG_SCSI_ATA_PIIX Kconfig entry.

The comment is referring to the somewhat-hidden fact that if you define 
ATA_ENABLE_PATA in include/linux/libata.h, then libata will support your 
Intel PIIX PATA controllers, in addition to the Intel PIIX SATA controllers.

However, since ATAPI support isn't yet stable, this is of limited 
usefulness.

	Jeff



