Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135904AbREFXCH>; Sun, 6 May 2001 19:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135908AbREFXB4>; Sun, 6 May 2001 19:01:56 -0400
Received: from viper.haque.net ([66.88.179.82]:6105 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S135904AbREFXBp>;
	Sun, 6 May 2001 19:01:45 -0400
Date: Sun, 6 May 2001 19:00:02 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: sri gg <srimg@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: problem when booting 2.4.2
In-Reply-To: <20010506224220.80532.qmail@web10207.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0105061855240.15951-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2001, sri gg wrote:

> Hello,
>       I recently compiled the 2.4.2 kernel on x86,
> and installed it. when booting off it, it fails to
> open the /dev/tty's and dumps the following messages..
> =========================================
> May  6 02:32:40 localhost /sbin/mingetty[786]:
> /dev/tty4: No such file or direct
> ory

I think you may have compiled in devfs support. You need to run devfsd
so it can map the old device names so programs like mingetty don't freak
out. I don't have the url handy but you can search for it on
freshmeat.net

>
> Another question which i wanted to ask was, how does
> the new kernel know where to find the new compiled
> modules in the /lib/modules directoy? I have my old
> modules in /lib/modules/2.2.16, and my new modules
> under /lib/modules/2.4.2.

The kernel will automagically look for modules in /lib/modules/<kernel
version>/. <kernel version> will be whatever the output of uname -r is
on your currently running kernel.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

