Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262277AbREUAcZ>; Sun, 20 May 2001 20:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262279AbREUAcP>; Sun, 20 May 2001 20:32:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40182 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262277AbREUAcI>;
	Sun, 20 May 2001 20:32:08 -0400
Date: Sun, 20 May 2001 20:32:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.LNX.4.33.0105210135240.1569-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0105202006200.10653-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 May 2001, Ingo Molnar wrote:

> 
> On Sun, 20 May 2001, Alexander Viro wrote:
> 
> > Linus, as much as I'd like to agree with you, you are hopeless
> > optimist. 90% of drivers contain code written by stupid gits.
> 
> 90% of drivers contain code written by people who do driver development in
> their spare time, with limited resources, most of the time serving as a
> learning excercise. And they do this freely and for fun. Accusing them of

Probably 100% of drivers contains code from more than one author.

> being 'stupid gits' is just micharacterising the situation. People do not
> get born as VFS hackers, there is a very steep learning curve, and only a
> few make it to to have knowledge like you. Much of the learning curve of
> various people has traces in drivers/*, it's more like the history of
> Linux then some coherent image of people's capabilities.

Grrr... Ingo, could you read what I said? I'm not talking about problems
coming from lack of knowledge about the kernel. I'm not saying that authors
of drivers are stupid gits (in the cases when they in all probability are
such they are usually anonymous - FUBAR Acme Inc. is all you see). I'm
not saying that 90% of code in drivers is crap.

What I am saying is that in a lot of drivers you can find a code that
is result of plain and simple lack of knowledge about basics of C. And I mean
the basics, not the nontrivial parts.

"Oh, look, I don't know C, here's that project, let's write something and
submit the patch" looks pretty stupid to me.

I'm not talking about bugs. I'm not talking about stupid interfaces.
I'm not talking about typos. I'm not talking about people doing strlen()
on arrays that came from unverified source. I'm talking about the code
that was obviously written by somebody who considers C as voodoo.

The things Linus refered to pale on that background. On the bogosity
scale we have a lot of code that is way higher. Since it manages to
stay unnoticed for years...

And no, I don't think that it's an arrogance. BTW, I don't know who
the authors of these pieces are. I know that problems they had could
be cured by reading any book on C (K&R, Bolsky, whatever) and considering
how long some of that stuff had been in the tree... Well, doesn't speak
highly of the intellect of those who'd written it.

