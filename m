Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267644AbSLFWhm>; Fri, 6 Dec 2002 17:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbSLFWhm>; Fri, 6 Dec 2002 17:37:42 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:39855 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267644AbSLFWhl>; Fri, 6 Dec 2002 17:37:41 -0500
Subject: Re: 2.4.18 beats 2.5.50 in hard drive access????
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Ashley <dash@xdr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212061929.gB6JTvq10286@xdr.com>
References: <200212061929.gB6JTvq10286@xdr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 23:20:45 +0000
Message-Id: <1039216845.22983.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 19:29, David Ashley wrote:
>     ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:pio, hdb:DMA
>     ide1: BM-DMA at 0x1888-0x188f, BIOS settings: hdc:pio, hdd:DMA

When we read the settings DMA was disabled on hda and hdc. We therefore
assumed the BIOS did that for a reason and followed caution.

What happens if you do

	hdparm -d1 /dev/hda

?

