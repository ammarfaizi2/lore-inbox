Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbUDEX2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDEX2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:28:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:6840 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263535AbUDEX2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:28:07 -0400
Date: Mon, 5 Apr 2004 16:30:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: [PATCH] Drop exported symbols list if !modules
Message-Id: <20040405163019.4e3ab546.akpm@osdl.org>
In-Reply-To: <1081207046.15272.44.camel@bach>
References: <20040405205539.GG6248@waste.org>
	<1081205099.15272.7.camel@bach>
	<20040405230723.GK6248@waste.org>
	<1081207046.15272.44.camel@bach>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> On Tue, 2004-04-06 at 09:07, Matt Mackall wrote:
> > On Tue, Apr 06, 2004 at 08:45:01AM +1000, Rusty Russell wrote:
> > > On Tue, 2004-04-06 at 06:55, Matt Mackall wrote:
> > > > Drop ksyms if we've built without module support
> > > > 
> > > > From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> > > > Subject: Re: 2.6.1-rc1-tiny2
> > > 
> > > Other than saving a little compile time, does this actually do anything?
> > > 
> > > I'm not against it, I just don't think I see the point.
> > 
> > Well it obviously saves memory and image size too;
> 
> Please measure it.  It's not obvious to me at all.

Miniscule savings

   text    data     bss     dec     hex filename
3221815  862456       0 4084271  3e522f vmlinux-before
3221591  862456       0 4084047  3e514f vmlinux-after

