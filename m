Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264361AbRFORXS>; Fri, 15 Jun 2001 13:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264213AbRFORW6>; Fri, 15 Jun 2001 13:22:58 -0400
Received: from [207.21.185.24] ([207.21.185.24]:36111 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP
	id <S264202AbRFORWz>; Fri, 15 Jun 2001 13:22:55 -0400
Message-ID: <3B2A4434.8E2E16FC@lnxw.com>
Date: Fri, 15 Jun 2001 10:21:56 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: kmalloc
In-Reply-To: <3B2A3F90.799ACAC4@lnxw.com> <20010615140525.A960@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hey thanks,

The memory i need is not for DMA usage so i don't care
if it is contiguous or not.


later,
Petko


Arnaldo Carvalho de Melo wrote:
> 
> Em Fri, Jun 15, 2001 at 10:02:08AM -0700, Petko Manolov escreveu:
> >       Hi there,
> >
> > AFAIK there was similar discusion almos a year
> > ago but i can't remember the details.
> >
> > kmalloc fails to allocate more than 128KB of
> > memory regardless of the flags (GFP_KERNEL/USER/ATOMIC)
> >
> > Any ideas?
> >
> > I am not quite sure if this is the expected behavior.
> 
> yes, expected behaviour, at most you can allocate 32 contiguous pages with
> kmalloc, if you need more and it is not for DMA, use vmalloc, that will not
> try to use contiguous pages
> 
> - Arnaldo
