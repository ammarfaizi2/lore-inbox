Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSFVVYV>; Sat, 22 Jun 2002 17:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSFVVYU>; Sat, 22 Jun 2002 17:24:20 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:57067 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316903AbSFVVYT>; Sat, 22 Jun 2002 17:24:19 -0400
Date: Sat, 22 Jun 2002 16:24:13 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Riley Williams <rhw@InfraDead.Org>
cc: Henning Makholm <henning@makholm.net>,
        "Adam J. Richter" <adam@yggdrasil.com>, <bug-make@gnu.org>,
        Linux Ham Radio <linux-hams@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, <sailer@ife.ee.ethz.ch>
Subject: Re: make-3.79.1 bug breaks linux-2.5.24/drivers/net/hamradio/soundmodem
In-Reply-To: <Pine.LNX.4.21.0206222052540.15173-100000@Consulate.UFP.CX>
Message-ID: <Pine.LNX.4.44.0206221611430.7338-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002, Riley Williams wrote:

> >> $(obj)/sm_tbl_%: $(obj)/gentbl
> >>         PATH=$(obj):$$PATH $<
> 
> > That looks like an excessively complicated workaround. Why not just
> >
> > $(obj)/sm_tbl_%: $(obj)/gentbl
> > 	$(obj)/gentbl
> >
> > instead ?

I think I like the latter better as well. Anyway, $(obj) is just "."
currently, so it doesn't have a space in it. For $(src), I'll always use
relative paths, so there won't be any spaces in them either. I think it's
a sensible restriction for separate src/obj trees to disallow spaces in
the obj tree path, I fear it'd cause problems at a huge number of places.
At least it's certainly acceptable to do "no space" first and then see
what needs to be done in order to remove that restriction.

(I also think the two are functionally equivalent even if $(obj) contains 
a space, but I haven't tried at all)

--Kai


