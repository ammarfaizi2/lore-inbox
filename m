Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135940AbRAHSGG>; Mon, 8 Jan 2001 13:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136199AbRAHSF4>; Mon, 8 Jan 2001 13:05:56 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:26869 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S135940AbRAHSFt>; Mon, 8 Jan 2001 13:05:49 -0500
Date: Mon, 8 Jan 2001 16:05:23 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
cc: hch@caldera.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101081034.CAA17681@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, David S. Miller wrote:
>    From: Christoph Hellwig <hch@caldera.de>
> 
>    don't you think the writepage file operation is rather hackish?
> 
> Not at all, it's simply direct sendfile support.  It does
> not try to be any fancier than that.

I really think the zerocopy network stuff should be ported
to kiobuf proper.

The usefulness of the patch you posted is rather .. umm ..
limited. Having proper kiobuf support would make it possible
to, for example, do zerocopy network->disk data transfers
and lots of other things.

Furthermore, by using kiobuf for the network zerocopy stuff
there's a good chance the networking code will be integrated.
Otherwise we just might end up with a zero-copy-for-everything-
except-networking Linux 2.5 kernel ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
