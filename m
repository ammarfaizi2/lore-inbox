Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWIMPw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWIMPw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWIMPw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:52:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:37409 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750974AbWIMPw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:52:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W6BF2pQUbH4diumiFhzMoW7jOAiY1gYZiUlnRLBQw/3R7BUbZny/QuA/23z02uUf2vkVecz0+6FLpOSI2mWpBktpWL0sg1QpAv4WGMHSHZ5OkczA5FX9PNPBu8xwB3Zvcs82tsHG5m5RIRl4Ogqc2BfGd/twdg3mwOdviqZ78ro=
Message-ID: <787b0d920609130852x1e335cc8l7e398dbc046fa3f8@mail.gmail.com>
Date: Wed, 13 Sep 2006 11:52:52 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: OT: calling kernel syscall manually
Cc: guest01@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <1158130530.18619.156.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920609122235j57ac327ckcc8d08832fb3989c@mail.gmail.com>
	 <1158130530.18619.156.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2006-09-13 at 01:35 -0400, Albert Cahalan wrote:
> > > The third one has always been broken on i386 for PIC code
> >
> > No, I was just using it today in PIC i386 code.
> > The %ebx register gets pushed, the needed value
> > gets moved into %ebx, the int 0x80 is done, and
> > the %ebx register gets popped. Only a few odd
> > calls like clone() need something different.
>
> That's a very recent change -- it was broken for years before that.

It's fixed now. Obviously people care. Probably the
only reason it wasn't fixed earlier is that PIC code
just isn't all that popular for i386 executables.

> > > and was pointless anyway, since glibc provides this
> > > functionality. The kernel method has been removed from
> > > userspace visibility all architectures, and we plan to
> > > remove it entirely in 2.6.19 since it's not at all useful.
> >
> > It's damn useful. Hint: Linux does not require glibc.
>
> Are you being deliberately obtuse or is it just a natural talent?
>
> Other C libraries also provide syscall() -- at least dietlibc and uClibc
> do.

OK, but I don't need to be using a C library. I could write
my own or do without.

> Kernel headers do not exist to provide a library of random crap for
> userspace to use.

Sure, but this is existing functionality. It also isn't random crap;
it's the kernel's system call interface.
