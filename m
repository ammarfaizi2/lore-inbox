Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSKTSsE>; Wed, 20 Nov 2002 13:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSKTSsD>; Wed, 20 Nov 2002 13:48:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:49413
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262089AbSKTSr7>; Wed, 20 Nov 2002 13:47:59 -0500
Date: Wed, 20 Nov 2002 10:54:30 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Xavier Bestel <xavier.bestel@free.fr>, Mark Mielke <mark@mark.mielke.cc>,
       Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <1037801955.3241.21.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10211201040330.3892-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 2002, Alan Cox wrote:

> On Wed, 2002-11-20 at 10:17, Xavier Bestel wrote:
> > Yeah, that's precisely the problem here: the binary-only module is
> > distributed with included spinlock code, which *is* GPL.
> 
> That doesnt neccessarily make it a derived work. Suppose I publish a
> book including a lawyer who says "Your honour I ...". That doesn't make
> it a derivative of some previous work I read that used the same phrase.
> 
> Equally if I paraphase the entire court scene but use no identical words
> it may be a derived work. 
> 
> Stop thinking about this as a mathematical question. It isnt about the
> union of sets of instructions.
> 
> Alan

This can be made clean if all the inlined C in the headers are pushed
back to an actual .c file and the make it function to call as an extern.
So the solution is to make a patch and publish that patch which cleans the
out the C code in question and move the associacted GPL license to the new
.c files.  This is proper and legal as structs are just the glue or api.

So if I publish this patch where it can be freely available for usage by
all, I comply with GPL.  This also removes any of the "extremists" points
of the smallest amount of GPL code invoked by the compiler can not touch
pure code.

Any arguments why this will not work?



Andre Hedrick
LAD Storage Consulting Group

