Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVCPTBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVCPTBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVCPTBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:01:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14798 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262746AbVCPTAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:00:49 -0500
Message-ID: <42388247.8050706@pobox.com>
Date: Wed, 16 Mar 2005 14:00:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guido Villa <piribillo@yahoo.it>
CC: Manuel Lauss <mano@roarinelk.homelinux.net>, linux-kernel@vger.kernel.org
Subject: Re: Error with Sil3112A SATA controller and Maxtor 300GB HDD
References: <20050312160704.22527.qmail@gg.mine.nu>            <4233254F.3000509@roarinelk.homelinux.net> <20050316184523.30672.qmail@gg.mine.nu>
In-Reply-To: <20050316184523.30672.qmail@gg.mine.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guido Villa wrote:
> Manuel Lauss writes:
> 
>> I happen to have a SiI 3112A controller and a Maxtor 6B300S0 attached to
>> it, formatted with ext2. Never had any problems. I just copied
>> 200GB of data to it, worked flawlessly. (Vanilla 2.6.11)
>> Maybe its the Motherboard?
> 
> 
> Hi Manuel,
> I was checking my kernel configuration, and some doubts arised in my 
> mind. Would you please check if my parameters are the same as yours?
> set:
> CONFIG_IDE_GENERIC

Unless you are loading an IDE driver at 0x1f0, 0x170 (legacy IDE), don't 
use the IDE generic driver.


> CONFIG_BLK_DEV_IDEPCI
> CONFIG_SCSI
> CONFIG_BLK_DEV_SD
> CONFIG_SCSI_SATA
> CONFIG_SCSI_SATA_SIL
> unset:
> CONFIG_BLK_DEV_GENERIC
> CONFIG_BLK_DEV_SIIMAGE (I'm unsure on this)

Otherwise, looks OK to me.

	Jeff


