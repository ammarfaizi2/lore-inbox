Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbQLBSWI>; Sat, 2 Dec 2000 13:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbQLBSV6>; Sat, 2 Dec 2000 13:21:58 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:25433 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130013AbQLBSVr>; Sat, 2 Dec 2000 13:21:47 -0500
Date: Sat, 2 Dec 2000 19:58:49 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
cc: folkert@vanheusden.com, "Theodore Y Ts'o" <tytso@mit.edu>,
        Kernel devel list <linux-kernel@vger.kernel.org>, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <Pine.LNX.4.10.10012021108350.31306-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.21.0012021955570.11787-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Indeed, you are correct.  Is vpnd broken then, for assuming
> that it can gather the required randomness in one read?

Yep. It assumes that if the required randommness numbers aren't met a read
to /dev/random will block.

And it's not the only program that assumes this : I also did. 

/dev/random is called a blocking random device, which more or less implies
that it will totally block. I suggest we put this somewhere in the kernel
docs, since lots of people out there assume that it totally blocks.

Means I've got to updates some sources of mine :)

> Matthew.


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
