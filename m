Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWFUNv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWFUNv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWFUNv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:51:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55785 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750867AbWFUNvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:51:55 -0400
Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver
	for PDC202XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Snitzer <snitzer@gmail.com>
Cc: Erik@echohome.org, linux-kernel@vger.kernel.org
In-Reply-To: <170fa0d20606210634t1ee3d186gd638feefd64d247d@mail.gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAMbmKIDqIQhHt6BBy4E2zd0BAAAAAA==@EchoHome.org>
	 <1150887073.15275.34.camel@localhost.localdomain>
	 <23064.216.68.248.2.1150895349.squirrel@www.echohome.org>
	 <1150896840.15275.62.camel@localhost.localdomain>
	 <170fa0d20606210634t1ee3d186gd638feefd64d247d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 15:07:09 +0100
Message-Id: <1150898829.15275.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 09:34 -0400, ysgrifennodd Mike Snitzer:
> I have a PDC20267 and tried out 2.6.17 + linux-2.6.17-ide1.gz  The
> resulting pata_pdc202xx_old module didn't initialize the controller on
> boot (via initrd).  Is there some other CONFIG option or linux cmdline
> that should be used?

No it should find it as soon as you load the module. If the device is
not the primary IDE controller (hda-hdd) you can set CONFIG_IDE = y,
include drivers for your other controller and get some debug info.

Usually "it didnt initialize" reports are from people with mixed old/new
IDE in their kernel or initrd, or initrds missing the required modules.

Stick a printk in pdc_init before the pci_register_driver call and
you'll know for sure if the module is getting loaded. If it is then send
me an lspci and I'll have a deeper look


Alan

