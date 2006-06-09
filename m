Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWFICf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWFICf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWFICf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:35:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14307 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751369AbWFICf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:35:26 -0400
Message-ID: <4488DE68.9020603@garzik.org>
Date: Thu, 08 Jun 2006 22:35:20 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Philipp Baumann <pumuckl@i12.com>, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.17-rc6-mm1] Oops during sata_promise init
References: <4488A927.2070809@i12.com> <20060608165040.29e54147.akpm@osdl.org>
In-Reply-To: <20060608165040.29e54147.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Thanks.  ap->ioaddr.scr_addr is zero in pdc_sata_scr_write().

Very interesting.  Did I miss the hardware info?

I wonder if its a PATA port, and is going down an incorrect path.  The 
PATA port would naturally not have SATA phy registers (SCRs).

	Jeff


