Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSEKOZj>; Sat, 11 May 2002 10:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316224AbSEKOZi>; Sat, 11 May 2002 10:25:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60132 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316223AbSEKOZh>;
	Sat, 11 May 2002 10:25:37 -0400
Date: Sat, 11 May 2002 16:24:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, Lincoln Dale <ltd@cisco.com>,
        Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14  IDE 56)
Message-ID: <20020511142434.GA1224@suse.de>
In-Reply-To: <Pine.LNX.4.44.0205100854370.2230-100000@home.transmeta.com> <200205111418.g4BEIa629620@mail.pronto.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-OS: Linux 2.4.19-pre8 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11 2002, Roy Sigurd Karlsbakk wrote:
> On Friday 10 May 2002 17:55, Linus Torvalds wrote:
> > On Fri, 10 May 2002, Lincoln Dale wrote:
> > > so O_DIRECT in 2.4.18 still shows up as a 55% performance hit versus no
> > > O_DIRECT. anyone have any clues?
> >
> > Yes.
> >
> > O_DIRECT isn't doing any read-ahead.
> >
> > For O_DIRECT to be a win, you need to make it asynchronous.
> 
> Will the use of O_DIRECT affect disk elevatoring?

No, the I/O scheduler can't even tell whether it's being handed
O_DIRECT buffers or not.

Jens
