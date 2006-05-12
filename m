Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWELNYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWELNYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWELNYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:24:10 -0400
Received: from mail.aastra.com ([216.94.98.95]:18128 "EHLO mailfrnt.aastra.com")
	by vger.kernel.org with ESMTP id S1751286AbWELNYJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:24:09 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] ide_cs: Make ide_cs work with the memory space of CF-Cards if IO space is not available (2nd revision)
Date: Fri, 12 May 2006 09:24:01 -0400
Message-ID: <ABD6885665C7C74DA65B21A1DB4E4A2FB825D9@bilmail.aastra.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ide_cs: Make ide_cs work with the memory space of CF-Cards if IO space is not available (2nd revision)
Thread-Index: AcZ1pRO3Oa8qOFVuQWSo0dZ2sf0X/wAIa6sQ
From: "Iain Barker" <ibarker@aastra.com>
To: "David Vrabel" <dvrabel@cantab.net>,
       "Thomas Kleffel \(maintech GmbH\)" <tk@maintech.de>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       <linux-pcmcia@lists.infradead.org>
X-OriginalArrivalTime: 12 May 2006 13:24:09.0042 (UTC) FILETIME=[59B20B20:01C675C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thomas Kleffel (maintech GmbH) wrote:
> +    if(is_mmio) 
> +    	my_outb = outb_mem;
> +    else
> +    	my_outb = outb_io;

David Vrabel wrote:
> Shouldn't you convert ide_cs to use iowrite8 (and friends) instead of
> doing this?


Actually, I think even better to use the primitives from ide-iops.c ?

i.e. the members of default_hwif_iops and default_hwif_mmiops, which
map to the ide_mm_outb and ide_outb functions used by the rest of the
IDE driver code?

- Iain
