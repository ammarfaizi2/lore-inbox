Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUHNWvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUHNWvo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 18:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUHNWvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 18:51:44 -0400
Received: from the-village.bc.nu ([81.2.110.252]:50139 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263850AbUHNWvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 18:51:43 -0400
Subject: Re: Linux SATA RAID FAQ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <411BA940.5000300@pobox.com>
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net>
	 <1092315392.21994.52.camel@localhost.localdomain> <411BA7A1.403@pobox.com>
	 <411BA940.5000300@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092520163.27405.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 14 Aug 2004 22:49:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 18:30, Jeff Garzik wrote:
> > The SX4 has an on-board DIMM (128M - 2G), through which all data _must_ 
> > pass.  The data transfer between host and on-board DIMM is a separate 
> > DMA engine and separate interrupt event from the four ATA DMA engines 
> > (one per SATA port).  There are several possibilities that are worth 
> > exploring on this card:
> > 
> > * Caching

Is it battery backed ? If it is battery backed then its useful, if not
then it becomes less useful although not always. The i2o drivers have
some ioctls so you can turn on writeback caching even without battery
backup. While this is suicidal for filesytems its just great for swap..


