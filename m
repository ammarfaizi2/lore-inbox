Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131106AbRAHTID>; Mon, 8 Jan 2001 14:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130836AbRAHTHx>; Mon, 8 Jan 2001 14:07:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10115 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129818AbRAHTHe>;
	Mon, 8 Jan 2001 14:07:34 -0500
Date: Mon, 8 Jan 2001 14:07:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Marc Lehmann <pcg@goof.com>
cc: Stefan Traby <stefan@hello-penguin.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010108195425.A2472@cerebro.laendle>
Message-ID: <Pine.GSO.4.21.0101081405270.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Marc Lehmann wrote:

> On Mon, Jan 08, 2001 at 01:33:50PM -0500, Alexander Viro <viro@math.psu.edu> wrote:
> > And prefix would be what? "/"? Besides, I said that you don't have
> > read permissions on /foo, not search ones.
> 
> You do not need read permissions on /foo to make pathconf on it. This
> makes sense: you are not reading the directory...

Exactly. You do need them for open(). You need successful open() to
be able to use fpathconf(). Ergo, there are cases when pathconf()
can't be implemented via fpathconf(). QED.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
