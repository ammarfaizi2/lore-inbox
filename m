Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262752AbSJGWvl>; Mon, 7 Oct 2002 18:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263168AbSJGWvk>; Mon, 7 Oct 2002 18:51:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4033 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262752AbSJGWuy>; Mon, 7 Oct 2002 18:50:54 -0400
Date: Mon, 7 Oct 2002 19:56:21 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christer Weinigel <christer@weinigel.se>, simon@baydel.com,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
Message-ID: <20021007225621.GG3485@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christer Weinigel <christer@weinigel.se>, simon@baydel.com,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DA16A9B.7624.4B0397@localhost> <3DA1CF36.19659.13D4209@localhost> <1034022158.26550.28.camel@irongate.swansea.linux.org.uk> <87smzhzy6l.fsf@zoo.weinigel.se> <1034031138.26473.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034031138.26473.40.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 07, 2002 at 11:52:18PM +0100, Alan Cox escreveu:
> On Mon, 2002-10-07 at 23:22, Christer Weinigel wrote:
> > #define printk_debug(xxx...) printk(KERN_DEBUG, xxx...)
> > #define printk_info(xxx...) printk(KERN_INFO, xx...)
> > #else
> > #define printk_debug(xxx...) do { } while (0)
> > #define printk_info(xxx...) do { } while (0)
> 
> That might make a lot of sense. The macros in question would need a bit
> of hand checking for side effects in calls but yes this is the kind of
> thing that can be good

Humm, dprintk is perhaps the most widely used of this kind of stuff,
i.e. debug only printks that should be disabled when in production,
standardising on what is common practice and adding a iprintk could be
something we should consider.

- Arnaldo
