Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTJOMhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTJOMhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:37:24 -0400
Received: from fep07-0.kolumbus.fi ([193.229.0.51]:28019 "EHLO
	fep07-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S263053AbTJOMhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:37:23 -0400
X-Mailer: Openwave WebEngine, version 2.8.10 (webedge20-101-191-20030113)
From: <mika.penttila@kolumbus.fi>
To: Herbert Xu <herbert@gondor.apana.org.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SCSI] Set max_phys_segments to sg_tablesize
Date: Wed, 15 Oct 2003 15:37:22 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20031015123722.CSSJ7495.fep07-app.kolumbus.fi@mta.imail.kolumbus.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Many SCSI host drivers assume that use_sg will be <= sg_tablesize.
>>> Hence they may break under 2.6 as the number of physical segments
>>> is not limited by sg_tablesize.  This patch fixes that.
>> 
>> Physical segments don't matter,  hw segments does and it's bounded >by sg_tablesize.

>It does matter if the driver can't cope with it.


But this fix may hurt performance with well behaving drivers in iommu systems. It's better to fix the broken drivers I think.

--Mika


