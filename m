Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbSLFWZR>; Fri, 6 Dec 2002 17:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbSLFWZR>; Fri, 6 Dec 2002 17:25:17 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:25838 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267641AbSLFWZQ>; Fri, 6 Dec 2002 17:25:16 -0500
Subject: Re: [RFC] generic device DMA implementation
From: Arjan van de Ven <arjanv@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, willy@debian.org, davem@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200212062226.gB6MQsr04565@localhost.localdomain>
References: <200212062226.gB6MQsr04565@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 23:32:41 +0100
Message-Id: <1039213961.1388.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 23:26, James Bottomley wrote:
> adam@yggdrasil.com said:
> > 	This makes me lean infinitesmally more toward a parameter to
> > dma_alloc rather than a separate dma_alloc_not_necessarily_consistent
> > function, because if there ever are other dma_alloc variations that we
> > want to support, it is more likely that there may be overlap between
> > the users of those features and then the number of different function
> > calls would have to grow exponentially (or we might then talk about
> > changing the API again, which is not the end of the world, but is
> > certainly more difficult than not having to do so). 
> 
> I think I like this.
> 
> how about dma_alloc to take two flags
> 
> DRIVER_SUPPORTS_CONSISTENT_ONLY
> 
> and
> DRIVER_SUPPORTS_CONSISTENT_ONLY
> DRIVER_SUPPORTS_NON_CONSISTENT
> 

I rather like Dave's suggestion. I wouldn't want to type
DRIVER_SUPPORTS_CONSISTENT_ONLY a few dozen times for example... sure
you can do that internally but exposing it to drivers... why ?

