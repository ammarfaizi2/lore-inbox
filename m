Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVIAUDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVIAUDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVIAUDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:03:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:15060 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030345AbVIAUDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:03:34 -0400
Message-ID: <43175E8F.7080700@pobox.com>
Date: Thu, 01 Sep 2005 16:03:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <20050901144038.GA25830@infradead.org> <43175B23.8040803@pobox.com> <20050901195832.GA14602@infradead.org>
In-Reply-To: <20050901195832.GA14602@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Sep 01, 2005 at 03:48:51PM -0400, Jeff Garzik wrote:
> 
>>Christoph Hellwig wrote:
>>
>>>>+#include <linux/kernel.h>
>>>>+#include <linux/module.h>
>>>>+#include <linux/pci.h>
>>>>+#include <linux/init.h>
>>>>+#include <linux/blkdev.h>
>>>>+#include <linux/delay.h>
>>>>+#include <linux/interrupt.h>
>>>>+#include <linux/sched.h>
>>>>+#include <linux/dma-mapping.h>
>>>>+#include "scsi.h"
>>>
>>>
>>>pleaese don't include "scsi.h" in new drivers.  It will go away soon.
>>>Use the <scsi/*.h> headers and get rid of usage of obsolete constucts
>>>in your driver.
>>
>>
>>It stays until the rest of the libata drivers lose the include.
>>
>>After ATAPI support is done, I can stop 2.4.x support, and this and 
>>several other compat-isms will go away.
> 
> 
> NACK.  Jeff, I accept that you don't want to convert old drivers yet,
> but this is not acceptable for new drivers.  We don't allow it for any
> new scsi LLDDs, and that includes libata drivers.

Sorry, you don't get to NAK that change, since it affects 2.4.x 
maintenance of this new driver.

As I said, the include does away simultaneously for all libata drivers.

	Jeff



