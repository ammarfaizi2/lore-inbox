Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277327AbRJEICJ>; Fri, 5 Oct 2001 04:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277332AbRJEICA>; Fri, 5 Oct 2001 04:02:00 -0400
Received: from t2.redhat.com ([199.183.24.243]:4341 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277327AbRJEIBw>; Fri, 5 Oct 2001 04:01:52 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there> 
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there> 
To: adam.keys@HOTARD.engr.smu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development Setups 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 09:02:03 +0100
Message-ID: <19213.1002268923@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


adam.keys@engr.smu.edu said:
> I was thinking of starting with a modern machine for developing/
> compiling on,  and then older machine(s) for testing.  This way I
> would not risk losing data  if I oops or somesuch. 

With journalling filesystems you needn't worry _too_ much about losing 
data; depending of course on what you're hacking on. Having two separate 
boxen for development and testing is mostly valuable because you can keep 
working when you break it - it doesn't take your entire desktop environment 
down with it.


adam.keys@engr.smu.edu said:
>  Which brings me to the final question.  Is there any reason to choose
>  architecture A over architecture B for any reason besides
> arch-specific  development in the kernel or for device drivers?

If you're developing device drivers and have the choice, pick something 
esoteric to enforce good behaviour. Something which does out-of-order 
stores, has non-cache-coherent DMA, is big-endian and preferably 64-bit. I 
think both mips64 and sparc64 boards can meet all those criteria - if not, 
get as close as you can. 

--
dwmw2


