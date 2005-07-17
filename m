Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVGQVft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVGQVft (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 17:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVGQVfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 17:35:48 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:52699 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261281AbVGQVfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 17:35:46 -0400
Date: Sun, 17 Jul 2005 23:35:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jon Smirl <jonsmirl@gmail.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] add NULL short circuit to fb_dealloc_cmap()
In-Reply-To: <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.61.0507172335110.18775@yvahk01.tjqt.qr>
References: <200507172043.41473.jesper.juhl@gmail.com>
 <9e473391050717132233347d25@mail.gmail.com> <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> struct fb_super_cmap {
>>    struct fb_cmap cmap;
>>    __u16 red[255];
>>    __u16 blue[255];
>>    __u16 green[255];
>>    __u16 transp[255];
>                  ^^^
>I assume you meant 256?

Even if it really was 255, it should probably be made 256 to have things 
aligned <-- if that matters.


Jan Engelhardt
-- 
