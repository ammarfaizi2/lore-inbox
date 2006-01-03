Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWACRtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWACRtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWACRtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:49:33 -0500
Received: from [81.2.110.250] ([81.2.110.250]:16081 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932468AbWACRtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:49:33 -0500
Subject: Re: HPT372N   Re: hpt366 driver oops or panic with HighPoint
	RocketRAID 1520SATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mitchell Laks <mlaks@verizon.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512270219.56956.mlaks@verizon.net>
References: <200512270219.56956.mlaks@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Jan 2006 17:51:44 +0000
Message-Id: <1136310704.22598.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-27 at 02:19 -0500, Mitchell Laks wrote:
> to use as simple block devices for linux software raid purposes.   I thought 
> they were supported on Linux, because of highpoint web site and my previous 
> experience with highpoint pata controllers was ok.

Some are, although there are problems remaining in things like clock
timing and PLL stabilization. In addition the ide/pci/hpt366.c driver
never supported the SATA bridge variants of the chipsets at all. These
require certain modes are used.

What may work if the HPT card has the onboard BIOS enabled and fitted is
to compile in the generic IDE PCI driver, say N to the HPT driver and
boot with the option "all-generic-ide".

I've been working on a new HPT372N/302N driver for libata/SATA but it
isn't yet production ready and it also does not know about the SATA
bridge rules for that chip.

>  I tried to compile the hpt3xx-opensource-v2.0.tgz against latest stable 
> kernel 2.6.14.4. After minor corrections   I have failure to compile their 
> driver due to  scsi_cmnd structure "has no member abort_reason".  Has their 
> been a change in scsi subsystem? 

Several
 
Alan

