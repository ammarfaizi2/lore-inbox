Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbSI0HFf>; Fri, 27 Sep 2002 03:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbSI0HFf>; Fri, 27 Sep 2002 03:05:35 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:26251 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261307AbSI0HFd>;
	Fri, 27 Sep 2002 03:05:33 -0400
Date: Fri, 27 Sep 2002 09:10:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse/Keyboard problems with 2.5.38
Message-ID: <20020927091040.B1715@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet> <20020926105853.A168142@ucw.cz> <1033039991.708.6.camel@chevrolet> <20020926133725.A8851@ucw.cz> <1033054211.587.6.camel@chevrolet> <20020926185717.B27676@ucw.cz> <1033080648.593.12.camel@chevrolet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1033080648.593.12.camel@chevrolet>; from liste@jordet.nu on Fri, Sep 27, 2002 at 12:50:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 12:50:40AM +0200, Stian Jordet wrote:
> tor, 2002-09-26 kl. 18:57 skrev Vojtech Pavlik:
> > Great. So, the problem is in i8042.c untranslating the keycodes. Please
> > also enable #define I8042_DEBUG_IO in drivers/input/serio/i8042.h, don't
> > start X, enable maximum console loglevel by "echo 16 16 16 16 >
> > /proc/sys/kernel/printk", and press the killing key combination.
> > (without i8042_direct, of course). Then send me the ten last or so lines
> > printed. This should allow me to fix the problem. Thanks.
> 
> Ok, I did as prescribed. I did press SHIFT+PAGEUP, and it came quite a
> lot of output, more than one page. I'm not sure if this is enough, but
> it was all I could see. When I booted, I looked in the syslog, but none
> of what I wrote off the screen was there. I guess that's because it
> froze. Ok, here come. This is writeoff, so might be some small errors.
> 
> I don't know, but I guess I must have touched the mouse to get the four
> last lines? I guess so, but I'm including them to be sure.

That's right. :)

> 
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [60519]
> atkbd.c: Received fa flags 00
> atkbd.c: Sent: 02
> i8042.c: 02 -> i8042 (kbd-data) [60519]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [60523]
> atkbd.c: Received fa flags 00
> atkbd.c: Sent: f0
> i8042.c: f0 -> i8042 (kbd-data) [60523]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [60527]
> atkbd.c: Received fa flags 00
> atkbd.c: Sent: 00
> i8042.c: 00 -> i8042 (kbd-data) [60527]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [60531]
> atkbd.c: Received fa flags 00
> i8042.c: 41 <- i8042 (interrupt, kbd, 1) [60532]
> atkbd.c: Received 02 flags 00
> input: AT Set 2 keyboard on isa0060/serio0
> i8042.c: b6 <- i8042 (interrupt, kbd, 1) [60599]
> atkbd.c: Received f0 flags 00
> atkbd.c: Received 59 flags 00
> i8042.c: 38 <- i8042 (interrupt, aux, 12) [104472]
> i8042.c: fd <- i8042 (interrupt, aux, 12) [104473]
> i8042.c: fe <- i8042 (interrupt, aux, 12) [104474]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [104475]
> 
> 
> I hope you get something out of this, I don't, for sure. The input:...
> line is the same as I get without any debug info when it locks.
> 
> Oh well, time for some schoolwork. 

Unfortunately the little bit of information I needed scrolled away
already. Can you try with the other shift (right?)? That won't
probably crash your machine, but will most likely generate an "Unknown
scancode" message. Again, send me the log lines. This time they should
make it in the syslog well.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs
