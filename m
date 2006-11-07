Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752437AbWKGAqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWKGAqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbWKGAqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:46:04 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:19615 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S1752437AbWKGAqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:46:02 -0500
Date: Mon, 6 Nov 2006 22:45:53 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       acme@conectiva.com.br
Subject: Re: + net-uninline-skb_put.patch added to -mm tree
Message-ID: <20061107004552.GA3768@mandriva.com>
References: <200611032218.kA3MITih003548@shell0.pdx.osdl.net> <20061106.144233.23011532.davem@davemloft.net> <20061106145757.8f59caa8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061106145757.8f59caa8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 02:57:57PM -0800, Andrew Morton wrote:
> On Mon, 06 Nov 2006 14:42:33 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: akpm@osdl.org
> > Date: Fri, 03 Nov 2006 14:18:29 -0800
> > 
> > > Subject: net: uninline skb_put()
> > > From: Andrew Morton <akpm@osdl.org>
> > > 
> > > It has 34 callsites for a total of 2650 bytes.
> > > 
> > > Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> > > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > 
> > A more accurate figure would probably be:
> > 
> > davem@sunset:~/src/GIT/net-2.6$ git grep skb_put | grep -v __skb_put | wc -l
> > 1167
> > 
> > :-)
> 
> True.  I'm not sure what .config Arnaldo was using..

The first one, for the top50 was a normal config for a qemu machine, not
sure right now if there was debugging, it may well be the case, the
second one, for a top100, as said in the message was with 'make
allyesconfig', as I was testing how scalable was the thing in the
current state, and as David Woodhouse and Adrian Bunk said it is
unrealistic, best thing is to built it with the config distros ship +
debug info, which I'll do in the next few days.

- Arnaldo
