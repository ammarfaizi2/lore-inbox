Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291517AbSBAD6W>; Thu, 31 Jan 2002 22:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291519AbSBAD6D>; Thu, 31 Jan 2002 22:58:03 -0500
Received: from 1-099.ctame701-2.telepar.net.br ([200.181.138.99]:38908 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S291517AbSBAD5y>; Thu, 31 Jan 2002 22:57:54 -0500
Date: Thu, 31 Jan 2002 21:21:20 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davem@redhat.com (David S. Miller), vandrove@vc.cvut.cz,
        torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020131232119.GN10772@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	davem@redhat.com (David S. Miller), vandrove@vc.cvut.cz,
	torvalds@transmeta.com, garzik@havoc.gtf.org,
	linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
	ralf@gnu.org
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16WQYs-0003Ux-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 31, 2002 at 11:24:10PM +0000, Alan Cox escreveu:
> > As a side note, this thing is so tiny (less than 4K on sparc64!) so
> > why don't we just include it unconditionally instead of having all
> > of this "turn it on for these drivers" stuff?
> 
> Because 100 4K drivers suddenly becomes 0.5Mb. There are those of us trying
> to stuff Linux into embedded devices who if anything want more configuration
> options not people taking stuff out.
> 
> What I'd much rather see if this is an issue is:
> 
> bool	'Do you want to customise for a very small system' 
> 
> which auto enables all the random small stuff if you say no, and goes
> much deeper into options if you say yes.

heh, after I've read that you managed to boot 2.4 + rmap in a machine with
just 4 MB after tweaking some table sizes I thought about devoting some
time to identify those tables and making them options in make *config, with
even a nice CONFIG_TINY, like you said 8)

I'll eventually do this, and I'd appreciate if people send me suggestions
of tables/data structures that can be trimmed/reduced. Yeah, I'll take a
look at the .config files used in the embedded distros.

- Arnaldo
