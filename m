Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265540AbSJXQiB>; Thu, 24 Oct 2002 12:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbSJXQiB>; Thu, 24 Oct 2002 12:38:01 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:26820 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265540AbSJXQiA>; Thu, 24 Oct 2002 12:38:00 -0400
Subject: Re: [PATCH] New ARPHRD types
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Solomon Peachy <solomon@linux-wlan.com>
Cc: "David S. Miller" <davem@rth.ninka.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021024155345.GC11876@linux-wlan.com>
References: <20021021221936.GA32390@linux-wlan.com>
	<1035330936.16084.23.camel@rth.ninka.net>
	<20021023141651.GA6644@linux-wlan.com>
	<1035433080.9629.8.camel@rth.ninka.net>
	<20021024145822.GA11876@linux-wlan.com>
	<1035473936.9867.60.camel@irongate.swansea.linux.org.uk> 
	<20021024155345.GC11876@linux-wlan.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 18:01:14 +0100
Message-Id: <1035478874.9867.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 16:53, Solomon Peachy wrote:
> Out of curiousity, how far back to you trust the code? 2.2? 2.0? I only
> ask because a lot of the driver work I do is for underpowered
> embedded targets running relatively ancient 2.0 kernels. 

I trust it back to 2.2, Im not sure about 2.0 but its probably ok.

> > > 2) write an 802.11 equivalent of the code in eth.c
> > That may be much cleaner and easier to get right. Its also easier to
> > maintain
> 
> That's what I've been planning to do all along.   It will be nice not
> having to convert 802.3<-->802.11 in every wireless driver.. plus the
> added benefit of not having to realloc/memcpy buffers to work around
> dumb DMA engines that require contiguious buffers..

Remember that you want to land IP frame headers on a 4 byte boundary if 
possible. Thats sometimes a conflicting constraint alas

