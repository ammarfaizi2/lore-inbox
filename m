Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSJEXWi>; Sat, 5 Oct 2002 19:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbSJEXWf>; Sat, 5 Oct 2002 19:22:35 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:30990 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262808AbSJEXWe>; Sat, 5 Oct 2002 19:22:34 -0400
Date: Sat, 5 Oct 2002 20:28:06 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Gigi Duru <giduru@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021005232806.GG8530@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Oliver Xymoron <oxymoron@waste.org>, Gigi Duru <giduru@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20021005193650.17795.qmail@web13202.mail.yahoo.com> <20021005222306.GB9145@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021005222306.GB9145@waste.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 05, 2002 at 05:23:06PM -0500, Oliver Xymoron escreveu:
> On Sat, Oct 05, 2002 at 12:36:50PM -0700, Gigi Duru wrote:

> > I know you guys are struggling to bring "world class VM & IO" to Linux,
> > going for SMPs and other big toys, but you are about to lose what you
> > already have: the embedded market.
 
> It's still plenty small enough for many many embedded uses and most people
> are more than happy with it. The reason that it's not even smaller is no one
> has stepped forward to do the trimming. It's easy enough to do, but we can
> only assume from the fact that no one's done so is that it's really not that
> important.
 
> If you think it's important, either make it happen or pay someone else to
> make it happen. 

I've been thinking about working on a CONFIG_TINY for ages and would love to
have somebody else beat me to do this, as currently I'm too busy saving old
network protocols and with a backlog of patches for general network
infrastructure (clean up include/linux/skbuff.h so that it doesn't have any
reference to specific protocols, in the same way that I did for
include/net/sock.h) and macroising access to stats in tcp/ip so that we can
be preempt friendly.

I have also __initstr patches to free more memory after boot by moving the
strings in __init functions to .data.init section that will help with
embedded stuff as well. Some of the strings are passed to things like
register_chrdev and would require changes in those register functions to
copy the string passed as it will be freed after boot, etc.

- Arnaldo
