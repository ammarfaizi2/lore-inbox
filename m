Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVEPPoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVEPPoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVEPPn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:43:26 -0400
Received: from pop.gmx.net ([213.165.64.20]:53459 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261725AbVEPPkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:40:35 -0400
X-Authenticated: #428038
Date: Mon, 16 May 2005 17:40:20 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
Message-ID: <20050516154020.GD949@merlin.emma.line.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116256005.21388.55.camel@localhost.localdomain>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Alan Cox wrote:

> I'd prefer Linux turned writecache off on old drives but Mark Lord has
> really good points even there. And for scsi we do tagging and the
> journals can be ordered depending on your need.

Is tagged command queueing (we'll need the ordered tag here) compatible
with all SCSI adaptors that Linux supports?

What if tagged command queueing is switched off for some reason
(adaptor or HW incapability, user override) and the drive still has
write cache enable = true and queue algorithm modifier = 1 (which
permits out-of-order execution of write requests except for ordered
tags)? Is that something that would cause some bit of notice to be
logged? Or is that simply "do this at your own risk". My recent SCSI
drives have been shipping with WCE=1 and QAM=0.

Am I missing a bit here?

> You also appear confused: It isn't the maintainers responsibility to
> arrange for such info. It's the maintainers responsibility to process
> contributed patches with such info.

I didn't think of arranging as in "write himself". Who writes that info
down doesn't matter, but I'd think that such documentation should always
be committed alongside the code, except in code marked experimental.
(which, in turn, should only be promoted to non-experimental if it's
properly documented).

I understand that people who understand the code are eager to focus on
the code and even if that documentation is just an unordered lists of
statement with a kernel version attached, that'd be fine. But what is a
decent code without users?

-- 
Matthias Andree
