Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265282AbUGGSly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUGGSly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUGGSly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:41:54 -0400
Received: from web41109.mail.yahoo.com ([66.218.93.25]:6491 "HELO
	web41109.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265282AbUGGSlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:41:51 -0400
Message-ID: <20040707184150.76132.qmail@web41109.mail.yahoo.com>
Date: Wed, 7 Jul 2004 11:41:50 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040707163048.GA30840@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Gabriel Paubert <paubert@iram.es> wrote:
> > So I'd say it thinks that all of the constants are "int".  In this
> case
> > 0xFF is greater than 127 [max for char] and 0xFFFFFFFFFFULL is
> larger
> 
> You are aware that this statement is plainly and simply wrong, 
> aren't you?

That goes right up there with, um nope.  The only reason why the
compiler doesn't error about it is because it's not an error.  Doesn't
mean it's right.

> On many platforms a "plain" char is unsigned. You can't write
> portable
> code without knowing this.

Um, actually "char" like "int" and "long" in C99 is signed.  So while
you can write 

signed int x = -3;

You don't have to.  in fact if you "have" to then your compiler is
broken.  Now I know that GCC offers "unsigned chars" but that's an
EXTENSION not part of the actual standard.  

You ought to distinguish "what my compiler does" with "what the
standard actually says".  If you want unsigned chars don't be lazy,
just write "unsigned char".  

As for writing portable code, um, jacka#!, BitKeeper, you know, that
thingy that hosts the Linux kernel?  Yeah it uses LibTomCrypt.  Why not
goto http://libtomcrypt.org and find out who the author is.  Oh yeah,
that would be me.  Why not email Wayne Scott [who has code in
LibTomCrypt btw...] and ask him about it?

Who elses uses LibTomCrypt?  Oh yeah, Sony, Gracenote, IBM [um Joy
Latten can chip in about that], Intel, various schools including
Harvard, Stanford, MIT, BYU, ...

I write code that builds on basically any box with GCC which includes
regular PCs, Macs, Gameboys, PS2, Suns, etc, etc, etc.  All without
changes....

Tom


		
__________________________________
Do you Yahoo!?
Take Yahoo! Mail with you! Get it on your mobile phone.
http://mobile.yahoo.com/maildemo 
