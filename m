Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270639AbUJUCIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270639AbUJUCIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270729AbUJUCDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 22:03:51 -0400
Received: from mx3.sover.net ([209.198.87.173]:2251 "EHLO mx3.sover.net")
	by vger.kernel.org with ESMTP id S270639AbUJUCAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:00:16 -0400
Message-ID: <4177185A.9080708@sover.net>
Date: Wed, 20 Oct 2004 22:00:58 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com>	 <9e4733910410201808c0796c8@mail.gmail.com> <9e473391041020181150638b4@mail.gmail.com>
In-Reply-To: <9e473391041020181150638b4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

>Another thought, TV out is important in the embedded market. Think
>about Tivo/MythTV/set top boxes.
>
OK - so the answer seems to be "if it does the right things, then it may 
sell"  It's hard to sell a card that doesn't do good 3D these days (re: 
Matrox Parhelia).  Speaking of the parhelia, I would look at that 
feature set as a starting point.  10-bit color, multiscreen accelerated 
3D, dual DVI, gamma corrected glyph antialiasing, etc.

So, let's try to figure out the right feature set.  (that is what was 
originally asked for, after all)

Looking at 2D, I would definitely want to see: (some taken from other 
emails on the subject)
alpha blending
antialiasing (related to alpha blending)
bitblt
fast primitive drawing
accelerated offscreen operations
more than 8 bits/color channel
video output - preferably with independent scale / refresh (ie, clone 
the 100Hz 1600x1200 monitor on a 648x480 60 Hz NTSC monitor)
video decoding acceleration (possibly some encoding functions as well)
bitmap scaling (think of font sizing and the like)
2D rotation
possibly 2.5D rotation - ie, the perspective "twist" of a plane image 
into 3D space (like Sun's Looking Glass environment)

I would think that a chip that has a lot of simple functions, but 
requires the OS to put them together to actually do something, would be 
great.  This would be the UNIX mentality brought to hardware: lots of 
small components that get strung together in ways their creator(s) never 
imagined.  If there can be a programmable side as well (other than 
re-burning the FPGA), that would be great.

I guess I would look at this as an opportunity to make a "visual 
coprocessor", that also has the hardware necessary to output to a 
monitor (preferably multiple monitors).

- Steve

