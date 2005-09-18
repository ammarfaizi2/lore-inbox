Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVIRRci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVIRRci (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 13:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVIRRch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 13:32:37 -0400
Received: from xenotime.net ([66.160.160.81]:42420 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932132AbVIRRch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 13:32:37 -0400
Date: Sun, 18 Sep 2005 10:32:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Robert Love <rml@novell.com>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: p = kmalloc(sizeof(*p), )
Message-Id: <20050918103234.0b923c73.rdunlap@xenotime.net>
In-Reply-To: <1127061146.6939.6.camel@phantasy>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	<1127061146.6939.6.camel@phantasy>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005 12:32:26 -0400 Robert Love wrote:

> On Sun, 2005-09-18 at 11:06 +0100, Russell King wrote:
> 
> > +The preferred form for passing a size of a struct is the following:
> > +
> > +       p = kmalloc(sizeof(*p), ...);
> > +
> > +The alternative form where struct name is spelled out hurts readability and
> > +introduces an opportunity for a bug when the pointer variable type is changed
> > +but the corresponding sizeof that is passed to a memory allocator is not.
> 
> Agreed.
> 
> Also, after Alan's #4:
> 
> 5.  Contrary to the above statement, such coding style does not help,
>     but in fact hurts, readability.  How on Earth is sizeof(*p) more
>     readable and information-rich than sizeof(struct foo)?  It looks
>     like the remains of a 5,000 year old wolverine's spleen and
>     conveys no information about the type of the object that is being
>     created.

I also dislike & disagree with the CodingStyle addition....


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
