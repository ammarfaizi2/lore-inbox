Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUFSTa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUFSTa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 15:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUFSTa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 15:30:57 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:29702 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262328AbUFSTaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 15:30:52 -0400
Date: Sat, 19 Jun 2004 21:30:53 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Matroxfb in 2.6 still doesn't work in 2.6.7
Message-ID: <20040619193053.GA3644@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040618211031.GA4048@irc.pl> <20040619190503.GB17053@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619190503.GB17053@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 09:05:03PM +0200, Petr Vandrovec wrote:
> > My LCD monitor turns black and slowly change into all white.
> > There is some very bright white area in lower right corner of monitor.
> 
> When monitor goes into this mode? Immediately after kernel starts, or
 
 During kernel boot, before even mounting root and running init.

> after you start X? Picture you see happens with some (stupid) monitors
> if there are missing sync pulses. 

 Samsung SyncMaster 171s doesn't look stupid to me :-) And XFree86/Xorg
somehow manages to work.

> Are you sure that you do not have any
> fbset or stty commands in your startup scripts?

 There was single 'stty onlcr'. After commenting it out nothing changed.

> What if you boot with init=/bin/bash?

 No change. Screen melts to white before bash is execed.  
 
> > % dmesg | grep -i matrox
> > matroxfb_crtc2: secondary head of fb0 was registered as fb1
> 
> It works for me, with CRT analog monitor... What if you boot with
> video=matroxfb:outputs:010,1280x1024-16@60 (if you plugged your LCD to analog
> output)
 
 This is how my LCD is connected. Tried that - no change, still no picture.
It doesn't work the same way as when no passing 'outputs:' to kernel, so
I presume 'output:010' is default.  

> or video=matroxfb:outputs:100,1280x1024-16@60 (if you plugged your LCD to
> digital output with digital-analog connector convertor) ?

 With LCD still connected to analog output and outputs:100, LCD turns 
itself off during kernel boot.
 
> You can also try patching your kernel with 
> http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/matrox-2.6.7-rc2-c1818.gz. It
> should help you if videomode is destroyed by your initscripts.

 My initscripts don't mess with videomode, but I will check this patch.

-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station 
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray 

