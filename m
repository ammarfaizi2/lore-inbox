Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281050AbRKGXXW>; Wed, 7 Nov 2001 18:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281079AbRKGXXM>; Wed, 7 Nov 2001 18:23:12 -0500
Received: from madcap.apk.net ([207.54.158.16]:54184 "EHLO madcap.apk.net")
	by vger.kernel.org with ESMTP id <S281050AbRKGXW4>;
	Wed, 7 Nov 2001 18:22:56 -0500
X-IP-Test: 206.183.9.88
Date: Wed, 7 Nov 2001 18:22:52 -0500
From: Mike Kasick <ic382@apk.net>
To: Rui Sousa <rui.p.m.sousa@clix.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EMU10K1 and High Memory conflict in 2.4.13/2.4.14
Message-Id: <20011107182252.1f5ab0e8.ic382@apk.net>
In-Reply-To: <Pine.LNX.4.33.0111071206240.1005-100000@sophia-sousar2.nice.mindspeed.com>
In-Reply-To: <20011106235430.1e0df1d4.ic382@apk.net>
	<Pine.LNX.4.33.0111071206240.1005-100000@sophia-sousar2.nice.mindspeed.com>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works fine now, thanks a lot.

On Wed, 7 Nov 2001 12:08:34 +0100 (CET)
Rui Sousa <rui.p.m.sousa@clix.pt> wrote:

> On Tue, 6 Nov 2001, Mike Kasick wrote:
> 
> Edit linux/drivers/sound/emu10k1/main.c and change:
> 
> /* FIXME: is this right? */
> /* does the card support 32 bit bus master?*/
> #define EMU10K1_DMA_MASK                0xffffffff      /* DMA buffer mask for pci_alloc_consist */
> 
> to
> 
> /* FIXME: is this right? */
> /* does the card support 32 bit bus master?*/
> #define EMU10K1_DMA_MASK                0x7fffffff      /* DMA buffer mask for pci_alloc_consist */
> 
> I believe the comments say it all...
> 
> Rui Sousa
> 
> 
