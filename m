Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbWJKR0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbWJKR0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbWJKR0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:26:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13502 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161152AbWJKR0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:26:45 -0400
Subject: Re: [PATCH 3/3] drivers/scsi/NCR5380.c: Replacing yield() with a
	better alternative
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, James.Bottomley@steeleye.com,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <1160571242.19143.320.camel@amol.verismonetworks.com>
References: <1160571242.19143.320.camel@amol.verismonetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Oct 2006 18:52:55 +0100
Message-Id: <1160589175.16513.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-11 am 18:24 +0530, ysgrifennodd Amol Lad:
> For this driver schedule_timeout_schedule() seems to be a better
> alternative. 
> 
> *Please see if the function should be called with 1 jiffy delay or more
> is better*

You want cond_resched() for this driver as its polling the hardware for
a change that should occur very soon. (Actually you want to throw the
hardware in the bin)

Alan

