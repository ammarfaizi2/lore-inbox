Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265313AbUGGSyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265313AbUGGSyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUGGSyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:54:10 -0400
Received: from web41112.mail.yahoo.com ([66.218.93.28]:45575 "HELO
	web41112.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265313AbUGGSxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:53:47 -0400
Message-ID: <20040707185340.42091.qmail@web41112.mail.yahoo.com>
Date: Wed, 7 Jul 2004 11:53:40 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
To: Christoph Hellwig <hch@infradead.org>
Cc: Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org
In-Reply-To: <20040707184737.GA25357@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Jul 07, 2004 at 11:41:50AM -0700, tom st denis wrote:
> > Um, actually "char" like "int" and "long" in C99 is signed.  So
> while
> > you can write 
> > 
> > signed int x = -3;
> > 
> > You don't have to.  in fact if you "have" to then your compiler is
> > broken.  Now I know that GCC offers "unsigned chars" but that's an
> > EXTENSION not part of the actual standard.  
> 
> ------------------------------ snip -----------------------------
>  [#15]  The  three types char, signed char, and unsigned char
>         are   collectively   called   the   character   types.   The
>         implementation  shall  define  char  to have the same range,
> 	representation,  and  behavior  as  either  signed  char or
> 	unsigned char.35)
> ------------------------------ snip -----------------------------

Right.  Didn't know that.  Whoa.  So in essence "char" is not a safe
type.

> > As for writing portable code, um, jacka#!, BitKeeper, you know,
> that
> > thingy that hosts the Linux kernel?  Yeah it uses LibTomCrypt.  Why
> not
> > goto http://libtomcrypt.org and find out who the author is.  Oh
> yeah,
> > that would be me.  Why not email Wayne Scott [who has code in
> > LibTomCrypt btw...] and ask him about it?
> > 
> > Who elses uses LibTomCrypt?  Oh yeah, Sony, Gracenote, IBM [um Joy
> > Latten can chip in about that], Intel, various schools including
> > Harvard, Stanford, MIT, BYU, ...
> 
> Tons of people use windows aswell.  You just showed that you don't
> know
> C well enough, so maybe someone should better do an audit for your
> code ;-)

To be honest I didn't know that above.  That's why I'm always explicit.
 [btw my code builds in MSVC, BCC and ICC as well].

You don't need to know such details to be able to develop in C.  I'm
sure if you walked into [say] Redhat and gave an "on the spot C quiz"
about obscure rules they would fail.  You have to use some common sense
and apply the more relevant rules.  

Point is 0xDEADBEEFUL is just as simple to type and avoids any sort of
ambiguitity.  It means unsigned long.  No question about it.  No having
to refer to subsection 12 of paragraph 15 of section 23 of chapter 9 to
figure that out.

Why people are fighting over this is beyond me.  Fine, write it as
0xDEADBEEF see what the hell I care.  Honestly.  Open debate or what?  

And I don't need mr. Viro coming down off his mountain saying "oh you
fail it" because I don't know some obscure typing rule that I wouldn't
come accross because *** I AM NOT LAZY ***.  Hey mr. Viro what have you
contributed to the public domain lately?  Anything I can harp on in
public and abuse?  

Asshat.

Tom


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
