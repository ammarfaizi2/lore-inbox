Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265856AbSIRJ2k>; Wed, 18 Sep 2002 05:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265862AbSIRJ2j>; Wed, 18 Sep 2002 05:28:39 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:134 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S265856AbSIRJ2j>; Wed, 18 Sep 2002 05:28:39 -0400
Message-Id: <200209180945.g8I9j9We000386@pool-141-150-238-137.delv.east.verizon.net>
Date: Wed, 18 Sep 2002 05:45:00 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.36 compile error (ide-cd) any fix yet ?
References: <20020918165157.35e8d29b.Corporal_Pisang@Counter-Strike.com.my>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020918165157.35e8d29b.Corporal_Pisang@Counter-Strike.com.my>; from Corporal_Pisang@Counter-Strike.com.my on Wed, Sep 18, 2002 at 04:51:57PM +0800
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop015.verizon.net from [141.150.241.241] using ID <vze2j9fk@verizon.net> at Wed, 18 Sep 2002 04:33:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corporal Pisang wrote:
> Any fixes yet for this compile error ?
> 
> gcc -Wp,-MD,./.ide-cd.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ide_cd   -c -o ide-cd.o ide-cd.c
> In file included from ide-cd.c:318:
> ide-cd.h:440: error: long, short, signed or unsigned used invalidly for `slot_tablelen'

I looked at this last time you reported it.  Which compiler are you
using?

Line 440 of ide-cd.h is:

	__u8 short slot_tablelen;

'short' doesn't make any sense there.  __u8 is unsigned char.
I can't figure out why you're the only one getting an error.  That
change went in a few kernels ago and I've compiled ide-cd in every one
of them and it compiles fine for me.

-- 
Skip
