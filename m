Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSEaNeH>; Fri, 31 May 2002 09:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSEaNeF>; Fri, 31 May 2002 09:34:05 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:42463 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S315282AbSEaNd7>; Fri, 31 May 2002 09:33:59 -0400
Date: Fri, 31 May 2002 15:33:51 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: do_mmap
In-Reply-To: <1022855243.12888.410.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.05.10205311527390.10681-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan,

> On Fri, 2002-05-31 at 14:00, Thomas 'Dent' Mirlacher wrote:
> > and the checks in various places are really strange. - well some
> > places check for:
> > 	o != NULL
> > 	o > -1024UL
> 
> "Not an error". Its relying as some other bits of code do actually that
> the top mappable user address is never in the top 1K of the address
> space

ok, that explain the -1024UL

> > is it possible to have 0 as a valid address? - if not, this should
> > be the return on errors.
> 
> SuS explicitly says that 0 is not a valid mmap return address.

ok.

so it seems the code itself is correct. it's just a little bit odd
to read over the code, returning an unsigned int, and then find
no comments on this "not so common usage" ;)

nevertheless, functions which just check for != NULL for the return
type needs fixing. - plus s hort comment containing your explaination
above could help other people ...

	tm

-- 
in some way i do, and in some way i don't.

