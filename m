Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274868AbTGaVLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274867AbTGaVLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:11:13 -0400
Received: from mail0.lsil.com ([147.145.40.20]:47797 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S273031AbTGaVLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:11:07 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570185F3CF@EXA-ATLANTA.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: "'Jens Axboe'" <axboe@suse.de>, "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
Subject: RE: [ANNOUNCE] megaraid 2.00.6 patch for kernels without hostlock
Date: Thu, 31 Jul 2003 17:10:50 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, that's definitely a good idea. Expect a new driver with this change.
BTW, is there a kernel version beyond which all versions would support per
host lock, and I mean a 2.4.x kernel :-)

Thanks
-Atul Mukker

> -----Original Message-----
> From: Jens Axboe [mailto:axboe@suse.de]
> Sent: Thursday, July 31, 2003 5:06 AM
> To: Bagalkote, Sreenivas
> Cc: 'linux-kernel@vger.kernel.org'; 'linux-scsi@vger.kernel.org';
> 'linux-megaraid-devel@dell.com'
> Subject: Re: [ANNOUNCE] megaraid 2.00.6 patch for kernels without
> hostlock
> 
> 
> On Wed, Jul 30 2003, Bagalkote, Sreenivas wrote:
> > Please apply this patch to megaraid 2.00.6 driver for 
> kernels that don't
> > support per host lock. This can be found at :
> > 
> > ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.6/
> 
> It's easily possible to keep the impact of maintaining a driver across
> such kernels a lot smaller, by simply using the same lock in the
> spin_lock calls and just assign that lock to adapter->lock or
> io_request_lock depending on the kernel.
> 
> -- 
> Jens Axboe
> 
> _______________________________________________
> Linux-megaraid-devel mailing list
> Linux-megaraid-devel@dell.com
> http://lists.us.dell.com/mailman/listinfo/linux-megaraid-devel
> Please read the FAQ at http://lists.us.dell.com/faq or search 
> the list archives at http://lists.us.dell.com/htdig/
> 
