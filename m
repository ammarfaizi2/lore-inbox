Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSLNAsu>; Fri, 13 Dec 2002 19:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSLNAsu>; Fri, 13 Dec 2002 19:48:50 -0500
Received: from [209.184.141.189] ([209.184.141.189]:53746 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S265517AbSLNAst>;
	Fri, 13 Dec 2002 19:48:49 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Mike Hayward <hayward@loup.net>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
In-Reply-To: <200212131649.gBDGnSS04425@flux.loup.net>
References: <200212090830.gB98USW05593@flux.loup.net>
	 <20021213154544.GK9882@holomorphy.com>
	 <200212131649.gBDGnSS04425@flux.loup.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1039827325.31718.27.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Dec 2002 18:55:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-13 at 10:49, Mike Hayward wrote:
> Hi Bill,
> 
>  > On Mon, Dec 09, 2002 at 01:30:28AM -0700, Mike Hayward wrote:
>  > > Any ideas?  Not sure I want to upgrade to the P7 architecture if this
>  > > is right, since for me system calls are probably more important than
>  > > raw cpu computational power.
>  > 
>  > This is the same for me. I'm extremely uninterested in the P-IV for my
>  > own use because of this.
> 
> I've also noticed that algorithms like the recursive one I run which
> simulates solving the Tower of Hanoi problem are most likely very hard
> to do branch prediction on.  Both the code and data no doubt fit
> entirely in the L2 cache.  The AMD processor below is a much lower
> cost and significantly lower clock rate (and on a machine with only a
> 100Mhz Memory bus) than the Xeon, yet dramatically outperforms it with
> the same executable, compiled with gcc -march=i686 -O3.  Maybe with a
> better Pentium 4 optimizing compiler the P4 and Xeon could improve a
> few percent, but I doubt it'll ever see the AMD numbers.
What GCC were you using? I'd use 3.2, or 3.2.1 myself with
-march=pentium4 and -mcpu=pentium4 to see if there *is* any difference
there. On my quad P4 Xeon 1.6Ghz with 1M L3 cache, I can compile a
kernel in about 35 seconds. Mind you that's my own config, not
*everything*. On a dual athlon MP at 1.8 Ghz, I get about 5 mins or so.
Both are running with make -jx where X is the saturation value.


> Recursion Test--Tower of Hanoi
> 
> Uni  AMD XP 1800            2.4.18 kernel  46751.6 lps   (10 secs, 6 samples)
> Dual Pentium 4 Xeon 2.4Ghz  2.4.19 kernel  33661.9 lps   (10 secs, 6 samples)
> 
> - Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
GrandMasterLee <masterlee@digitalroadkill.net>
