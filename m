Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWBYSmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWBYSmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWBYSmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:42:21 -0500
Received: from gateway.peppydog.com ([66.135.132.9]:29078 "EHLO
	zaphod.andrewtv.org") by vger.kernel.org with ESMTP
	id S1161053AbWBYSmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:42:21 -0500
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Adrian Bunk" <bunk@stusta.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: OSS msnd build failure
References: <9a8748490602250824u34e664fandc56c20394367926@mail.gmail.com>
	<20060225163221.GZ3674@stusta.de>
	<9a8748490602250841q32213603l50dd4142a9a107ae@mail.gmail.com>
From: Andrew Veliath <andrewtv@usa.net>
Date: 25 Feb 2006 10:38:48 -0800
In-Reply-To: <9a8748490602250841q32213603l50dd4142a9a107ae@mail.gmail.com>
Message-ID: <m38xrz1dxj.fsf@zaphod.andrewtv.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -- yes, it is looking to compile the firmware into the kernel so
that during boot it can access it in-memory.  Despite showing it's age
as a driver, unfortunately we still probably cannot just include the
firmware for obvious reasons.  I actually have an update for this
driver that I need to get around to patching up, so this kind of
reminded me.

thanks

Andrew

 .........----------------==================----
..--==-  Sat, 25 Feb 2006 17:41:54 +0100,
..--==-  Jesper Juhl (JJ) discussed:

 JJ)  On 2/25/06, Adrian Bunk <bunk@stusta.de> wrote:
 )) On Sat, Feb 25, 2006 at 05:24:10PM +0100, Jesper Juhl wrote:
 )) 
 )) > During some build tests of 2.6.16-rc4-mm2 with  'make randconfig'  I
 )) > found this build failure :
 )) >
 )) >   ...
 )) >   LD      drivers/built-in.o
 )) >   CC      sound/sound_core.o
 )) >   CC      sound/sound_firmware.o
 )) >   CC      sound/oss/msnd.o
 )) > make[2]: *** No rule to make target `/etc/sound/msndperm.bin', needed
 )) > by `sound/oss/msndperm.c'.  Stop.
 )) > make[2]: *** Waiting for unfinished jobs....
 )) > make[1]: *** [sound/oss] Error 2
 )) > make: *** [sound] Error 2
 )) >
 )) > I must admit I don't know how to fix it, so I'll have to just report it.
 )) 
 )) That's expected if the .config contains CONFIG_STANDALONE=n
 )) 

 JJ)  Ahhh, makes perfect sense, I should have thought of that.

 JJ)  Thanks Adrian.

 JJ)  --
 JJ)  Jesper Juhl <jesper.juhl@gmail.com>
 JJ)  Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
 JJ)  Plain text mails only, please      http://www.expita.com/nomime.html

