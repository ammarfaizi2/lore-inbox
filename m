Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSLMQoJ>; Fri, 13 Dec 2002 11:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSLMQoJ>; Fri, 13 Dec 2002 11:44:09 -0500
Received: from tenax.loup.net ([65.169.6.40]:22087 "EHLO tenax.loup.net")
	by vger.kernel.org with ESMTP id <S265126AbSLMQoI>;
	Fri, 13 Dec 2002 11:44:08 -0500
Date: Fri, 13 Dec 2002 09:49:28 -0700
Message-Id: <200212131649.gBDGnSS04425@flux.loup.net>
From: Mike Hayward <hayward@loup.net>
To: wli@holomorphy.com
CC: linux-kernel@vger.kernel.org
In-reply-to: <20021213154544.GK9882@holomorphy.com> (message from William Lee
	Irwin III on Fri, 13 Dec 2002 07:45:44 -0800)
Subject: Re: Intel P6 vs P7 system call performance
References: <200212090830.gB98USW05593@flux.loup.net> <20021213154544.GK9882@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

 > On Mon, Dec 09, 2002 at 01:30:28AM -0700, Mike Hayward wrote:
 > > Any ideas?  Not sure I want to upgrade to the P7 architecture if this
 > > is right, since for me system calls are probably more important than
 > > raw cpu computational power.
 > 
 > This is the same for me. I'm extremely uninterested in the P-IV for my
 > own use because of this.

I've also noticed that algorithms like the recursive one I run which
simulates solving the Tower of Hanoi problem are most likely very hard
to do branch prediction on.  Both the code and data no doubt fit
entirely in the L2 cache.  The AMD processor below is a much lower
cost and significantly lower clock rate (and on a machine with only a
100Mhz Memory bus) than the Xeon, yet dramatically outperforms it with
the same executable, compiled with gcc -march=i686 -O3.  Maybe with a
better Pentium 4 optimizing compiler the P4 and Xeon could improve a
few percent, but I doubt it'll ever see the AMD numbers.

Recursion Test--Tower of Hanoi

Uni  AMD XP 1800            2.4.18 kernel  46751.6 lps   (10 secs, 6 samples)
Dual Pentium 4 Xeon 2.4Ghz  2.4.19 kernel  33661.9 lps   (10 secs, 6 samples)

- Mike
