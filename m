Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQJ3XRn>; Mon, 30 Oct 2000 18:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbQJ3XRd>; Mon, 30 Oct 2000 18:17:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40711 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129103AbQJ3XRa>; Mon, 30 Oct 2000 18:17:30 -0500
Date: Mon, 30 Oct 2000 15:17:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test10-pre7
In-Reply-To: <Pine.GSO.4.21.0010301810170.1177-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10010301516180.1085-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Alexander Viro wrote:
> 
> Fine with me. Just let's remember that it should be revisited in 2.5.
> What about filemap_swapout()? If you agree with checking ->mapping
> there... looks like we are done with that crap for the time being.

Yup, I agree. I already applied your patch, and did the additional
"mapping" check in nfs_sync_page. We should be ok for now, the only wart
being the fact that sync_page() is ugly.

But better ugly than broken.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
