Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSI3MeK>; Mon, 30 Sep 2002 08:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262041AbSI3MeK>; Mon, 30 Sep 2002 08:34:10 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:63506 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S262040AbSI3MeJ>;
	Mon, 30 Sep 2002 08:34:09 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: NatSemi SCx200 patches for Linux-2.5
References: <87d6qvyb4c.fsf@zoo.weinigel.se>
	<1033388216.16266.1.camel@irongate.swansea.linux.org.uk>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 30 Sep 2002 14:39:33 +0200
In-Reply-To: <1033388216.16266.1.camel@irongate.swansea.linux.org.uk>
Message-ID: <87u1k7wt16.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Mon, 2002-09-30 at 12:23, Christer Weinigel wrote:
> > How can I guarantee that the driver scx200.c is initialized before any
> > other drivers that use the scx200_gpio functions (e.g. scx200_i2c.c)?
> > I have put scx200.c in in arch/i386/kernel in the hope that this
> > directory will always be initialized before anything else, but is this
> > really true?
> 
> There are two ways. For built in code you can use the link order to
> force ordering. In 2.4 thats your only real choice. For modules you need
> to ensure there is a dependancy so modprobe loads the supporting module
> first

I'll just assume that it works then.  With the current link order in
2.5 it works when compiled into the kernel and for the module case
there is an explicit dependency.

Now I just have to merge back a few things to the 2.4 code; I found a
few uglies and want to see if the link order trick works with 2.4.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
