Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756744AbWKSQSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744AbWKSQSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 11:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756745AbWKSQSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 11:18:08 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:42831 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1756744AbWKSQSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 11:18:06 -0500
Date: Sun, 19 Nov 2006 11:18:06 -0500
From: ROBERT HANCOCK <hancockr@shaw.ca>
Subject: Re: ata2: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl
In-reply-to: <cb8795142da89.455f6345@shaw.ca>
To: linux-kernel@vger.kernel.org, christiand59@web.de
Message-id: <d037c80430c7f.45603d6e@shaw.ca>
MIME-version: 1.0
X-Mailer: Sun Java(tm) System Messenger Express 6.2-7.05 (built Sep  5 2006)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7bit
Content-disposition: inline
X-Accept-Language: en
References: <cb8795142da89.455f6345@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian wrote:
> 
> FYI:
> My system config is one 400GB disk at sda, and two 250GB disks on a dmraid 
> nvidia-fakeraid set of sdb and sdc.
> 
> My kernel message buffer gets quickly overrun by a flood of these error 
> messages:
> 
> Nov 17 22:48:12 ubuntu kernel: [  119.566540] attempt to access beyond end of 
> device
> Nov 17 22:48:12 ubuntu kernel: [  119.566602] sdb: rw=0, want=976784000, 
> limit=488397168

This seems like some other issue. For some reason the kernel is trying to access something way out at about 465GB on the /dev/sdb device..

> p.s:
> Why does the kernel report a queue depth of 31/32, but hdparm says its 32? Is 
> this correct?
> 
> ata1.00: ATA-7, max UDMA7, 781422768 sectors: LBA48 NCQ (depth 31/32)

The drive supports 32 but libata reserves one queue entry for its own use, therefore the actual queue depth in use is 31.
