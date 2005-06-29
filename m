Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVF2Pym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVF2Pym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVF2Pym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:54:42 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:40359 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261498AbVF2Pyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:54:40 -0400
Date: Wed, 29 Jun 2005 17:54:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Arjan van de Ven <arjan@infradead.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
Message-ID: <20050629155436.GD2130@wohnheim.fh-wedel.de>
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain> <200506291714.32990.vda@ilport.com.ua> <20050629142317.GB2130@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0506291046020.22775@localhost.localdomain> <20050629151053.GC2130@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0506291141090.22775@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0506291141090.22775@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 June 2005 11:48:25 -0400, Steven Rostedt wrote:
> On Wed, 29 Jun 2005, Jörn Engel wrote:
> 
> > All nice and well.  But still, for the sake of simplicity and me not
> > wanting to think, I prefer always using spin_lock_irqsave for
> > everything.  Since when should I stop and think about my own code?
> 
> OK, I use spin_lock_irqsave first, and then I only use spin_lock when I
> already know interrupts are off.  But the locks I usually use are used by
> interrupts and that is reason enough to use it.  I wouldn't use the
> _irqsave for simplicity, I use it since I still believe it keeps latency
> down for SMP.

Ok, before even more people get confused - I was joking.  Simple code
is obviously a good thing to have.  Not thinking about code, well...

> > In fact, why don't we all sit down and start using KCSP for kernel
> > hacking? ;)
> 
> Naw, I'm doing my PhD on implemting Linux drivers in SmallTalk. That will
> make everybody happy!

... but it appears as if you got the joke.

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
