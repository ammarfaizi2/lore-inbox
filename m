Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVBGRxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVBGRxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVBGRxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:53:48 -0500
Received: from mail.njit.edu ([128.235.251.32]:16065 "EHLO mail-gw4.njit.edu")
	by vger.kernel.org with ESMTP id S261207AbVBGRxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:53:35 -0500
Date: Mon, 7 Feb 2005 12:53:23 -0500 (EST)
From: Rahul Jain <rbj2@oak.njit.edu>
To: Kronos <kronos@kronoz.cjb.net>
cc: Kernel Traffic Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to add source files in kernel
In-Reply-To: <20050204202628.GA14973@dreamland.darkstar.lan>
Message-ID: <Pine.GSO.4.58.0502071249580.6273@chrome.njit.edu>
References: <20050204202628.GA14973@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Feb 2005, Kronos wrote:

>
>
>
> Rahul Jain <rbj2@oak.njit.edu> ha scritto:
> > The kernel recompilation went without any problems. I wrote loadable
> > module programs that can access the functions defined in .c. When I try to
> > install these modules, they came back with the following error
> >
> > /sbin/insmod x.o
> > x.o: unresolved symbol enqueue_sfi
> > x.o: unresolved symbol init_skbuff_list
> > x.o: unresolved symbol get_head_sfi
> > x.o: unresolved symbol search_sfi
> > x.o: unresolved symbol enqueue_skbuff_list
> > x.o: unresolved symbol init_head_sfi
> > x.o:
> > Hint: You are trying to load a module without a GPL compatible license
> >      and it has unresolved symbols.  Contact the module supplier for
> >      assistance, only they can help you.
> >
> > make: *** [install] Error 1
>
> You forgot the EXPORT for those symbols, add:
>
> EXPORT_SYMBOL(symbol_name);
>
> to .c file. Or you may have exported the symbols as GPL only
> (EXPORT_SYMBOL_GPL) and the module which is not licensed under GPL
> cannot see them.
>
> Luca
> --
> Home: http://kronoz.cjb.net
> La somma dell'intelligenza sulla terra e` una costante.
> La popolazione e` in aumento.
>
I added EXPORT_SYMBOL(fn_name) for all the functions that I wanted to
access from my module. I also added MODULE_LICENSE("GPL") to the .c file.
And in the Makefile I added my_file.o to 'export_objs'. However I am still getting
the same error.

Any suggestions ? Are there any resources online which I can read.

Thanks,
Rahul.
