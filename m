Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSKKCfu>; Sun, 10 Nov 2002 21:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSKKCfu>; Sun, 10 Nov 2002 21:35:50 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:46864 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265369AbSKKCfu>; Sun, 10 Nov 2002 21:35:50 -0500
Date: Mon, 11 Nov 2002 00:42:27 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46-bk3: BUG in skbuff.c:178
Message-ID: <20021111024227.GB20583@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <6F45EB551A2@vcnet.vc.cvut.cz> <20021108220215.GA2437@vana> <20021110041855.GA17760@conectiva.com.br> <20021111022602.GA1498@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111022602.GA1498@ppc.vc.cvut.cz>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 11, 2002 at 03:26:02AM +0100, Petr Vandrovec escreveu:
> On Sun, Nov 10, 2002 at 02:18:55AM -0200, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Nov 08, 2002 at 11:02:15PM +0100, Petr Vandrovec escreveu:
> > > On Fri, Nov 08, 2002 at 09:33:24PM +0200, Petr Vandrovec wrote:
> > > > On  8 Nov 02 at 12:01, Andrew Morton wrote:
> >  
> > > Patch below removes 'bucket' from arp_iter_state, and merges it to the pos.
> > > It is based on assumption that there is no more than 16M of entries in each
> > > bucket, and that NEIGH_HASHMASK + 1 + PNEIGH_HASHMASK + 1 < 127
> > 
> > I did that in the past, but it gets too ugly, see previous changeset in
> > bk tree, lemme see... 1.781.1.52, but anyway, I was aware of this bug but I
> > was on the run, going to Japan and back in 5 days :-\ Well, I have already
> > sent this one to several people, so if you could review/test it...
> 
> I tried to find how it is supposed to work, and after I tried to boot kernel
> (at home) with it, I can say that it does not work...

I'm working on this now... :-\
