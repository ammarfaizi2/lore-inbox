Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVKRQbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVKRQbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVKRQbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:31:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:59055 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932317AbVKRQbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:31:18 -0500
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 09/10] blk: add FUA support
	to IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, axboe@suse.de, jgarzik@pobox.com,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0511180817p48602e3ap6d3ef49b842e8a00@mail.gmail.com>
References: <20051117153509.B89B4777@htj.dyndns.org>
	 <20051117153509.5A77ED53@htj.dyndns.org>
	 <58cb370e0511171239i16e0aaffr237ef7af68ece946@mail.gmail.com>
	 <437DF271.6050702@gmail.com>
	 <58cb370e0511180817p48602e3ap6d3ef49b842e8a00@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Nov 2005 17:02:44 +0000
Message-Id: <1132333365.25914.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-18 at 17:17 +0100, Bartlomiej Zolnierkiewicz wrote:
> Probably it should work fine given that drive->mult_count is on.
> 
> The only controller using drive->vdma in the current tree is cs5520
> so you should confirm this with Mark Lord & Alan Cox.

The CS5520 VDMA performs PIO commands with controller driven DMA to PIO
of the data blocks. Thus it can do any PIO command with one data in or
out phase as if it were DMA.

> Long-term we should see if it is possible to remove dynamic IDE
> drive configuration and always just use the best possible settings.

Hotplug rather prevents that. For the lifetime of a drive connection
most of the settings ought to be settable once. Speeds are the obvious
exception.

