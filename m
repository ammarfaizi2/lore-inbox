Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUA0W7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUA0W7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:59:17 -0500
Received: from [62.97.69.192] ([62.97.69.192]:31872 "EHLO
	sacarino.pirispons.net") by vger.kernel.org with ESMTP
	id S263486AbUA0W7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:59:15 -0500
Date: Tue, 27 Jan 2004 23:59:09 +0100
From: Kiko Piris <kernel@pirispons.net>
To: Xan <DXpublica@telefonica.net>
Cc: Zack Winkles <winkie@linuxfromscratch.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] fbdev console: can't load vga=791 and yes vga=ask!
Message-ID: <20040127225909.GA5271@sacarino.pirispons.net>
Mail-Followup-To: Xan <DXpublica@telefonica.net>,
	Zack Winkles <winkie@linuxfromscratch.org>,
	linux-kernel@vger.kernel.org
References: <200401270153.12568.DXpublica@telefonica.net> <200401271324.33883.DXpublica@telefonica.net> <20040127131922.GA20659@pirispons.net> <200401271859.03309.DXpublica@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401271859.03309.DXpublica@telefonica.net>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2004 at 18:59, Xan wrote:

> I did _not_ booted fine. I tried if with vga=795 it booted fine as you and the 
> same result as 791 obtained: black screen until X window appears. When I 
> switch to pty, black screen or color (and deformed) puzzle of X window 
> contain.

In 2.6.1 I could use framebuffer through vesafb just with that parameter
(vga=795, ie. 1280x10224 16M).

In 2.6.2-rc* it does not work for me, just blank screen if I try to use
vesafb.

Zack Winkles pointed me that I could try passing
video=vesafb:ywrap,pmipal,mtrr,vga=795 to get vesafb working.

Thanks for it. Right now I'm on travel and I can not try it, I will be
able to do so on thursday.

> It's rare thing: I could promise that I compiled 2.6.0 with the same 
> configuration and it worked.

I did not try 2.6.0 with that radeon 9200 (I didn't have it then).
vesafb stopped working for me in 2.6.2-rc1.

> Can you explain me what means 791, 795, ... and what number belongs to 
> 1024x768 and 16 colors, and if 800x600 and 256?...

You can see it in Documentation/fb/vesafb.txt (that file has the numbers
in hexadecimal, and kernel wants the boot parameter in decimal, just
convert it).

Althoug, I would prefer to use radeonfb instead of vesafb (radeonfb
turns off my monitor and vesafb does not).

Anyone with a Radeon 9200 does use radeonfb ? If yes, any special boot
parameter?

-- 
Kiko
