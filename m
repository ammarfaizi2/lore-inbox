Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSIEOhA>; Thu, 5 Sep 2002 10:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSIEOhA>; Thu, 5 Sep 2002 10:37:00 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:35334 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317616AbSIEOg7>; Thu, 5 Sep 2002 10:36:59 -0400
Date: Thu, 5 Sep 2002 16:41:29 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Mike Isely <isely@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20-pre5-ac2: Promise Controller LBA48 DMA fixed
Message-ID: <20020905144129.GU24323@louise.pinerecords.com>
References: <1030635125.7190.116.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209050050120.20228-100000@grace.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209050050120.20228-100000@grace.speakeasy.net>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 10 days, 7:39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -		if (!hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246) {
> +		if (!(hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246)) {

Good eye, btw. I was looking at this line a couple times and always
assumed this kind of obfuscation had a purpose of some sort.

And it does after all! It's a bug :)
