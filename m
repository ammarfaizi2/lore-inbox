Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317129AbSFKP5X>; Tue, 11 Jun 2002 11:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317142AbSFKP5W>; Tue, 11 Jun 2002 11:57:22 -0400
Received: from earth.ayrnetworks.com ([64.166.72.139]:40628 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S317129AbSFKP5W>;
	Tue, 11 Jun 2002 11:57:22 -0400
Date: Tue, 11 Jun 2002 08:57:11 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: oliver@neukum.name, roland@topspin.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020611085711.A7520@ayrnetworks.com>
In-Reply-To: <20020610.233850.60926092.davem@redhat.com> <200206110938.52090.oliver@neukum.name> <20020611.003625.05877183.davem@redhat.com> <20020611.004305.96601553.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 12:43:05AM -0700, David S. Miller wrote:
>    From: "David S. Miller" <davem@redhat.com>
>    Date: Tue, 11 Jun 2002 00:36:25 -0700 (PDT)
> 
>    The DMA_ALIGN attribute doesn't work, on some systems the PCI
>    cacheline size is determined at boot time not compile time.
> 
> Another note, it could be per-PCI controller what this cacheline size
> is.  We'll need to pass in a pdev to the alignment interfaces to
> do this correctly.
> 
> So none of this can be done at compile time folks.

Why is this a problem? So you just make a static inline that takes the
pdev and does the Right Thing at runtime... It's implementation-
dependent whether it's a compile-time macro or a more elaborate
inline...
