Return-Path: <linux-kernel-owner+w=401wt.eu-S932644AbWLSHpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWLSHpl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWLSHpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:45:41 -0500
Received: from orion2.pixelized.ch ([195.190.190.13]:58347 "EHLO
	mail.pixelized.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644AbWLSHpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:45:40 -0500
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 02:44:59 EST
Message-ID: <4587976F.7070905@debian.org>
Date: Tue, 19 Dec 2006 08:40:31 +0100
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alexandre Oliva <aoliva@redhat.com>, Ricardo Galli <gallir@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org> <orwt4qaara.fsf@redhat.com> <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org> <orpsah6m3s.fsf@redhat.com> <Pine.LNX.4.64.0612181134260.3479@woody.osdl.org> <or64c96ius.fsf@redhat.com> <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 18 Dec 2006, Alexandre Oliva wrote:
>>> In other words, in the GPL, "Program" does NOT mean "binary". Never has.
>> Agreed.  So what?  How does this relate with the point above?
>>
>> The binary is a Program, as much as the sources are a Program.  Both
>> forms are subject to copyright law and to the license, in spite of
>> http://www.fsfla.org/?q=en/node/128#1
> 
> Here's how it relates:
>  - if a program is not a "derived work" of the C library, then it's not 
>    "the program" as defined by the GPLv2 AT ALL.
> 
> In other words, it doesn't matter ONE WHIT whether you use "ld --static" 
> or "ld" or "mkisofs" - if the program isn't (by copyright law) derived 
> from glibc, then EVEN IF glibc was under the GPLv2, it would IN NO WAY 
> AFFECT THE RESULTING BINARY.

I really don't agree.  It seems you confuse source and binary application.

The source surelly is not derived, you can link *any* libc to your
program.

But a binary is different.

Let start with your example about books: you write a book, you have
the copyright of the text, but if you publish it with X publiher, he
may use a own font.  You can read the book, scan it to extract text
(I hope fair use allows it), but not copy the book pages: there is
your text, but also copyrighted font.  Publisher should check
that the two license are compatible, as the user that links
with a new library.

For binary, it is the same. You can extract libraries and rest of
programs (better doing with sources), but until it is one binary,
it is a new mixed entity.

It is not only linking, it is mixing bytes! Some part of library is
linked statically, there are some references in the static part of
program. It is a mix and until the two part are mixed (not only linked)
you should follow both licenses for copying!

Choose any dynamic program in your machine, try to link glibc with an
other (not directly derived libc) library... you see how it is hard,
and it is very different to an "aggregation".  And dynamic links is
only the latest step of "merging" the two binaries.

Other libraries tend to be more "dynamic", but glibc mixes to much

In other word, source A, library B: the binary C is derived both from A
and B, but surelly A is not derived by B.  So IMHO IANAL, in arguments
we should not confuse the sources and the binary in the arguments, so
not calling simply "the program".


ciao
	cate


> 
> And I'm simply claiming that a binary doesn't become "derived from" by any 
> action of linking.
> 
> Even if you link using "ld", even if it's static, the binary is not 
> "derived from". It's an aggregate.
> 
> "Derivation" has nothing to do with "linking". Either it's derived or it 
> is not, and "linking" simply doesn't matter. It doesn't matter whether 
> it's static or dynamic. That's a detail that simply doesn't have anythign 
> at all to do with "derivative work".
> 
> THAT is my point. 
> 
> Static vs dynamic matters for whether it's an AGGREGATE work. Clearly, 
> static linking aggregates the library with the other program in the same 
> binary. There's no question about that. And that _does_ have meaning from 
> a copyright law angle, since if you don't have permission to ship 
> aggregate works under the license, then you can't ship said binary. It's 
> just a non-issue in the specific case of the GPLv2.
> 
> In the presense of dynamic linking the binary isn't even an aggregate 
> work.
> 
> THAT is the difference between static and dynamic. A simple command line 
> flag to the linker shouldn't really reasonably be considered to change 
> "derivation" status.
> 
> Either something is derived, or it's not. If it's derived, "ld", 
> "mkisofs", "putting them close together" or "shipping them on totally 
> separate CD's" doesn't matter. It's still derived.
> 
> 		Linus

