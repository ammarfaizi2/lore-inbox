Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310431AbSCGRce>; Thu, 7 Mar 2002 12:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310430AbSCGRc0>; Thu, 7 Mar 2002 12:32:26 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:34564 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S310425AbSCGRcJ>;
	Thu, 7 Mar 2002 12:32:09 -0500
Date: Thu, 7 Mar 2002 18:31:49 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: FPU precision & signal handlers (bug?)
In-Reply-To: <E16iOx5-0004oK-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203071820450.17751-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 6 Mar 2002, Alan Cox wrote:

> > > Think about MMX and hopefully it makes sense then.
> >
> > AFAIR MMX only mucks with tag and status words (and the exponent fields of
> > the stack elements), but never depends on or modifies the control word.
>
> Right but you don't want to end up in MMX mode by suprise in a
> signal handler in library code. By the same argument you don't want to end
> up in a weird maths more.

I agree with the second part, but actually what you want is to start with
an empty stack. Whether the contents are FP or MMX is irrelevant.
Actually the support of applications using MMX did not require any change
to the kernel (Intel carefully designed it that way).

> I don't think its a bug. I think its correct (but seriously underdocumented)
> behaviour

Indeed.

	Gabriel.

