Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131583AbRCQKzg>; Sat, 17 Mar 2001 05:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131584AbRCQKz0>; Sat, 17 Mar 2001 05:55:26 -0500
Received: from www.wen-online.de ([212.223.88.39]:6161 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131583AbRCQKzO>;
	Sat, 17 Mar 2001 05:55:14 -0500
Date: Sat, 17 Mar 2001 11:54:34 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Bernd Eckenfels <W1012@lina.inka.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root & linuxrc problem
In-Reply-To: <E14e3if-0002od-00@sites.inka.de>
Message-ID: <Pine.LNX.4.33.0103171129340.2961-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2001, Bernd Eckenfels wrote:

> In article <Pine.LNX.4.33.0103160822350.1057-100000@mikeg.weiden.de> you wrote:
> > Aha.. so that's it.  I've never been able to get /linuxrc to execute
> > automagically.  I wonder why /linuxrc executes on Art's system, but
> > not on mine.  I can call it whatever I want and it doesn't run unless
> > I explicitly start it with init=whatever.
>
> linuxrc is executed iff:
>
> CONFIG_BLK_DEV_INITRD is defined
> you actually have a initrd mounted
> /dev/console can be found and opened
> a executable "/linuxrc" is in the ramdisk

<g> There's one more important condition to add to this iff list.

ROOT_DEV as set at kbuild or boot time may not be identical with
the device used as a container for the initrd image.

Greetings from bash.  My pid is 8
  PID TTY STAT TIME COMMAND
    1  ?  SW   0:05 (swapper)
    2  ?  SW   0:00 (keventd)
    3  ?  SW   0:00 (kapm-idled)
    4  ?  SW   0:00 (kswapd)
    5  ?  SW   0:00 (kreclaimd)
    6  ?  SW   0:00 (bdflush)
    7  ?  SW   0:00 (kupdate)
    8  ?  S    0:00 /bin/sh /linuxrc
   11  ?  R    0:00 /bin/ps ax
/dev/root / ext2 rw 0 0
/dev/hda5 /test ext2 rw 0 0
none /proc proc rw 0 0

