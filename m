Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWGUAQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWGUAQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 20:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbWGUAQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 20:16:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53689 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030417AbWGUAQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 20:16:26 -0400
Message-ID: <44C01CD7.4030308@garzik.org>
Date: Thu, 20 Jul 2006 20:16:23 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Ed Lin <ed.lin@promise.com>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       hch <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, promise_linux <promise_linux@promise.com>
Subject: Re: [PATCH] Promise 'stex' driver
References: <NONAMEBMcvsq9IcVux1000001f9@nonameb.ptu.promise.com>	 <44BFF539.4000700@garzik.org> <1153439728.4754.19.camel@mulgrave>
In-Reply-To: <1153439728.4754.19.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Thu, 2006-07-20 at 17:27 -0400, Jeff Garzik wrote:
>> Since _no individual SCSI driver_ uses the block layer
>> tagging, it is likely that some instability and core kernel
>> development
>> will occur, in order to make that work.
> 
> That's not quite true: 53c700 and tmscsim both use it ... I could with
> the usage were wider, but at least 53c700 has pretty regular and
> constant usage ... enough I think to validate the block tag code (it's
> been using it for the last three years).

Not for the case being discussed in this thread, adapter-wide tags.

AFAICS, no file in include/scsi/* or drivers/scsi/* ever calls 
blk_queue_init_tags() with a non-NULL third arg.

The block tagging capability being discussed here is poorly validated 
due to overall underuse, and its never been used in SCSI AFAIK.

	Jeff



