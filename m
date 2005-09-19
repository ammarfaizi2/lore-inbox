Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVISGrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVISGrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVISGrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:47:52 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:27301 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750730AbVISGrv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:47:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CnzI37Gp6/prk4O48bYJ4FZrmpbzgLV6Xj2fzCt8b+6FRledEukX6gyEeC9pFfmMOVqT3Y4gCAfke7f5lyp4qTxCj6Y1ky8kjHzJ7Ffv56MXDh1d7ffm6BsDWwm/2bsgPvGWa/Zq9xQpa0oPb28fwabLqJCPgpw3P93V7cLN/Ds=
Message-ID: <2cd57c9005091823472e535eb1@mail.gmail.com>
Date: Mon, 19 Sep 2005 14:47:48 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: Robert Love <rml@novell.com>
Subject: Re: p = kmalloc(sizeof(*p), )
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <1127061146.6939.6.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	 <1127061146.6939.6.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/05, Robert Love <rml@novell.com> wrote:
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
 
6. The attribute size is _firstly_ an attribute of the data type, not
of the variable. So sizeof(type) is a bit saner than sizeof(var).
While allocating, we are allocating an instance of the type and we
don't care which instance it would be but we care what data type it
is.

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
