Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUFSUj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUFSUj5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUFSUj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:39:57 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:29575 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263088AbUFSUjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:39:55 -0400
Date: Sat, 19 Jun 2004 22:39:54 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: zdzichu@irc.pl
Subject: Re: Matroxfb in 2.6 still doesn't work in 2.6.7
Message-ID: <20040619203954.GC17053@vana.vc.cvut.cz>
References: <20040618211031.GA4048@irc.pl> <20040619190503.GB17053@vana.vc.cvut.cz> <20040619193053.GA3644@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619193053.GA3644@irc.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 09:30:53PM +0200, Tomasz Torcz wrote:
> On Sat, Jun 19, 2004 at 09:05:03PM +0200, Petr Vandrovec wrote:
> > after you start X? Picture you see happens with some (stupid) monitors
> > if there are missing sync pulses. 
> 
>  Samsung SyncMaster 171s doesn't look stupid to me :-) And XFree86/Xorg
> somehow manages to work.

It should present you with some "hsync not supported" or something like that.
 
> > It works for me, with CRT analog monitor... What if you boot with
> > video=matroxfb:outputs:010,1280x1024-16@60 (if you plugged your LCD to analog
> > output)
>  
>  This is how my LCD is connected. Tried that - no change, still no picture.
> It doesn't work the same way as when no passing 'outputs:' to kernel, so
> I presume 'output:010' is default.  

Default is '111', so you can plug your monitor to any of available outputs.

If you want exactly same videomode as you use under X, you should use

video=matroxfb:vesa:0x11A,right:48,hslen:112,left:248,hslen:112,lower:1,vslen:3,upper:48

maybe with ',sync:3' if +hsync/+vsync are mandatory for your monitor.
								Petr Vandrovec


							

