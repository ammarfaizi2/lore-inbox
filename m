Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269334AbRGaP6v>; Tue, 31 Jul 2001 11:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269331AbRGaP6m>; Tue, 31 Jul 2001 11:58:42 -0400
Received: from dnscache.cbr.au.asiaonline.net ([210.215.8.100]:55682 "EHLO
	dnscache.cbr.au.asiaonline.net") by vger.kernel.org with ESMTP
	id <S269335AbRGaP6e>; Tue, 31 Jul 2001 11:58:34 -0400
Message-ID: <3B66D580.5217B48B@acm.org>
Date: Wed, 01 Aug 2001 01:57:52 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 -- GCC-3.0 -- "multiline string literals deprecated" -- PATCH
In-Reply-To: <200107311415.f6VEF9oD028247@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Horst von Brand wrote:
> 
> AFAIU, they are non-standard, and can easily hide bugs (in opening a string
> and forgetting to close you are in escence commenting out lines of code)

Zack Weinberg, who's post started the thread, gave three main criteria
for their removal in
http://gcc.gnu.org/ml/gcc-patches/2001-07/msg00327.html, including:

<quote>
There is only one argument in my mind for keeping them:

  - It makes it easier to write lengthy chunks of inline assembly.

This is certainly true, however, writing a lengthy chunk of inline
assembly is almost always a mistake; it interferes with the compiler's
ability to do its job.  Therefore I do not think there is any
compelling need to make that easy.
</quote>

If I ever write inline assembly, then it's for a very good reason.  I'd
hesitate to call almost all uses of inline assembly a "mistake",
particlarly in places like the kernel, or math-intensive ones like 3D
graphics.

> Right. If you use a compiler, you shouldn't need it much. Better make
> other, more important, things easy/more foolproof, even at some cost for
> the asm() writer. (Hint: Count the lines of asm in the kernel (an
> _extremely_ heavy asm user!) vs the lines of plain C)

No argument re: lines of code.  However, if I have to write a decent
chunk of inline assembly, multiline strings are much nicer IMHO.

> Yep, this is a braindead argument. There must have been others (sensible
> ones)...

See above ;-)

> I hope they disallow multiline strings pretty soon.

I don't have strong feelings either way.  And I sure don't want to have
this argument again...

-- Gareth
