Return-Path: <linux-kernel-owner+w=401wt.eu-S1161051AbXALJ5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbXALJ5P (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbXALJ5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:57:15 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40798 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161051AbXALJ5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:57:13 -0500
Date: Fri, 12 Jan 2007 10:08:36 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Message-ID: <20070112100836.58738dbc@localhost.localdomain>
In-Reply-To: <20070112042800.28794.95095.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	<20070112042800.28794.95095.sendpatchset@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 05:28:00 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> [PATCH] ide: add ide_use_fast_pio() helper
> 
> * add ide_use_fast_pio() helper for use by host drivers
> * add DMA capability and autodma checks to ide_use_dma()
>   - au1xxx-ide/it8213/it821x drivers didn't check for (id->capability & 1)

For the IT8211/2 in SMART this check shouldn't be made.

>   - ide-cris driver didn't set ->autodma

You've changed the behaviour there. Should the default be autodma=0 ?

