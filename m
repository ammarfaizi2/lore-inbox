Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132925AbQL2AKo>; Thu, 28 Dec 2000 19:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132940AbQL2AKe>; Thu, 28 Dec 2000 19:10:34 -0500
Received: from Cantor.suse.de ([194.112.123.193]:27908 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132925AbQL2AKU>;
	Thu, 28 Dec 2000 19:10:20 -0500
Date: Fri, 29 Dec 2000 00:39:52 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
Message-ID: <20001229003952.A28063@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva> <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com> <20001228231722.A24875@gruyere.muc.suse.de> <200012282233.OAA01433@pizda.ninka.net> <20001228235836.A25388@gruyere.muc.suse.de> <200012282254.OAA01772@pizda.ninka.net> <20001229001721.B25388@gruyere.muc.suse.de> <200012282314.PAA01997@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012282314.PAA01997@pizda.ninka.net>; from davem@redhat.com on Thu, Dec 28, 2000 at 03:14:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 03:14:56PM -0800, David S. Miller wrote:
>    Date: Fri, 29 Dec 2000 00:17:21 +0100
>    From: Andi Kleen <ak@suse.de>
> 
>    On Thu, Dec 28, 2000 at 02:54:52PM -0800, David S. Miller wrote:
>    > To make things like "page - mem_map" et al. use shifts instead of
>    > expensive multiplies...
> 
>    I thought that is what ->index is for ? 
> 
> It is for the page cache identity Andi... you know, page_hash(mapping, index)...

Oops, I confused it with the 2.0 page->map_nr, which did exactly that.

I should have known better.  Thanks for correcting this brainfart.

> And the add/sub/shift expansion of a multiply/divide by constant even
> in its' most optimal form is often not trivial, it is something on the
> order of 7 instructions with waitq debugging enabled last time I
> checked.

Wonder if it looks better with wq debugging turned off or a compressed
->zone.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
