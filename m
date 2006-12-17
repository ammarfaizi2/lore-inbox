Return-Path: <linux-kernel-owner+w=401wt.eu-S932178AbWLQSAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWLQSAG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 13:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWLQSAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 13:00:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47401 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbWLQSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 13:00:04 -0500
Date: Sun, 17 Dec 2006 09:59:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
In-Reply-To: <orwt4qaara.fsf@redhat.com>
Message-ID: <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
 <orwt4qaara.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2006, Alexandre Oliva wrote:

> On Dec 16, 2006, Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > The whole reason the LGPL exists is that people realized that if they 
> > don't do something like that, the GPL would have been tried in court, and 
> > the FSF's position that anything that touches GPL'd code would probably 
> > have been shown to be bogus.
> 
> Or that people would feel uncomfortable about the gray area and avoid
> using the GPLed code in cases in which this would be perfectly legal
> and advantageous to Free Software. 

I agree. A lot of it is about "comfort". But you can _easily_ handle that 
comfort level in other ways.

For example, many programs already do have clarifications that certain 
uses do not introduce any GPL dependency what-so-ever. The kernel COPYING 
makes it clear that user space is not a derived work of the kernel, for 
example. You don't actually need to use a different license for this case: 
if all you're looking for is "comfort", then you really can comfort people 
other ways.

For example, glibc could easily have just come out and said the thing that 
is obvious to any sane person: "using this library as just a standard 
library does not make your program a derived work". 

There really wassn't much need for the LGPL, I think. 

> There are many factors involved and you're oversimplifying the issue.

Sure. It's never clear-cut. It's never black and white. 

> Some claim that, in the case of static linking, since there part of
> the library copied to the binary, it is definitely a case of derived
> work.

No, the sane way to think about it is that linking just creates an 
"aggregate" work. It's no less "aggregate" than creating a CD-ROM that 
contains the library and some random program: you "link" them together 
with "mkisofs".

Why do people think that using "ln" is _any_ different from using 
"mkisofs". Both create one file that contains multiple pieces. What's the 
difference - really?

Of course, the _aggregate_ still needs permission from all the copyright 
holders in order to be distributed, that goes without saying. But the 
GPLv2 clearly allows aggregation.

And don't get me wrong: I do not say that "linking" _never_ creates 
derived works. I'm just saying that "linking" is just a technical step, 
and as such is not the answer to whether something is derived or not. 
Things can be derived works of each other _without_ being linked, and they 
may not be derived works even if they _are_ linked.

So "linking" basically has very little to do with "derived" per se.

Linking does have one thing that it implies: it's maybe a bit "closer" 
relationship between the parts than "mkisofs" implies. So there is 
definitely a higher _correlation_ between "derived work" and "linking", 
but it's really a correlation, not a causal relationship.

For example, if you link two object files together where neither is a 
"library" with standard interfaces, then the result is most likely a 
derived work from both. But it wasn't the "act of linking" that caused 
that to happen, but simply the fact that they were part of a bigger whole, 
and were meaningless apart from each other.

Think of this in the sense of a book. Does binding pages together create a 
"derived work"? Not always: you can have anthologies (which are 
*aggregations* of works with *independent* copyright), and the binding of 
pages together didn't really do anything to the independent pieces. But 
clearly, if you're talking about individual pages in one story, then each 
individual page is not an independent work in itself.

Linking is the same way. Are the two pieces you link "independent works" 
on their own? If so, the end result is really just an aggregate, no 
different from using "mkisofs". They are still clearly separable: you 
could have built either piece AGAINST SOMETHING ELSE.

> Some then take this notion that linking creates derived works and
> further extend the claim that using dynamic linking is just a trick to
> avoid making the binary a derived work, and thus it shouldn't be taken
> into account, even if there still is *some* information from the
> dynamic library that affects the linked binary.

See how this whole "trick" discussion becomes a totally moot point once 
you realize that "mkisofs" and "ld" aren't really all that different.

Does "mkisofs" create a derived work, or an aggregate? Does "ld" create a 
derived work or an aggregate? The answer in BOTH cases is the same: it's 
not about the name of the command, or some technical detail about how the 
pieces are bound together. Copyright law doesn't concern itself with 
"mkisofs" vs "ld". It would be totally INSANE if it did, wouldn't you say?

So if it isn't about "mkisofs" vs "ld", then _what_ is it about?

I gave you one answer above. Feel free to make your own judgements. I'm 
just saying that anybody who thinks that copyright law cares about 
"mkisofs" vs "ld" is just obviously misguided.

So I think the "dynamic vs static" linking argument is a red herring. It 
_is_ meaningful in two ways:

 - static linking obviously means that even at a MINIMUM, the result will 
   _contain_ both things, so at a minimum, you do need the permission to 
   distribute the pieces as parts of an aggregate work.

   In contrast,  in dynamic linking, since you're not _actually_ 
   distributing the thing you linked against, you don't need to have the 
   license to distribute it as an aggregate work.

   This particular thing is a non-issue wrt the GPLv2, since you always 
   have the right to do distribution of aggregates, but it does come up in 
   some OTHER licenses.

 - you can (quite validly, in my opinion) argue that dynamic linking is a 
   sign of separation, and as such if you're able to do dynamic linking 
   against an unmodified second work, you have a much stronger argument 
   that they really can be seen as two independent works. But notice how 
   this was not a technical argument about the _linking_ per se: this 
   comes back to a much more important (and much more fundamental) issue 
   of whether things are independent (and being independent is certainly 
   one _requirement_ for them not being derived works)

   In other words: the _ability_ to do dynamic linking is certainly 
   meaningful, not because of the linking itself, but because of what it 
   implies from a perspective of "independence".

So to get back to the example of glibc: if a program _could_ have been 
linked against some other library, then that pretty clearly shows that 
it's really independent of glibc, and the linking is "mere aggregation" 
exactly the same way "mkisofs" is generally considered "mere aggregation".

And that is actually true whether you link dynamically or statically. 
Since the GPLv2 allows aggregation, I think you can very much argue in 
front of a judge that you could have linked statically against even a 
GPL'd glibc.

But notice how the thing changes if you talk about a specialized library 
like libqt - and notice how it again doesn't really matter whether you do 
dynamic or static linking. Libqt is still a work in its own right, but 
what about the program that links _to_ it? You can't generally really 
claim that it could equally well have been built against some other 
library, so now that program - whether linked dynamically or statically - 
obviously cannot stand on its own independently of libqt.

As a result, something that links against libqt is very different from 
something that links against glibc. 

But note how it wasn't "static" vs "dynamic" that mattered AT ALL. What 
mattered was whether they had independent lives.

And finally, in case it's not clear: I'm not a lawyer, and I don't play 
one on TV, and if I did, I'd be better looking and wouldn't spend my time 
on some technical discussion forum. So I'm not claiming that my viewpoint 
is "Right(tm)".

But I _am_ claiming that it makes a hell of a lot more sense as a 
viewpoint than the "linking is magic" argument does.

			Linus
