Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVLBJ1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVLBJ1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 04:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbVLBJ1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 04:27:43 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:64276 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750958AbVLBJ1n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 04:27:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pBVtVs4hHhEGcxnK4yT4wjIpHD1nIl0gzbfoL1DCtHzKBVZYaY8nJFy1g2kiJ7193F0Ht6VrS5aJT3x8BQXxfEA4nb2QD4pz8ZXDaKfVuwJYzLkhpaa7FVmSozsqQc+SbJtsv4dTnu4n/hGkE/Q+XrBlvIxTHpJvKxzwWa+LeL8=
Message-ID: <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
Date: Fri, 2 Dec 2005 17:27:40 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Use enum to declare errno values
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
In-Reply-To: <200512020849.28475.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	 <20051123233016.4a6522cf.pj@sgi.com>
	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>
	 <200512020849.28475.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/2, Denis Vlasenko <vda@ilport.com.ua>:
> On Thursday 01 December 2005 22:01, linux-os (Dick Johnson) wrote:
> > On Thu, 24 Nov 2005, Paul Jackson wrote:
> >
> > > If errno's were an enum type, what would be the type
> > > of the return value of a variety of kernel routines
> > > that now return an int, returning negative errno's on
> > > error and zero or positive values on success?
> >
> > enums are 'integer types', one of the reasons why #defines
> > which are also 'integer types' are just as useful. If you
> > want to auto-increment these integer types, then enums are
> > useful. Otherwise, just use definitions.
>
> There is another reason why enums are better than #defines:

This is a reason why enums are worse than #defines.

Unlike in other languages, C enum is not much useful in practices.
Maybe the designer wanted C to be as fancy as other languages?  C
shouldn't have had enum imho. Anyway we don't have any strong motives
to switch to enums.

>
> file.h:
> #define foo 123
> enum {
>         bar = 123
> };
>
>
> file.c:
> ...
> #include "something_which_eventually_includes_file.h"
> ...
> int f(int foo, int bar)
> {
>         return foo+bar;
> }
>
> Above program has compile-time bug, but it's rather hard
> to see it if you are looking at file.c alone.
> --
> vda
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
