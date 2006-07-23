Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWGWLUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWGWLUK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 07:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWGWLUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 07:20:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:779 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751185AbWGWLUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 07:20:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=F+puThx78+gdBN7r7PGz94yFf0OSSM/pFJbRH/069dadMV91CXqhkr/ceIQRyky/mp3ZbkpXQ4BT954vO9XN2edBKSlz6smhW/+0pWLpJHZqGVHTueLlZD0nBwlnCx11lWFc3YGRwqdhCYCMVIJNtsdfS/aPmGkUsfid/hOP7IQ=
Date: Sun, 23 Jul 2006 15:20:05 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Tomasz =?utf-8?Q?K=C5=82oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Message-ID: <20060723112005.GA6815@martell.zuzino.mipt.ru>
References: <44C099D2.5030300@s5r6.in-berlin.de> <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com> <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI> <44C0B29F.2080604@s5r6.in-berlin.de> <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl> <44C26D90.4030307@s5r6.in-berlin.de> <Pine.BSO.4.63.0607222030370.10018@rudy.mif.pg.gda.pl> <44C28472.2080509@pobox.com> <Pine.BSO.4.63.0607222242100.10018@rudy.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.BSO.4.63.0607222242100.10018@rudy.mif.pg.gda.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC list trimmed]

On Sat, Jul 22, 2006 at 10:55:55PM +0200, Tomasz Kłoczko wrote:
> On Sat, 22 Jul 2006, Jeff Garzik wrote:
> >Tomasz Kłoczko wrote:
> >>Moment .. are you want to say something like "keep commont coding style
> >>can't be maintained by tool" ?
> >>Even if indent watches on to small coding style emenets still I don't see
> >>why using this tool isn't one of the current ement of release procedure
> >>(?).
> >
> >indent isn't perfect, _especially_ where C99 comes into the picture.
>
> Again: is in this case "isn't perfect" mean "it does not make all what we
> want" ? If yes still I don't see why not use indent + some other tool or
> if you will show real example where it does something badady (like now
> for checking code syntax is used compiler and some other tools like
> sparse).
>
> >And running indent across the tree pre-release would (a) create a ton of
> >noise before each release, and (b) undo perfectly valid, readable
> >formatting.
>
> Committing all this "noise" will plug all this thing and allow reve most
> of content Documentation/CodingStyle document.
> Is it not wort stop all questions/discuss/flames on this subject ?

Yes, it's better to stop this thread. Because you haven't done your
homework and advocating procedure which will create massive spurious changes
every time it's applied.

If you have math background:

	Lindent \cdot Lindent \neq Lindent

pretty often. If you don't, see below.

> Again: using indent mainly will mean only one time massive changes.

True, 180M(!) of them.

> After
> this ident can be runed for example by Linus just before make release
> and/or partial release.

~4M per run.

> >scripts/Lindent exists and gets used, but it is not perfect.

Correction: GNU indent exists and gets used, but it is not perfect.

Last time I checked BSD indent don't have some option Lindent use.
forgot which.

> Again: anywhere are listed/was posted list of "not perfect" examples ?

OOhhhh, please do

	find . -type f -name '*.[ch]' | xargs ./scripts/Lindent

on any large C codebase.

> And/or: what does it mean in this case "not perfect" ?

> Show this  for
> allow start work on fix indent by other people (if all cases will be resul
> of some bugs in this tool).

Start fixing indent(1) if you're serious about all this. There are
_plenty_ of C code flying around.

