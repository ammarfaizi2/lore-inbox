Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSFICn4>; Sat, 8 Jun 2002 22:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSFICnz>; Sat, 8 Jun 2002 22:43:55 -0400
Received: from mail.gmx.de ([213.165.64.20]:38360 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317536AbSFICny>;
	Sat, 8 Jun 2002 22:43:54 -0400
Date: Sun, 9 Jun 2002 05:42:20 +0300
From: Dan Aloni <da-x@gmx.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Brian Gerst <bgerst@didntduck.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More list_del_init cleanups
Message-ID: <20020609024220.GA9581@callisto.yi.org>
In-Reply-To: <20020608024030.GA18037@callisto.yi.org> <Pine.LNX.4.44.0206081628390.11630-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2002 at 04:30:22PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 8 Jun 2002, Dan Aloni wrote:
> >
> > If we are at it, how about replacing:
> >
> > 	list_del(&entry->list);
> > 	list_add(&entry->list, dispose);
> >
> > with something like:
> >
> > 	list_del_add(&entry->list, dispose);
> 
> Ehh.. Am I the only one who thinks "move()" would make more sense than
> "del_add()"?

I was going to suggest list_move(), but then I thought about being 
consistent with the func1_func2 convention as in list_del_init().

-- 
Dan Aloni
da-x@gmx.net
