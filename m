Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUC1TGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUC1TGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:06:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35293 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262356AbUC1TGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:06:48 -0500
Message-ID: <4067223A.1040006@pobox.com>
Date: Sun, 28 Mar 2004 14:06:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de>
In-Reply-To: <20040328181502.GO24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Yep it sure does, but try and find a drive attached to a SATA controller
> that cannot do 40MiB/sec (or something like that). Storage doesn't move
> _that_ fast, you can keep up.

Nanosecond latencies and disturbingly high throughput are already 
possibly today :)  Consider the battery-backed RAM gadgets that present 
themselves as ATA devices, or nbd over 10gige network.

In fact I'm about to strip down drivers/scsi/sata_promise.c to a driver 
that just talks to the DIMM, and another else:  drivers/block/pdc_mem.c. 
  At that point you're really just looking at the PCI bus and RAM limits...

	Jeff



