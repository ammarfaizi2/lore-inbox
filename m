Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUFBMES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUFBMES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFBMCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:02:25 -0400
Received: from mail1.kontent.de ([81.88.34.36]:12675 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262170AbUFBMBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:01:55 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [PATCH] fix dependeces for CONFIG_USB_STORAGE
Date: Wed, 2 Jun 2004 14:00:21 +0200
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
References: <200406021116.35529.ornati@fastwebnet.it> <20040602104900.GB32474@infradead.org> <200406021352.14561.ornati@fastwebnet.it>
In-Reply-To: <200406021352.14561.ornati@fastwebnet.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406021400.21080.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Huh, why?
> 
> This HELP (taken from linux/drivers/scsi/Kconfig) is quite explicit:
> 
> config BLK_DEV_SD
>         tristate "SCSI disk support"
>         depends on SCSI
>         ---help---
>           If you want to use SCSI hard disks, Fibre Channel disks,
>           USB storage or the SCSI or parallel port version of
>           the IOMEGA ZIP drive, say Y and read the SCSI-HOWTO,
>           the Disk-HOWTO and the Multi-Disk-HOWTO, available from
>           <http://www.tldp.org/docs.html#howto>. This is NOT for SCSI
>           CD-ROMs.
> 
> So if you want to use USB Mass Storage devices (that use SCSI emulation) you 
> need also SCSI disk support (I have realized it when I've tried to mount 
> one those USB devices, without success).

The help text is misleading. You need SD to mount disks. There are other
devices which are not disks. In fact there are USB<->SCSI bridges, so
you could do everything SCSI can do, eg. attach an old scanner which needs
only SG.

	Regards
		Oliver
