Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQLFCNY>; Tue, 5 Dec 2000 21:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbQLFCNH>; Tue, 5 Dec 2000 21:13:07 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:43532 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130108AbQLFCMu>; Tue, 5 Dec 2000 21:12:50 -0500
Date: Tue, 5 Dec 2000 17:41:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012051733010.967-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012051738310.967-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Linus Torvalds wrote:
> 
> Right now this is my interim patch (to clean test11). The thing to note is
> that I decreased the keyboard controller timeout by a factor of about 167,
> while making the "delay" a bit longer.

Oh, btw, I forgot to ask people to give this a whirl. I assume it fixes
the APM problems for Kai.

It definitely won't fix the silly Olivetti M4 issue (we still touch bit #2
in 0x92). We'll need to fix that by testing A20 before bothering with the
0x92 stuff. Alan, that should get fixed in 2.2.x too - clearly those
Olivetti machines can be considered buggy, but even so..

Who else had trouble with the keyboard controller?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
