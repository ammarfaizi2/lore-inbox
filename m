Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWDVUL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWDVUL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWDVUL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:11:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18633 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751135AbWDVULz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:11:55 -0400
From: Nick Warne <nick@linicks.net>
To: "Alessandro Suardi" <alessandro.suardi@gmail.com>
Subject: Re: iptables is complaining with bogus unknown error 18446744073709551615
Date: Sat, 22 Apr 2006 12:59:59 +0100
User-Agent: KMail/1.9.1
Cc: "Maurice Volaski" <mvolaski@aecom.yu.edu>,
       "Harald Welte" <laforge@netfilter.org>, linux-kernel@vger.kernel.org
References: <a06230910c06e2510acfa@129.98.90.227> <7c3341450604211126g7e431307q251f9ea49c0ebf91@mail.gmail.com> <5a4c581d0604211705k6fa253at658fe8c321f1bc13@mail.gmail.com>
In-Reply-To: <5a4c581d0604211705k6fa253at658fe8c321f1bc13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604221259.59503.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 April 2006 01:05, Alessandro Suardi wrote:
> On 4/21/06, Nick Warne <nick.warne@gmail.com> wrote:
> > I also ask the same - this 'config' problem/option has been posted on
> > the list previously, I believe.
> >
> > I was about to update my gateway box to 2.6.16.9 this weekend, and I
> > do not build modules on that - so what do I need to do to ensure this
> > xt_tcpudp is built in?
> >
> > Is '> make oldconfig' enough to pull this in?
> >
> > Nick
>
> Hmm, let's see:
>
> [asuardi@donkey src]$ grep tcpudp
> linux-2.6.17-rc1-git4/net/netfilter/Makefile
> obj-$(CONFIG_NETFILTER_XTABLES) += x_tables.o xt_tcpudp.o
>
> OK, I recall configuring this a while ago when still using FC3,
>  as I was bitten too by iptables complaining with the bogus
>  error code which I eventually tracked back to the XTABLES
>  stuff (no - make oldconfig didn't do it for me and I had to go
>  through the config options by hand enabling what I thought
>  was useful). That was since...
>
> [asuardi@donkey src]$ grep -i XTABLES /fc3/usr/src/.config-2.6.1[0-7]*
> /fc3/usr/src/.config-2.6.15-git10:CONFIG_NETFILTER_XTABLES=m
> /fc3/usr/src/.config-2.6.15-git11:CONFIG_NETFILTER_XTABLES=m
> /fc3/usr/src/.config-2.6.16-rc1-git4:CONFIG_NETFILTER_XTABLES=m
> /fc3/usr/src/.config-2.6.16-rc2-git7:CONFIG_NETFILTER_XTABLES=m

OK, to confirm, 'make oldconfig' did indeed pull in the new XTABLES stuff 
without modules.  I presume this will work OK, as my 233MHz box is still 
building (and will be for a few hours yet)...

Nick

-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
