Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVF2PtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVF2PtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVF2PtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:49:03 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:9386 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261467AbVF2Pst convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:48:49 -0400
Date: Wed, 29 Jun 2005 11:48:25 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Denis Vlasenko <vda@ilport.com.ua>, Arjan van de Ven <arjan@infradead.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
In-Reply-To: <20050629151053.GC2130@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0506291141090.22775@localhost.localdomain>
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
 <200506291714.32990.vda@ilport.com.ua> <20050629142317.GB2130@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0506291046020.22775@localhost.localdomain>
 <20050629151053.GC2130@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Jun 2005, Jörn Engel wrote:

>
> All nice and well.  But still, for the sake of simplicity and me not
> wanting to think, I prefer always using spin_lock_irqsave for
> everything.  Since when should I stop and think about my own code?

OK, I use spin_lock_irqsave first, and then I only use spin_lock when I
already know interrupts are off.  But the locks I usually use are used by
interrupts and that is reason enough to use it.  I wouldn't use the
_irqsave for simplicity, I use it since I still believe it keeps latency
down for SMP.

>
> In fact, why don't we all sit down and start using KCSP for kernel
> hacking? ;)
>

Naw, I'm doing my PhD on implemting Linux drivers in SmallTalk. That will
make everybody happy!

-- Steve
