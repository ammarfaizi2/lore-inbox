Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280628AbRKKTna>; Sun, 11 Nov 2001 14:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280631AbRKKTnV>; Sun, 11 Nov 2001 14:43:21 -0500
Received: from unthought.net ([212.97.129.24]:49064 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S280628AbRKKTnG>;
	Sun, 11 Nov 2001 14:43:06 -0500
Date: Sun, 11 Nov 2001 20:43:05 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011111204305.A16792@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111041502390.21449-100000@weyl.math.psu.edu> <viro@math.psu.edu> <20011104205248.Q14001@unthought.net> <Pine.GSO.4.21.0111041502390.21449-100000@weyl.math.psu.edu> <20011104211118.U14001@unthought.net> <8Ce2D-PXw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <8Ce2D-PXw-B@khms.westfalen.de>; from kaih@khms.westfalen.de on Sun, Nov 11, 2001 at 12:06:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 12:06:00PM +0200, Kai Henningsen wrote:
> jakob@unthought.net (Jakob ¥stergaard)  wrote on 04.11.01 in <20011104211118.U14001@unthought.net>:
...
> >
> > A regex won't tell me if  345987 is a signed or unsigned 32-bit or 64-bit
> > integer,  or if it's a double.
> 
> You do not *need* that information at runtime. If you think you do, you're  
> doing something badly wrong.

I would prefer to have the information at compile-time, so that I would get
a compiler error if I did something wrong.

But that's unrealistic - some counter could change it's type from kernel
release to kernel release.

Now, my program needs to deal with the data, perform operations on it,
so naturally I need to know what kind of data I'm dealing with.  Most likely,
my software will *expect* some certain type, but if I have no way of verifying
that my assumption is correct, I will lose sooner or later...

> 
> I cannot even imagine what program would want that information.

Uh. Any program using /proc data ?

> 
> > Sure, implement arbitrary precision arithmetic in every single app out there
> > using /proc....
> 
> Bullshit. Implement whatever arithmetic is right *for your problem*. And  
> notice when the value you get doesn't fit so you can tell the user he  
> needs a newer version. That's all.
> 
> There's no reason whatsoever to care what data type the kernel used.

So my program runs for two months and then aborts with an error because
some counter just happened to no longer fit into whatever type I assumed
it was ?

Come on - you just can't code like that...

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
