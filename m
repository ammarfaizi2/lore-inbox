Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132868AbQL2ACb>; Thu, 28 Dec 2000 19:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132883AbQL2ACW>; Thu, 28 Dec 2000 19:02:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10625 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132868AbQL2ACD>;
	Thu, 28 Dec 2000 19:02:03 -0500
Date: Thu, 28 Dec 2000 15:14:56 -0800
Message-Id: <200012282314.PAA01997@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ak@suse.de
CC: ak@suse.de, torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001229001721.B25388@gruyere.muc.suse.de> (message from Andi
	Kleen on Fri, 29 Dec 2000 00:17:21 +0100)
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva> <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com> <20001228231722.A24875@gruyere.muc.suse.de> <200012282233.OAA01433@pizda.ninka.net> <20001228235836.A25388@gruyere.muc.suse.de> <200012282254.OAA01772@pizda.ninka.net> <20001229001721.B25388@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 29 Dec 2000 00:17:21 +0100
   From: Andi Kleen <ak@suse.de>

   On Thu, Dec 28, 2000 at 02:54:52PM -0800, David S. Miller wrote:
   > To make things like "page - mem_map" et al. use shifts instead of
   > expensive multiplies...

   I thought that is what ->index is for ? 

It is for the page cache identity Andi... you know, page_hash(mapping, index)...

And the add/sub/shift expansion of a multiply/divide by constant even
in its' most optimal form is often not trivial, it is something on the
order of 7 instructions with waitq debugging enabled last time I
checked.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
