Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266363AbUA2UDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266365AbUA2UDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:03:50 -0500
Received: from 62-43-4-76.user.ono.com ([62.43.4.76]:1664 "EHLO
	mortadelo.pirispons.net") by vger.kernel.org with ESMTP
	id S266363AbUA2UDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:03:46 -0500
Date: Thu, 29 Jan 2004 21:03:45 +0100
From: Kiko Piris <kernel@pirispons.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Xan <DXpublica@telefonica.net>, Zack Winkles <winkie@linuxfromscratch.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] fbdev console: can't load vga=791 and yes vga=ask!
Message-ID: <20040129200345.GA1876@pirispons.net>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Xan <DXpublica@telefonica.net>,
	Zack Winkles <winkie@linuxfromscratch.org>,
	linux-kernel@vger.kernel.org
References: <20040127225909.GA5271@sacarino.pirispons.net> <Pine.LNX.4.44.0401272331410.19265-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401272331410.19265-100000@phoenix.infradead.org>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2004 at 23:37, James Simmons wrote:

> > In 2.6.1 I could use framebuffer through vesafb just with that parameter
> > (vga=795, ie. 1280x10224 16M).
> 
> This is very strange. 

Well, back home again and I've been able to do some tests.

vesafb boots fine with 2.6.2-rc2, just I have to specify the parameter
suggested by Zack Winkles : "vga=0795 video=vesafb:ywrap,pmipal,mtrr"

> Give it a try. If you have problems use my patch at 
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> > Althoug, I would prefer to use radeonfb instead of vesafb (radeonfb
> > turns off my monitor and vesafb does not).
> > 
> > Anyone with a Radeon 9200 does use radeonfb ? If yes, any special boot
> > parameter?
> 
> Try my newest patch. It has a updated radeon driver.

I tried the patch you mention here:

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

against 2.6.1 (it does not apply to 2.6.2-rc2) and it does not work for
me. I can only use 640x480. Any other resolution I try results in an
usupported frequency for my monitor.

My graphics card is:

# lspci -s 01:00.1 -v
01:00.1 Display controller: ATI Technologies Inc: Unknown device 5d44 (rev 01)
        Subsystem: Unknown device 18bc:0171
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Memory at e5010000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2

Please let me know if I can try anything else. I'll be very glad to test
it (so I can use radeonfb, because as I said, I prefer it over vesafb).

TIA.

-- 
Kiko
