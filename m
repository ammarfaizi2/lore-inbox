Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSFIX0k>; Sun, 9 Jun 2002 19:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSFIX0j>; Sun, 9 Jun 2002 19:26:39 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:16006 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315334AbSFIX0i> convert rfc822-to-8bit; Sun, 9 Jun 2002 19:26:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Russell King <rmk@arm.linux.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Mon, 10 Jun 2002 01:26:15 +0200
X-Mailer: KMail [version 1.4]
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020608.222942.111546622.davem@redhat.com> <200206090633.g596XZI472183@saturn.cs.uml.edu> <20020609094849.A30062@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206100126.15133.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 9. Juni 2002 10:48 schrieb Russell King:
> On Sun, Jun 09, 2002 at 02:33:35AM -0400, Albert D. Cahalan wrote:
> > For device --> memory DMA:
> >
> > 1. write back cache lines that cross unaligned boundries
>
> What if some of the cache lines inside the DMA region are dirty and...
>
> > 2. start the DMA
>
> get evicted now when the CPU is doing something else?
>
> > 3. invalidate the above cache lines
> > 4. invalidate cache lines that are fully inside the DMA
>
> You really need to:
>
>  1. write back cache lines that cross unaligned boundries
>  3. invalidate the above cache lines
>  2. start the DMA
>  4. invalidate cache lines that are fully inside the DMA

Starting DMA has to be the very last step.

	Regards
		Oliver

