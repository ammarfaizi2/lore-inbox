Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRDBSRV>; Mon, 2 Apr 2001 14:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131290AbRDBSRL>; Mon, 2 Apr 2001 14:17:11 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:32471 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131289AbRDBSQ6>;
	Mon, 2 Apr 2001 14:16:58 -0400
From: thunder7@xs4all.nl
Date: Mon, 2 Apr 2001 13:02:24 +0200
To: James Simmons <jsimmons@linux-fbdev.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: [lkml]Re: Matrox G400 Dualhead
Message-ID: <20010402130224.A4403@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <Pine.LNX.4.31.0104010737420.736-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.31.0104010737420.736-100000@linux.local>; from jsimmons@linux-fbdev.org on Sun, Apr 01, 2001 at 07:40:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2001 at 07:40:36AM -0700, James Simmons wrote:
> 
> >If I use X on an accelerated, normal Matrox screen, my monitor complains
> >on exit:
> >
> >fH 49.4 KHz, fV 39.8 Hz
> >
> >(and it doesn't sync at 40 Hz vertical refresh :-( ).
> >
> >This is _half_ of the normal 80 Hz. Using fbset -a "1600x1200-80" before
> >X, of after X, doesn't do anything. Does anybody know what to hack out
> >in X to get it to _not_ reset my G400 to some unusable state? 3.3.6 was
> >didn't do this. I can use the framebuffer-screen just fine, but I miss
> >the DGA extension.
> 
> Try adding this to your XF86Config file:
> 
> Section "Device"
> ...
> Option UseFBDev
> ...
> EndSection
> 
A very neat trick. X can now be ended correctly. Unfortunately, any
scrolling on any VT afterwards gives me a corrupted screen - parts of
the screen from other VT's are inserted below, or over the cursor
position, and at 'half-line' intervals. In typing this email, I've seen
it 5 times already.
I'm willing to test anything - but the corruption is alway gone after I
switch VT's. So getting a screendump is not easy.

Thanks!

Jurriaan
-- 
Send lawyers, guns, and money,
The shit has hit the fan.
        Warren Zevon
GNU/Linux 2.4.2-ac28 SMP/ReiserFS 2x1743 bogomips load av: 0.98 0.54 0.21
