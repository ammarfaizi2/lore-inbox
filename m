Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVEPSG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVEPSG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVEPSG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:06:28 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3041 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261776AbVEPSGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:06:21 -0400
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050516154020.GD949@merlin.emma.line.org>
References: <200505151121.36243.gene.heskett@verizon.net>
	 <20050515152956.GA25143@havoc.gtf.org>
	 <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	 <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org>
	 <1116241957.6274.36.camel@laptopd505.fenrus.org>
	 <20050516112956.GC13387@merlin.emma.line.org>
	 <1116252157.6274.41.camel@laptopd505.fenrus.org>
	 <20050516144831.GA949@merlin.emma.line.org>
	 <1116256005.21388.55.camel@localhost.localdomain>
	 <20050516154020.GD949@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116266671.21452.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 May 2005 19:04:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-05-16 at 16:40, Matthias Andree wrote:
> On Mon, 16 May 2005, Alan Cox wrote:
> Is tagged command queueing (we'll need the ordered tag here) compatible
> with all SCSI adaptors that Linux supports?

TCQ is a device not controller property.

> What if tagged command queueing is switched off for some reason
> (adaptor or HW incapability, user override) and the drive still has
> write cache enable = true and queue algorithm modifier = 1 (which

We turn the write back cache off if TCQ isn't available.

