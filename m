Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269437AbRHQB7q>; Thu, 16 Aug 2001 21:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRHQB70>; Thu, 16 Aug 2001 21:59:26 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:41487 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268911AbRHQB7V>; Thu, 16 Aug 2001 21:59:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.9 does not compile [PATCH]
Date: Fri, 17 Aug 2001 04:05:46 +0200
X-Mailer: KMail [version 1.3]
Cc: Jeff Dike <jdike@karaya.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>, tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
In-Reply-To: <200108170146.UAA05171@ccure.karaya.com> <5.1.0.14.2.20010817015007.045689b0@pop.cus.cam.ac.uk> <3B7C7846.FD9DEE68@zip.com.au>
In-Reply-To: <3B7C7846.FD9DEE68@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010817015930Z16546-1232+417@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 17, 2001 03:49 am, Andrew Morton wrote:
> Anton Altaparmakov wrote:
> > 
> > #define min(x,y) \
> >          ({ typeof(x) __x = (x); typeof(y) __y = (y); __x < __y ? __x : 
__y; })
> > 
> > int test(int a, int b, int c)
> > {
> >          return min(a, min(b, c));
> > }
> 
> Problems occur if the caller happens to pass in variables whose
> names confilct with the ones you chose in the above macro:

I remember the thread in detail.  We must have similar scoping problems in 
innumerable macros.  I'd a braindead flaw in C's scoping rules, and you know, 
I don't think it matters.  Don't use local variables with names like __foo.

--
Daniel
