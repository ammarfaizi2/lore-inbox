Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTLTHgy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 02:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTLTHgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 02:36:54 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:18346 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S263850AbTLTHgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 02:36:52 -0500
Message-ID: <3FE3FC11.70009@wmich.edu>
Date: Sat, 20 Dec 2003 02:36:49 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11 framebuffer Matrox
References: <200312190314.13138.schwientek@web.de> <3FE2B717.7020502@convergence.de> <20031219213734.GA27975@irc.pl>
In-Reply-To: <20031219213734.GA27975@irc.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:
> On Fri, Dec 19, 2003 at 09:30:15AM +0100, Michael Hunold wrote:
> 
>>Can somebody definately say if "matroxfb" is working for 2.6? I haven't 
>>tested it for a while, but I was surprised to find it non-working in 2.6...
> 
> 
>  Not working for me. G550 driving Samsung SyncMaster 171s (LCD).
> It locked system several times in the past when switching between XFree
> and fb console.
>  I was told to use exact resolution and color depth wi fbcon and X.
> In my case, it's 1280x1024-16bpp. It is working great in X, but
> fbcon do not work - all I get is a black screen and lock when
> I try to blinfly run XFree.
> 


last time i tried it (-test7 or so) it worked. your normal fbcon and 
what not drivers do not work. They haven't been updated to handle the 
new fb code. You'll need to do all your configuring via kernel or module 
loading and cross your fingers and hope xfree86 can load based off it. 
  Also, i never got a non-blank console when using matroxfb... once it 
loaded i always had to blindly move around and start X and what not.


But, what's really the point in using X with matroxfb? You lose half 
your memory off the bat that X cannot access and you get no added 
performance or anything.  It really does not seem worth it.  Use 
matroxfb if you need to do fb stuff in a console without X.  Otherwise, 
stick to just plain console and X and forget about matroxfb.

