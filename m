Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUIOMhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUIOMhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUIOMhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:37:08 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:39833 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S264953AbUIOMhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:37:02 -0400
Message-ID: <4148370B.4070704@rtr.ca>
Date: Wed, 15 Sep 2004 08:35:23 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lsml@rtr.ca>, James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com> <1095186343.2008.29.camel@mulgrave> <4147AB5A.4060804@rtr.ca> <20040915024720.GA23694@havoc.gtf.org>
In-Reply-To: <20040915024720.GA23694@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would really like to work on consolidating the ATA code in libata,
though.  As the name implies, it's a library -- don't feel that your
driver must conform to the libata driver API in order to make use of all
its functions.  And feel free to add to it.

Yes, there are definite code sharing possibilities there to be explored.
Right now, my first priority is to get support for this hardware
into the kernel.  This same driver source will also be backported
to mid-2.4.xx series, both Redhat and generic.

After that, we can modify some interfaces to reduce the small overlaps
that may present.

Next revision is due out later today.  It may still have a few warts
to work out, but I think it is looking much better than before.

Better to have a decent hardware driver within the tree,
than an unknown vendor-only binary driver outside the tree.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
