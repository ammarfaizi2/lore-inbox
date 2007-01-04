Return-Path: <linux-kernel-owner+w=401wt.eu-S932311AbXADHp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbXADHp4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 02:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbXADHp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 02:45:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:34226 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311AbXADHpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 02:45:55 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 4 Jan 2007 02:40:38 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Simplify some code to use the container_of() macro.
In-Reply-To: <20070103165034.13935d8a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701040240230.29472@localhost.localdomain>
References: <Pine.LNX.4.64.0612311547200.30821@localhost.localdomain>
 <20070103165034.13935d8a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007, Andrew Morton wrote:

> On Sun, 31 Dec 2006 15:55:22 -0500 (EST)
> "Robert P. J. Day" <rpjday@mindspring.com> wrote:
>
> > --- a/net/ipv4/netfilter/nf_nat_core.c
> > +++ b/net/ipv4/netfilter/nf_nat_core.c
> > @@ -168,7 +168,7 @@ find_appropriate_src(const struct nf_conntrack_tuple *tuple,
> >
> >  	read_lock_bh(&nf_nat_lock);
> >  	list_for_each_entry(nat, &bysource[h], info.bysource) {
> > -		ct = (struct nf_conn *)((char *)nat - offsetof(struct nf_conn, data));
> > +		ct = container_of(nat, struct nf_conn, data);
>
> This one isn't right.  Please always carefully compile-test these things.

i was quite sure i had.  i'll take another look at it.

rday
