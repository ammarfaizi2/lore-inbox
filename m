Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275571AbRKDTzx>; Sun, 4 Nov 2001 14:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275224AbRKDTze>; Sun, 4 Nov 2001 14:55:34 -0500
Received: from unthought.net ([212.97.129.24]:60376 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S277435AbRKDTz2>;
	Sun, 4 Nov 2001 14:55:28 -0500
Date: Sun, 4 Nov 2001 20:55:27 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104205527.R14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160Skz-1rDDSyC@fmrl05.sul.t-online.com> <20011104202406.N14001@unthought.net> <160T6C-1RvGb2C@fmrl05.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <160T6C-1RvGb2C@fmrl05.sul.t-online.com>; from tim@tjansen.de on Sun, Nov 04, 2001 at 08:41:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 08:41:34PM +0100, Tim Jansen wrote:
> On Sunday 04 November 2001 20:24, Jakob Østergaard wrote:
> > Does this work ?   Yes of course.  But what if I ported my program to
> > a 64 bit arch...  The program still compiles.  It also runs.  But the
> > values are no longer correct.   Now *that* is hell.
> 
> Actually I worry more about those programs that are already compiled and will 
> break when the kernel changes. But even if you recompile the code, how can 
> you be sure that the programmer uses longs instead of ints for those 64 bit 
> types? The C compiler allows the implicit conversion without warning. If you 
> change the type the program has to be changed, no matter what you do.

int get(result_t * result);

u32 a;
get(&a);

This will fail at compile time if result_t is 64 bits.

In C++ you could even do overloading where conversion is possible and
still have compile time errors when it's not possible.

> 
> > I want type information.
> 
> BTW nobody says to one-value-files can not have types (see my earlier posts 
> in this thread).

I don't dislike one-value-files - please tell me how you get type information

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
