Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbRK3TTB>; Fri, 30 Nov 2001 14:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280980AbRK3TSw>; Fri, 30 Nov 2001 14:18:52 -0500
Received: from zeus.kernel.org ([204.152.189.113]:2506 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S280975AbRK3TSm>;
	Fri, 30 Nov 2001 14:18:42 -0500
Date: Fri, 30 Nov 2001 11:18:09 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] fbdev blank cleanup
Message-ID: <Pine.LNX.4.10.10111301108440.26676-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is pretty big. Basically it moves the blank function out of
struct fb_info into struct fb_ops where it belongs. I makes it flexiable
that if your hardware doesn't support blanking of any kind that you can
leave this field NULL in struct fb_ops. At present if you don't supply a
blank function it could oops (see where blank() is called in fbcon.c). 
Thus people are forced to supply a empty function. This saves that
overhead of a function call for those drivers. I have tested it on my
local machine for the past 24 hours. It works fine. I did a compile test
for every driver that is avaliable on the ix86 thus those drivers do
compile and most likely work. Please test this on other hardware
platforms and across drivers. 

Since the patch is to big it is at the following link:

http://www.transvirtual.com/~jsimmons/blank.diff

Please note it also includes the patch I sent Linus earlier for fb.h. I
will remove that part once that patch goes in. Thank you.

 


