Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264937AbSJ3U5Y>; Wed, 30 Oct 2002 15:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJ3U5Y>; Wed, 30 Oct 2002 15:57:24 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:54766 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264937AbSJ3U5X>; Wed, 30 Oct 2002 15:57:23 -0500
Date: Wed, 30 Oct 2002 13:56:38 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [BK console] console updates.
Message-ID: <Pine.LNX.4.33.0210301343580.1392-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!!!

   Along with the new fbdev api I also have rewritten the console layer.
The goals are:

1) The idea here was to move alot of the basic functionaly present in
   alot of low level drivers into the the higher layers thus making the
   low level drivers smaller and cleaner. A good example is using the
   /dev/fb interface to resize a VC. That is just plain dumb.

2) The second goal was to seperate out the terminal emulation to allow
   for a light weight printk. Also the idea was to make the VT console
   system modular. On embedded devices then we can insmod the VT
   console system. This is partially done.

3) Multi-desktop systems. Already done this. The current code in BK
   doesn't support this just yet as I have a few bug to beat out for
   single headed systems. It will take about one more week to get this
   ready.


I doubt this code will go into 2.5.X but it is avaiable for anyone to play
with it.

bk://linuxconsole.bkbits.net

BTW I will make patches avaiable as soon as 2.5.45 comes out.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

