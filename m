Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263781AbUFKKXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUFKKXm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 06:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUFKKXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 06:23:42 -0400
Received: from gprs214-150.eurotel.cz ([160.218.214.150]:54912 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263781AbUFKKXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 06:23:41 -0400
Date: Fri, 11 Jun 2004 12:23:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040611102327.GF13834@elf.ucw.cz>
References: <20040609130451.GA23107@elf.ucw.cz> <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au> <20040610105629.GA367@gondor.apana.org.au> <20040610212448.GD6634@elf.ucw.cz> <20040610233707.GA4741@gondor.apana.org.au> <20040611094844.GC13834@elf.ucw.cz> <20040611101655.GA8208@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040611101655.GA8208@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Thanks, but my question remains: why do we need the memset?  The
> > > area allocated is either thrown away because it collides or is
> > > overwritten with the pagedir stuff straight away.
> > 
> > You are right, it should not be needed.
> 
> Great.  Here's the patch that removes the memset calls from both
> pmdisk and swsusp.  It depends on the previous patches in this
> thread.

If you want more cleanups, copy_pagedir() should be probably replaced
by simple memset...
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
