Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbTBTTs3>; Thu, 20 Feb 2003 14:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTBTTs3>; Thu, 20 Feb 2003 14:48:29 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:50448 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266868AbTBTTs2>; Thu, 20 Feb 2003 14:48:28 -0500
Date: Thu, 20 Feb 2003 19:58:31 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBdev updates.
In-Reply-To: <20030220182941.GK14445@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0302201951270.20350-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was for five weeks in U.S., so I did not do anything with
> matroxfb during that time. I plan to use fillrect and copyrect
> from generic code 

I have ported the accelerated functions to the new api. What is left is to 
deal with the loadfont and putcs issue which I'm working on the code right 
now.

> (although it means unnecessary multiply on
> generic side, and division in matroxfb, 

????

> but well, if we gave
> up on reasonable speed for fbdev long ago...). 

This is not true. Several benchmarks have shown a large performance 
improvement in 2.5.X.

> But I simply
> want loadfont and putcs hooks for character painting. And if 
> fbdev maintainer does not want to give me them, well, then 
> matroxfb and fbdev are not compatible.

Working on it. I starting with Tony's tileblit patch but I plan to expand 
it even more i.e texture maps to draw fonts.
 
> (3) persuade me that I want to write matroxcon and forget about fbcon at all, or

This is the best solution. 

> Besides that with that strange additional copy in accel_putcs
> I get much slower output than with 2.4.x... and although I

Again not true.

