Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA2R6i>; Mon, 29 Jan 2001 12:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbRA2R62>; Mon, 29 Jan 2001 12:58:28 -0500
Received: from smtp9.xs4all.nl ([194.109.127.135]:3018 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129101AbRA2R6Q>;
	Mon, 29 Jan 2001 12:58:16 -0500
Date: Mon, 29 Jan 2001 17:57:52 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: arobinso@nyx.net, miquels@cistron.nl
Subject: esp causing crashes..
Message-ID: <20010129175752.A657@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OS: Linux grobbebol 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[mike -- included you for refs only]

recently I started to dive into a problem that causes 2.2.x and 2.4.x to
crash at shutdown and when minicom/mgetty is used. e.g. shutdown almost
always crashed the system; if a fax is received, 3 out of 4 faxes ok,
but also crashes system.

I tried to contact the author of the hayes esp also but he seems to be
pretty busy...

Initially I thought that killall5, mike's product, somehow caused the
mentioned crash but diving deeper into it I found that killall5 tries to
kill mgetty -- and crashes the system. I tried a source version as well.
same stuff (I use suse 7.0)

I then tried without mgetty -- shutdown ok. Then I looked at esp.o as
it's being used with mgetty -- now used minicom... that crashes most
of the time when I exit the program. most of the time, it only crashes
if you reset the modem connected. 

I trouble shooted further and disconnecting the plug of the esp and at
the reconnect -- crash.

It seems that somewhere in the esp code, something causes this
particular weird crash. somehting like modem lines that get changed or
so causing the crash ? 

the IRQ is 11, not using DMA, IRQ is set to legacy in the BIOS.

it happens with any 2.2.xx version and also happens with 2.4.0.

the system's a non OC dual SMP (BP6) but it happened on the old hardware
(P5-100 w 64 MB) as well.

are there any things I could do to truble shoot this further in order to
use the esp again ?


-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
