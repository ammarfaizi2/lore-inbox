Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbTDOTvJ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTDOTvJ 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:51:09 -0400
Received: from arnold.dormnet.his.se ([193.10.185.236]:28684 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP id S264053AbTDOTvG 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 15:51:06 -0400
Date: Tue, 15 Apr 2003 22:04:37 +0200
From: Andreas Henriksson <andreas@fjortis.info>
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [FBDEV BK] Updates and fixes.
Message-ID: <20030415200437.GA13773@gem>
References: <20030414005814.6719915f.akpm@digeo.com> <Pine.LNX.4.44.0304152004350.8236-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304152004350.8236-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 08:21:43PM +0100, James Simmons wrote:
> > 	nVidia Corporation NV11 [GeForce2 MX] (rev b2)
> > 
> > this seems to work OK.  The penguins initially have a white background, then
> > the background goes black, then they go away.  Perhaps that is intentional. 
> > But it gets to a readable login prompt.
> 
> That is the stable code. As for the white background that is strange.
> 

This happens for me too (white background that goes away when there
eventually is text that hits that area and overwrites it). 
2.5.67 + extra stuff from bk + pnp + fbdev from april 11 with an Intel 8xx
integrated card.

$ lspci | grep VGA
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics Controller] (rev 02)

I also have an additional problem, the whole picture jumps slightly up
and down all the time, plus I have a thin corruptionline from side to
side that walks up and down on the screen. Like an old tv.

My lilo.conf append line looks like this:
append="video=i810fb:xres:1024,yres:768,bpp:16,hsync1:30,hsync2:82, \
vsync1:50,vsync2:75,accel"

I've tried several different modes but they all appear to give about the
same effect.

... and I'm using a TFT screen (ViewSonic ViewPanel VG181), if that
matters (not using DVI though).

At the same time I installed the 2.5 kernel I also upgraded to XFree86
4.2.1 (from 4.1, the default in debian woody) and the exact same
behaviour happened in X too (jumping slightly up and down, thin line of
corruption and I couldn't get the xvideo extension to show anything but
a blue screen in programs that used xv. [mplayer]). It all went away
when I upgraded to XFree86 4.3. Don't know if that'll help you any but I
thought it's better to mention it all.


I'll try a new kernel (with a newer fbdev patch) as soon as the dust
settles. If you want me to try out any special patch or kernel version
tell me and I'll do it as soon as I can.


Regards,
Andreas Henriksson
