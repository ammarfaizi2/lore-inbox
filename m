Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTELMWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTELMWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:22:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20637 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262073AbTELMWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:22:24 -0400
Date: Mon, 12 May 2003 14:34:19 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jeremy Jackson <jerj@coplanar.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Switch ide parameters to new-style and make them unique.
In-Reply-To: <20030512063812.EEDAF2C0F5@lists.samba.org>
Message-ID: <Pine.SOL.4.30.0305121423540.7978-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 May 2003, Rusty Russell wrote:

> In message <003f01c31828$c8e9f480$7c07a8c0@kennet.coplanar.net> you write:
> > Cool stuff.
> >
> > As far as making the parameters easy to parse, I think you would want to
> > have a single static tag before the = (equal) sign.  The kernel command line
> > parsing stuff provides parsing up to that point and dispatches to each
> > subsystem (or at least it used to), so:
> >
> > ata.dev_noprobe=hda
> >
> > should be
> >
> > ata=dev_noprobe:hda,if_io_irq:0,0x1f0,7
> >
> > or some such to use the generic code that's already there.

Already there? :-)
Generic code to do this would be nice.

> Sure, some more complex generic parsing thing certainly makes sense.
> I think whoever produces the code will probably get to decide what it
> looks like.

For the beginning generic helper which grabs table of strings
(driver params) and pointers to parsing functions ('char *s' arg,
'int' return) would be useful for many drivers...

--
Bartlomiej

> Cheers!
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

