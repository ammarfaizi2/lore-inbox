Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSE0Prd>; Mon, 27 May 2002 11:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSE0Prc>; Mon, 27 May 2002 11:47:32 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:18310 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316664AbSE0Pr3>; Mon, 27 May 2002 11:47:29 -0400
Date: Mon, 27 May 2002 10:47:23 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: David Woodhouse <dwmw2@infradead.org>
cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][RFC] gcc3 arch options 
In-Reply-To: <27362.1022512680@redhat.com>
Message-ID: <Pine.LNX.4.44.0205271030240.24699-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002, David Woodhouse wrote:

> jamagallon@able.es said:
> > +CFLAGS += $(shell if $(CC) -march=pentium-mmx -S -o /dev/null -xc /
> > dev/null >/dev/null 2>&1; then echo "-march=pentium-mmx"; else echo
> > "-march=i586"; fi)
> 
> Doesn't this run the shell command every time $(CFLAGS) is used?

CFLAGS is initially defined with ':=', which, as opposed to '=' means to 
evaluate directly and store the resulting string, so it should be fine. 

Even if it wasn't, only the evaluations from the top-level Makefile would
cause the command to be executed, make will always pass down the evaluated 
result to the subdir makes.

--Kai



