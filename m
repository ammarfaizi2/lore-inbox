Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316933AbSFKIII>; Tue, 11 Jun 2002 04:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSFKIIH>; Tue, 11 Jun 2002 04:08:07 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:32143 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316919AbSFKIIF> convert rfc822-to-8bit; Tue, 11 Jun 2002 04:08:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 10:07:19 +0200
User-Agent: KMail/1.4.1
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020610.233850.60926092.davem@redhat.com> <20020611.003625.05877183.davem@redhat.com> <20020611.004305.96601553.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206111007.19142.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Juni 2002 09:43 schrieb David S. Miller:
>    From: "David S. Miller" <davem@redhat.com>
>    Date: Tue, 11 Jun 2002 00:36:25 -0700 (PDT)
>
>    The DMA_ALIGN attribute doesn't work, on some systems the PCI
>    cacheline size is determined at boot time not compile time.
>
> Another note, it could be per-PCI controller what this cacheline size
> is.  We'll need to pass in a pdev to the alignment interfaces to
> do this correctly.

Could you please explain this ?

I thought this was a problem of a CPU dirtying a cache line
that overlaps with an area being DMAed into. So the determining
factor should be the granularity of the dirty status of the CPU.

Are there really PCI controllers which have to physically write
much more than is transfered ?

	Now really puzzeled
		Oliver

