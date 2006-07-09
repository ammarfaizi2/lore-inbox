Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWGIXNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWGIXNo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWGIXNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:13:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932523AbWGIXNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:13:43 -0400
Date: Sun, 9 Jul 2006 16:13:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       Thomas Kleffel <tk@maintech.de>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: pcmcia IDE broken in 2.6.18-rc1
Message-Id: <20060709161330.9fda040d.akpm@osdl.org>
In-Reply-To: <20060709224700.GA1707@elf.ucw.cz>
References: <20060708145541.GA2079@elf.ucw.cz>
	<1152380199.27368.9.camel@localhost.localdomain>
	<20060708104100.af5dcbd8.akpm@osdl.org>
	<20060709224700.GA1707@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 00:47:08 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > > ide2: I/O resource 0xF887E00E-0xF887E00E not free.
> > > > ide2: ports already in use, skipping probe
> > > > ide2: I/O resource 0xF887E01E-0xF887E01E not free.
> > > > ide2: ports already in use, skipping probe
> > > 
> > > 
> > > Looks like ioremap values not I/O ports. Probably the various IDE layer
> > > changes from 2.6.17-mm.
> > > 
> > > My first guess would be the PCMCIA layer changes to use mmio ports are
> > > not setting hwif->mmio (I think its ->mmio) to 2 and doing their own
> > > resource management.
> > > 
> > 
> > 5040cb8b7e61b7a03e8837920b9eb2c839bb1947 looks like a good one to try
> > reverting.
> 
> 2.6.18-rc1-mm1 works okay. Is that enough, or do you want me to try
> reverting just this patch?

Nope, that's fine, thanks.  I think we can say that
5040cb8b7e61b7a03e8837920b9eb2c839bb1947 is busted.

Let's give Thomas and Dominik a few days to think about it before we do the
deed..
