Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266354AbUA2UAe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266363AbUA2UAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:00:34 -0500
Received: from waste.org ([209.173.204.2]:6564 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266354AbUA2UAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:00:32 -0500
Date: Thu, 29 Jan 2004 14:00:26 -0600
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
Message-ID: <20040129200020.GK21888@waste.org>
References: <20040129193727.GJ21888@waste.org> <Pine.LNX.4.58.0401291142160.689@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401291142160.689@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 11:44:27AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 29 Jan 2004, Matt Mackall wrote:
> > 
> > a) (no -psl)
> > 
> > void *foo(void) {
> > 
> >  instead of
> > 
> > void *
> > foo(void) {
> 
> And why not 
> 
> 	void *foo(void)
> 	{
> 
> which is the _right_ thing to use?

Doh, of course the above is what it actually does.
 
> > b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
> > c) (-ncs) "(void *)foo" rather than "(void *) foo"
> 
> Hmm.. I don't know about (c), that one tends to vary by usage.

I did a bit of visual grep for counterinstances of c) in core code but
nothing jumped out at me. I'm pretty sure the former is more common
practice and I at least find it helpful visually given the precedence
of cast operators. Thing is, indent feels obliged to force it one way
or the other, so I think it should err on the no space side.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
