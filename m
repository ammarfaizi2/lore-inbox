Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWJASMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWJASMl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWJASMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:12:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932158AbWJASMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:12:40 -0400
Date: Sun, 1 Oct 2006 11:12:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Announce: gcc bogus warning repository
Message-Id: <20061001111226.3e14133f.akpm@osdl.org>
In-Reply-To: <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <451FC657.6090603@garzik.org>
	<1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Oct 2006 08:40:13 -0700
Daniel Walker <dwalker@mvista.com> wrote:

> On Sun, 2006-10-01 at 09:44 -0400, Jeff Garzik wrote:
> > The level of warnings in a kernel build has lately increased to the 
> > point where it is hiding bugs and otherwise making life difficult.
> > 
> > In particular, recent gcc versions throw warnings when it thinks a 
> > variable "MAY be used uninitialized", which is not terribly helpful due 
> > to the fact that most of these warnings are bogus.
> > 
> > For those that may find this valuable, I have started a git repo that 
> > silences these bogus warnings, after careful auditing of code paths to 
> > ensure that the warning truly is bogus.
> > 
> > The results may be found in the "gccbug" branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
> > 

Funny - I started doing the exact same thing here just eight hours ago. 
I'll send you anything which isn't in that git tree, thanks.

> Steven Rostedt an I worked on this problem in May. Steven came up with,
> a nice way to handle these warnings, which doesn't increase code size.
> Here's the post if your interested.
> 
> http://lkml.org/lkml/2006/5/11/50

I think we should merge that and use it.  No overhead, self-documenting,
easily greppable for.

The downsides are that it muckies up the source a little and introduces a
very small risk that real use-uninitialised bugs will be hidden.  But I
believe the benefit outweighs those disadvantages.
