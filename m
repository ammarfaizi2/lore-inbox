Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143888AbRAHOm1>; Mon, 8 Jan 2001 09:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143863AbRAHOmR>; Mon, 8 Jan 2001 09:42:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3589 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143888AbRAHOmH>; Mon, 8 Jan 2001 09:42:07 -0500
Subject: Re: Patch (repost): cramfs memory corruption fix
To: cr@sap.com (Christoph Rohland)
Date: Mon, 8 Jan 2001 14:42:18 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        adam@yggdrasil.com (Adam J. Richter), parsley@roanoke.edu,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br (Rik van Riel)
In-Reply-To: <qwwwvc6tbau.fsf@sap.com> from "Christoph Rohland" at Jan 08, 2001 02:37:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FdV7-0004gd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 7 Jan 2001, Linus Torvalds wrote:
> > I wonder what to do about this - the limits are obviously useful, as
> > would the "use swap-space as a backing store" thing be. At the same
> > time I'd really hate to lose the lean-mean-clean ramfs.
> 
> Let me repeat on this issue: shmem.c has everything needed for this
> despite read and write and they should be really easy to add. 
> 
> I did not plan to write them in the near future because I did not
> think that this is a really wanted feature. But I can look into it.

I have been thinking about this. I think we should merge the size limiting code
with the example clean ramfs code. Having spent a while debugging the LFS
checks and some other funnies I realised one problem with the ramfs in
2.4.0 as an example. It does not demonstrate error cases, which the new one
does.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
