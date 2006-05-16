Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWEPTvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWEPTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWEPTvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:51:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5533 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbWEPTvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:51:24 -0400
Date: Tue, 16 May 2006 12:50:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
Message-Id: <20060516125053.03dc1d8f.akpm@osdl.org>
In-Reply-To: <20060516193956.GS10077@stusta.de>
References: <20060516174413.GI10077@stusta.de>
	<20060516122731.6ecbdeeb.akpm@osdl.org>
	<20060516193956.GS10077@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Tue, May 16, 2006 at 12:27:31PM -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > - remove the following unused EXPORT_SYMBOL's:
> > >   - journal_set_features
> > >   - journal_update_superblock
> > 
> > These might be used by lustre - dunno.
> 
> I don't see this.

Lustre doesn't use these?

Still, the jbd API is exported for other filesystems to use.  If these
functions are considered part of that API (they are) then I'd suggest that
they should be exported.

> > But I'm ducking all patches which alter exports, as usual.  If you can get
> > them through the subsystem maintainer then good luck.
> >...
> 
> Since you replied to this patch:
> Who is the subsystem maintainer for jbd?

A few people, including me..
