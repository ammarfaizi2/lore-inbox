Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132846AbQL1XsS>; Thu, 28 Dec 2000 18:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132847AbQL1XsI>; Thu, 28 Dec 2000 18:48:08 -0500
Received: from Cantor.suse.de ([194.112.123.193]:37394 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132846AbQL1Xr5>;
	Thu, 28 Dec 2000 18:47:57 -0500
Date: Fri, 29 Dec 2000 00:17:21 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
Message-ID: <20001229001721.B25388@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva> <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com> <20001228231722.A24875@gruyere.muc.suse.de> <200012282233.OAA01433@pizda.ninka.net> <20001228235836.A25388@gruyere.muc.suse.de> <200012282254.OAA01772@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012282254.OAA01772@pizda.ninka.net>; from davem@redhat.com on Thu, Dec 28, 2000 at 02:54:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 02:54:52PM -0800, David S. Miller wrote:
>    Date: Thu, 28 Dec 2000 23:58:36 +0100
>    From: Andi Kleen <ak@suse.de>
> 
>    Why exactly a power of two ? To get rid of ->index ? 
> 
> To make things like "page - mem_map" et al. use shifts instead of
> expensive multiplies...

I thought that is what ->index is for ? 

Also gcc seems to be already quite clever at dividing through small
integers, e.g. using mul and shift and sub, so it may not be even worth to reach
for a real power-of-two. 

I suspect doing the arithmetics is at least faster than eating the 
cache misses because of ->index. 

-Andikkk


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
