Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbQLBSfT>; Sat, 2 Dec 2000 13:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbQLBSfJ>; Sat, 2 Dec 2000 13:35:09 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:29469 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129631AbQLBSe4>; Sat, 2 Dec 2000 13:34:56 -0500
Date: Sat, 2 Dec 2000 12:03:56 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Igmar Palsenberg <maillist@chello.nl>
cc: Matthew Kirkwood <matthew@hairy.beasts.org>, folkert@vanheusden.com,
        "Theodore Y Ts'o" <tytso@mit.edu>,
        Kernel devel list <linux-kernel@vger.kernel.org>, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <Pine.LNX.4.21.0012021955570.11787-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.3.96.1001202115753.27887T-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2000, Igmar Palsenberg wrote:
> > Indeed, you are correct.  Is vpnd broken then, for assuming
> > that it can gather the required randomness in one read?
> 
> Yep. It assumes that if the required randommness numbers aren't met a read
> to /dev/random will block.
> 
> And it's not the only program that assumes this : I also did. 
> 
> /dev/random is called a blocking random device, which more or less implies
> that it will totally block. I suggest we put this somewhere in the kernel
> docs, since lots of people out there assume that it totally blocks.

"totally block"?

For a blocking fd, read(2) has always blocked until some data is
available.  There has never been a guarantee, for any driver, that
a read(2) will return the full amount of bytes requested.

There is no need to document this...  man read(2)  ;-)

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
