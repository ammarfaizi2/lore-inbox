Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292795AbSCDT2K>; Mon, 4 Mar 2002 14:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292811AbSCDT2B>; Mon, 4 Mar 2002 14:28:01 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:40458 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S292795AbSCDT1o>;
	Mon, 4 Mar 2002 14:27:44 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Norbert Tretkowski <tretkowski@bzimage.de>
Date: Mon, 4 Mar 2002 20:26:48 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Matrox Framebuffer with 2.4.18-ac2 and -ac3 (was: Linux
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <137E1553179C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Mar 02 at 19:58, Norbert Tretkowski wrote:
> drivers/video/video.o: In function `m1064_compute':
> drivers/video/video.o(.text+0xad9d): undefined reference to
> `matroxfb_g450_setclk'
> make: *** [vmlinux] Error 1

Either get matroxfb from 2.4.19-pre2 (it is newer although it may not
look at first glance; I had to remove *PMINFO* naming changes to get 
through Linus filter)... 

> Relevant part of my .config:
> 
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FB_MATROX=y
> CONFIG_FB_MATROX_MYSTIQUE=y

or set also CONFIG_FB_MATROX_G100=y (Gxx0 driver) and 
CONFIG_FB_MATROX_G450=y (G450/G550 support). Sorry for inconvience,
but I somehow got lost in all these #ifdefs.

BTW, 2.5.6-pre2 matroxfb suffers from same problem. I hope that
2.5.6-pre3 will have it fixed.
                                          Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
