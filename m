Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUCNGhh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 01:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbUCNGhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 01:37:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:2991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263309AbUCNGhf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 01:37:35 -0500
Date: Sat, 13 Mar 2004 22:37:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alex Lyashkov <shadow@psoft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible kernel bug in signal transit.
Message-Id: <20040313223736.25735f2c.akpm@osdl.org>
In-Reply-To: <1079245606.8186.51.camel@berloga.shadowland>
References: <1079197336.13835.15.camel@berloga.shadowland>
	<20040313171856.37b32e52.akpm@osdl.org>
	<1079239159.8186.24.camel@berloga.shadowland>
	<20040313210051.6b4a2846.akpm@osdl.org>
	<1079241668.8186.33.camel@berloga.shadowland>
	<20040313214700.387c4ff3.akpm@osdl.org>
	<1079243761.8186.46.camel@berloga.shadowland>
	<20040313220901.64dcd003.akpm@osdl.org>
	<1079245606.8186.51.camel@berloga.shadowland>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Lyashkov <shadow@psoft.net> wrote:
>
> __ ______, 14.03.2004, __ 08:09, Andrew Morton __________:
> > Alex Lyashkov <shadow@psoft.net> wrote:
> > >
> > > > Well we can only return one error code.  Or are you suggesting that we
> > >  > should terminate the loop early on error?  If so, why?
> > >  You say me can return _last_ error core. but this function return
> > >  _first_. 
> > 
> > It doesn't matter, really.  Other parts of the kernel will generally return
> > the first-encountered error because at times it _does_ matter.  But here it
> > doesn't.
> okey. second question.
> a really need extra variable instead change conditions in return ?

I think it's clearer that way, don't you?
