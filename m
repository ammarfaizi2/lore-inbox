Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbRHJH5G>; Fri, 10 Aug 2001 03:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbRHJH46>; Fri, 10 Aug 2001 03:56:58 -0400
Received: from quattro.sventech.com ([205.252.248.110]:64522 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S264942AbRHJH4o>; Fri, 10 Aug 2001 03:56:44 -0400
Date: Fri, 10 Aug 2001 03:56:56 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
Message-ID: <20010810035654.W3126@sventech.com>
In-Reply-To: <20010809151022.C1575@sventech.com> <E15UvLO-0007tH-00@the-village.bc.nu> <15218.61869.424038.30544@pizda.ninka.net> <20010809163531.D1575@sventech.com> <slrn9n71kn.28q.kraxel@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <slrn9n71kn.28q.kraxel@bytesex.org>; from kraxel@bytesex.org on Fri, Aug 10, 2001 at 07:00:39AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001, Gerd Knorr <kraxel@bytesex.org> wrote:
> > > Note, if you use the "bttv method" (ie. virt_to_bus) your driver will
> > > then fail to compile on several platforms.
> >  
> >  So noted. I already have a PCI DMA API version, but I wanted to code up
> >  a "i have an i386 and gigs of memory" version as well.
> 
> Forgot about virt_to_bus() then, it doesn't work for highmem.

I knew that already :)

The thing about 64 bit PCI cards is that there is no such thing as
highmem, so we don't need to worry about mapping it and using bounce
buffers. The device just DMA's. That's why I originally asked.

I took a look at the code in the 2.4.7 version of bttv.c and it wasn't
readily obvious what Alan was referring to. I'll spend some more time
tomorrow looking into it.

JE

