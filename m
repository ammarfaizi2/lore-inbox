Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVISGJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVISGJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVISGJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:09:09 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:38675 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932324AbVISGJI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:09:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nEyWeDrMx0LVpeNnBkIw0CPMWaM1ukbkvJtbySxV0VPoWyXrPeDYM8W08KAh7toSc4GSoqklDIFHaG6yT3FKhrH9SMJzd8J1+oQunuVDnbOAAE7G6QXQikFftyTO3UUjzyXIx4crehJeAuDuuFISuFYFHl4kA2UzornzAfVo8tM=
Message-ID: <2cd57c9005091823093cf90217@mail.gmail.com>
Date: Mon, 19 Sep 2005 14:09:04 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: p = kmalloc(sizeof(*p), )
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Robert Love <rml@novell.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1127079026.8932.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	 <1127061146.6939.6.camel@phantasy>
	 <20050918165219.GA595@alpha.home.local>
	 <20050918171845.GL19626@ftp.linux.org.uk>
	 <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
	 <20050918190714.GO19626@ftp.linux.org.uk>
	 <1127079026.8932.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > It would be very useful when e.g. tracking down improper uses of
> > struct file, struct dentry, etc. - stuff that should always be
> > allocated by one helper function.  Same goes for e.g. net_device -
> 
> Another useful trick here btw is to make such objects contain (when
> debugging)
> 
>         void *magic_ptr;
> 
> which is initialised as foo->magic_ptr = foo;
> 
> That catches anyone copying them and tells you what got copied

seems like C++ RTTI
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
