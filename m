Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbSIWSlO>; Mon, 23 Sep 2002 14:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbSIWSlO>; Mon, 23 Sep 2002 14:41:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52962 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261284AbSIWSlN>; Mon, 23 Sep 2002 14:41:13 -0400
Date: Mon, 23 Sep 2002 13:54:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20pre7, aic7xxx-6.2.8: Panic: HOST_MSG_LOOP with invalid
 SCB 0
In-Reply-To: <2492970816.1032802501@aslan.btc.adaptec.com>
Message-ID: <Pine.LNX.4.44.0209231350390.973-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Sep 2002, Justin T. Gibbs wrote:

> > Justin,
> >
> > I guess is the second or third report of problems with the new aic7xxx :(
>
> This issue has already been resolved as a chipset issue requiring
> I/O mapped register access to work around.  The "old" aic7xxx driver
> avoids these issues by issuing a register read after every register
> write.  This stops up your PCI bus with wasted cycles even if you have
> a perfectly working chipset.
>
> So, how would you like me to resolve this.  We can do the same thing
> as Adaptec's windows drivers and just always use the slower, less
> efficient I/O mapped method for accessing registers.  This will "fix"
> the problems people have with broken VIA and Intel chipsets.  I can
> make this a compile and run-time option, but should we default to
> I/O mapped or memory mapped?
>
> Don't you just love broken PC hardware?

Its all fine, then: I thought the problems were caused by some bug in the
driver itself.

Thanks for explaining me the issue clearly. :)

