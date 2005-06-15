Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFORqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFORqD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFORqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:46:03 -0400
Received: from loopy.telegraphics.com.au ([202.45.126.152]:34519 "EHLO
	loopy.telegraphics.com.au") by vger.kernel.org with ESMTP
	id S261233AbVFORp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:45:56 -0400
Date: Thu, 16 Jun 2005 03:45:54 +1000 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux MIPS <linux-mips@vger.kernel.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] Jazzsonic driver updates
In-Reply-To: <Pine.LNX.4.61.0506160218310.24328@loopy.telegraphics.com.au>
Message-ID: <Pine.LNX.4.61.0506160336410.24908@loopy.telegraphics.com.au>
References: <200503070210.j272ARii023023@hera.kernel.org>
 <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org>
 <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au>
 <20050615114158.GA9411@linux-mips.org> <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au>
 <20050615142717.GD9411@linux-mips.org> <Pine.LNX.4.61.0506160218310.24328@loopy.telegraphics.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Jun 2005, I wrote:

> ... the chip then decides where in that area the recieved packet gets 
> buffered ... and that is why I was asking for an alternative to 
> vdma_log2phys...

But I forgot that it is possible to have the sonic chip store no more than 
one packet in each buffer before moving to the next one in the ring 
(though this isn't the case at present). So, as you say, vdma_log2phys 
isn't really required.

-f
