Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756982AbWLCQoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982AbWLCQoA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757092AbWLCQoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:44:00 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:7340 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1756982AbWLCQn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:43:59 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 11:40:07 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: Convert kmalloc()+memset() combo to kzalloc().
In-Reply-To: <20061203164109.4c260592@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612031139570.4559@localhost.localdomain>
References: <Pine.LNX.4.64.0612031120110.4371@localhost.localdomain>
 <20061203164109.4c260592@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006, Alan wrote:

> >  	if (!p) {
> > -		p = kmalloc(sizeof(*p), GFP_KERNEL);
> > +		p = kzalloc(sizeof(*p), GFP_KERNEL);
> >  		if (!p)
> >  			return -ENOMEM;
> >  		file->private_data = p;
> >  	}
> > -	memset(p, 0, sizeof(*p));
> >  	mutex_init(&p->lock);
> >  	p->op = op;
>
>
> NAK
>
> If p was already set (ie private data existed) the old code zeroed it,
> your code does not, but only zeroes the new stuff.

whoops, sorry, my bad.

rday
