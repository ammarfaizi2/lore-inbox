Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSI0LqO>; Fri, 27 Sep 2002 07:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSI0LqO>; Fri, 27 Sep 2002 07:46:14 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:61452 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261544AbSI0LqN>;
	Fri, 27 Sep 2002 07:46:13 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020927091040.B1715@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet>
	<20020926105853.A168142@ucw.cz> <1033039991.708.6.camel@chevrolet>
	<20020926133725.A8851@ucw.cz> <1033054211.587.6.camel@chevrolet>
	<20020926185717.B27676@ucw.cz> <1033080648.593.12.camel@chevrolet> 
	<20020927091040.B1715@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Sep 2002 13:51:43 +0200
Message-Id: <1033127503.589.6.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 2002-09-27 kl. 09:10 skrev Vojtech Pavlik:
> Unfortunately the little bit of information I needed scrolled away
> already. Can you try with the other shift (right?)? That won't
> probably crash your machine, but will most likely generate an "Unknown
> scancode" message. Again, send me the log lines. This time they should
> make it in the syslog well.
Ok, the combination which freezes the computer is right SHIFT, and
pageup/down, etc. Left SHIFT works just like expected. This time I first
wrote 'cp /var/log/syslog /tmp/syslog', then 'echo cut-here >
/var/log/syslog' Left-SHIFT+PAGEUP, arrow up two times, to get the cp..,
enter. Then I edited /tmp/syslog and copied only what was after
"cut-here". So the keystrokes included here should be Left-SHIFT+PAGEUP,
ARROW-UP, ARROW-UP, ENTER. If this works like I think it should. As you
can see, it did not generate an "Unknown scancode"...

Sep 27 13:37:37 chevrolet kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [317387]
Sep 27 13:37:37 chevrolet kernel: atkbd.c: Received f0 flags 00
Sep 27 13:37:37 chevrolet kernel: atkbd.c: Received 5a flags 00
Sep 27 13:37:39 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) [319722]
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received 12 flags 00
Sep 27 13:37:39 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [319872]
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received e0 flags 00
Sep 27 13:37:39 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) [319879]
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received f0 flags 00
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received 12 flags 00
Sep 27 13:37:39 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [319882]
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received e0 flags 00
Sep 27 13:37:39 chevrolet kernel: i8042.c: 49 <- i8042 (interrupt, kbd, 1) [319885]
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received 7d flags 00
Sep 27 13:37:39 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [319948]
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received e0 flags 00
Sep 27 13:37:39 chevrolet kernel: i8042.c: c9 <- i8042 (interrupt, kbd, 1) [319955]
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received f0 flags 00
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received 7d flags 00
Sep 27 13:37:39 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [319958]
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received e0 flags 00
Sep 27 13:37:39 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) [319961]
Sep 27 13:37:39 chevrolet kernel: atkbd.c: Received 12 flags 00
Sep 27 13:37:40 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) [320061]
Sep 27 13:37:40 chevrolet kernel: atkbd.c: Received f0 flags 00
Sep 27 13:37:40 chevrolet kernel: atkbd.c: Received 12 flags 00
Sep 27 13:37:42 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [322157]
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received e0 flags 00
Sep 27 13:37:42 chevrolet kernel: i8042.c: 48 <- i8042 (interrupt, kbd, 1) [322160]
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received 75 flags 00
Sep 27 13:37:42 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [322274]
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received e0 flags 00
Sep 27 13:37:42 chevrolet kernel: i8042.c: c8 <- i8042 (interrupt, kbd, 1) [322280]
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received f0 flags 00
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received 75 flags 00
Sep 27 13:37:42 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [322649]
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received e0 flags 00
Sep 27 13:37:42 chevrolet kernel: i8042.c: 48 <- i8042 (interrupt, kbd, 1) [322653]
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received 75 flags 00
Sep 27 13:37:42 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [322756]
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received e0 flags 00
Sep 27 13:37:42 chevrolet kernel: i8042.c: c8 <- i8042 (interrupt, kbd, 1) [322762]
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received f0 flags 00
Sep 27 13:37:42 chevrolet kernel: atkbd.c: Received 75 flags 00
Sep 27 13:37:45 chevrolet kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [325706]
Sep 27 13:37:45 chevrolet kernel: atkbd.c: Received 5a flags 00

Hope this helps, even though I doubt. It's only the right-SHIFT causing troubles.

Thanks.

Best regards,
Stian Jordet

