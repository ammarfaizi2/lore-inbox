Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269327AbUIYNR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269327AbUIYNR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 09:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUIYNR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 09:17:58 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:14306 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269323AbUIYNRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 09:17:47 -0400
Subject: Re: [RFC] put symbolic links between drivers and modules in the
	sysfs tree
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       viro@parcelfarce.linux.theplanet.co.uk, greg@kroah.com,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1096100492.17155.3.camel@laptop.fenrus.com>
References: <E1CB7YE-0004cA-00@gondolin.me.apana.org.au> 
	<1096100492.17155.3.camel@laptop.fenrus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 25 Sep 2004 09:16:15 -0400
Message-Id: <1096118180.1715.7.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-25 at 04:21, Arjan van de Ven wrote:
> btw does that mkinitrd already use 
> readlink /sys/block/sda/device/block/device
> 
> (which gives
> ../../devices/pci0000:00/0000:00:06.0/0000:03:0b.0/host1/1:0:0:0
> as output)
> 
> the pci path that gives can easily be matched to modules.pcimap to find
> the information in case of a PCI device, so at least the table in your
> mkinitrd doesn't need to contain PCI devices.....

So tell me what happens when my root device is on MCA (which is one of
my machines) or is a parisc internal device (which is another)...

Putting the modules link in relieves mkinitrd from having to understand
anything about the bus types.

James


