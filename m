Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265400AbTL2UfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbTL2Uer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:34:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29593 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265391AbTL2UdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:33:13 -0500
Date: Mon, 29 Dec 2003 21:33:07 +0100
From: Jens Axboe <axboe@suse.de>
To: xander vanwiggen <xander@alexandria.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atapi cd reported twice in dmesg??
Message-ID: <20031229203307.GP3086@suse.de>
References: <20031226232652.40543.qmail@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226232652.40543.qmail@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26 2003, xander vanwiggen wrote:
> 
> Hello,
> I'm migrating to 2.6 after having used 2.0,2.2,2.4 for quite
> some years now.
> At a first glance, I read ide-scsi is dropped. Okay, no SCSI
> support at all for me then. I have one CD writer, and now it
> gets reported twice, which I don't understand. I have
> CONFIG_IDE,CONFIG_BLK_DEV_IDE,CONFIG_BLK_DEV_IDEDSK,CONFIG_IDEDISK_MULTIMODE,CONFIG_BLK_DEV_IDECD
> set. dmesg reports: "hdc: PCRW804, ATAPI CD/DVD-ROM drive" first
> (ok), then "hdc: ATAPI 32X CDROM CD-R/RW drive, 2048kB Cache,
> DMA". Prior to the second report, an error is generated:

The first is the generic ide probe, the second is ide-cd registering the
device. There is nothing wrong, that is how it's supposed to look.

-- 
Jens Axboe

