Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135538AbRAZQ3W>; Fri, 26 Jan 2001 11:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136193AbRAZQ3M>; Fri, 26 Jan 2001 11:29:12 -0500
Received: from nathan.polyware.nl ([193.67.144.241]:22797 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S136162AbRAZQ3B>; Fri, 26 Jan 2001 11:29:01 -0500
Date: Fri, 26 Jan 2001 17:28:56 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: mapping physical memory
Message-ID: <20010126172856.A8069@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <fa.h16635v.l0uu8m@ifi.uio.no> <027801c08784$48a04630$0701a8c0@morph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <027801c08784$48a04630$0701a8c0@morph>; from dmaas@dcine.com on Fri, Jan 26, 2001 at 05:39:38AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001 around 05:39:38 -0500, Dan Maas wrote:
> > I need to be able to obtain and pin approximately 8 MB of
> > contiguous physical memory in user space.  How would I go
> > about doing that under Linux if it is at all possible?
> 
> The only way to allocate that much *physically* contiguous memory is by
> writing a driver that grabs it at boot-time (I think the "bootmem" API is
> used for this). This is an extreme measure and should rarely be necessary,
> except in special cases such as primitive PCI cards that lack support for
> scatter/gather DMA.

Or is you want to reuse that memory between apps, use the bigphysarea
patch. Yes, its available for 2.4.0 now :)

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
