Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131177AbQKBCMv>; Wed, 1 Nov 2000 21:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131804AbQKBCMl>; Wed, 1 Nov 2000 21:12:41 -0500
Received: from adsl-64-163-64-74.dsl.snfc21.pacbell.net ([64.163.64.74]:37134
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S131177AbQKBCMZ>; Wed, 1 Nov 2000 21:12:25 -0500
Message-Id: <200011020211.SAA14543@konerding.com>
To: john slee <indigoid@higherplane.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: test10 dies very early in boot 
In-Reply-To: Your message of "Wed, 01 Nov 2000 20:00:36 +1100."
             <20001101200036.D655@higherplane.net> 
Date: Wed, 01 Nov 2000 18:11:37 -0800
From: dek_ml@konerding.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee writes:
>hardware:
>	*	abit be6-2 mainboard
>	*	533 celeron (not overclocked)
>	*	192mb sdram
>	* 	seagate 20gb ide disk (not on ata66 port)
>
>compiler: gcc version 2.95.2 20000220 (Debian GNU/Linux)
>
>it gets as far as uncompressing the kernel and trying to boot it.  no
>further.  (doesn't get as far as displaying the 'Linux version ...'
>message).  sysrq doesn't work (not suprising),  ctrl-alt-delete doesn't
>work either.  reset button does work :-)


Um, I had the same problem with the kernel when I first downloaded it to try it out.
I was stumped for a while, turning of a number of features in the kernel,
before I figured it out.  You need to switch the processor type the kernel is compiled
for from "P-III"  to whatever is apropriate for your Celeron (I used a P-II, which
is basically the same instruction set as Celeron in Linux's view).

I didn't look at the source, but I bet early on the kernel tries to execute a P-III
instruction when compiled for P-III, and the P-II or Celeron gets confused and shuts down.

Once I compiled with P-II, kernel booted A-OK to multiuser :-)

Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
