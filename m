Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWEQBrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWEQBrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWEQBrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:47:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18838 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932421AbWEQBrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:47:21 -0400
Date: Tue, 16 May 2006 18:40:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
Message-Id: <20060516184042.2e292ad9.akpm@osdl.org>
In-Reply-To: <1147829611.3051.5.camel@laptopd505.fenrus.org>
References: <20060516174413.GI10077@stusta.de>
	<20060516122731.6ecbdeeb.akpm@osdl.org>
	<1147829611.3051.5.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Tue, 2006-05-16 at 12:27 -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > - remove the following unused EXPORT_SYMBOL's:
> > >   - journal_set_features
> > >   - journal_update_superblock
> > 
> > These might be used by lustre - dunno.
> > 
> > But I'm ducking all patches which alter exports, as usual.  If you can get
> > them through the subsystem maintainer then good luck.
> > 
> > I'd suggest that we pursue the approach of getting the module loader to
> > spit a warning when someone uses a going-away-soon export.
> > 
> > Arjan had a patch which did that, but he removed basically _every_
> > presently-unused export.  
> 
> NOT IN THE SAME PATCH!

I noticed.

> I made the infrastructure a very nicely separate patch.... and I thought
> I explained that to you as well ;(

You did.  I was referring to the EXPORT_SYMBOL patches.

I don't think we should take the scattergun approach here.  Get the
infrastructure merged, then methodically work the EXPORT_SYMBOL patches
with the various maintainers.

