Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270811AbTGVMk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTGVMk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:40:28 -0400
Received: from dhcp169.linuxsymposium.org ([209.151.19.169]:16000 "EHLO gaston")
	by vger.kernel.org with ESMTP id S270811AbTGVMkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:40:24 -0400
Subject: Re: Radeon in LK 2.4.21pre7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Cc: ajoshi@kernel.crashing.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1058679793.10948.47.camel@ktkhome>
References: <1058679793.10948.47.camel@ktkhome>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058878512.532.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 22 Jul 2003 14:55:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-20 at 07:43, Kristofer T. Karas wrote:
> Ben, Ani, et al,
> 
> Just tried Linux kernels 2.4.21pre6 and pre7 with my Radeon 8500LEE and
> have had some dreadful corruption problems related to pixel clearing
> during scroll and ypan.  This is probably old news to you; so <aol>me
> too</aol>.  I first noticed this in the -ac kernels, but a variant is
> now in mainline -pre.
> 
> Problem #1:  When scrolling, radeonfb fails to erase the portion of the
> screen at the bottom, leaving all sorts of random pixels in the bottom
> line.  Further scrolling propagates these pixels upwards.
> See http://enterprise.bidmc.harvard.edu/~ktk/temp/radeonfb/screen-1.jpg
> (Sorry for camera-shake; hand-held in dim room...)

This looks like erase not working properly... This usually happens
after switching back from X as X tends to leave some garbage in some
engine registers, and is usually cured by switching to another console
(this is why I tend to force-reinit the accel engine on console switch).

Since your problem seem to not depend on XFree, I suspect something
else hairy is going on with the engine, I don't know what yet though,
I'll try to find some clue.

In the meantime, can you send me a dmesg output ?

Thanks,
Ben.

