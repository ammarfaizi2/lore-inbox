Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314783AbSEHRxI>; Wed, 8 May 2002 13:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314740AbSEHRxH>; Wed, 8 May 2002 13:53:07 -0400
Received: from [80.120.128.82] ([80.120.128.82]:46341 "EHLO hofr.at")
	by vger.kernel.org with ESMTP id <S314625AbSEHRxH>;
	Wed, 8 May 2002 13:53:07 -0400
From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200205081658.g48GwmV06862@hofr.at>
Subject: Re: Measure time
In-Reply-To: <NCBBLGAKEDCMNBGMONMPMEEHCKAA.pickle@alien.net.au> from Simon Butcher
 at "May 9, 2002 02:51:42 am"
To: Simon Butcher <pickle@alien.net.au>
Date: Wed, 8 May 2002 18:58:47 +0200 (CEST)
CC: "Serguei I. Ivantsov" <admin@gsc-game.kiev.ua>,
        Der Herr Hofrat <der.herr@mail.hofr.at>, linux-gcc@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi,
> 
> ftime() will return milliseconds, but it's considered an obsolete function.
> You could use gettimeofday() (as Richard Johnson suggested) to get
> microseconds and divide them to get milliseconds, although I don't know how
> time critical your routines are.
> 
> If you're still looking for nanoseconds, I'm told you can use
> clock_gettime() but it's still quite unavailable (I've never seen it myself,
> yet).. however even if it was available you possibly wouldn't get a very
> high resolution from it with current systems..
>
clock_gettime() is available in the hard realtime extensions like RTLinux .
The clock resolution is limited to 32ns though - and atleast on X86 I don't
think there is a way to get below that.

hofrat 
