Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTCFPbx>; Thu, 6 Mar 2003 10:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268131AbTCFPbw>; Thu, 6 Mar 2003 10:31:52 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:36306 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265667AbTCFPbv> convert rfc822-to-8bit; Thu, 6 Mar 2003 10:31:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Ed Sweetman <ed.sweetman@wmich.edu>, Corvus Corax <corvusvcorax@gemia.de>
Subject: Re: Linux vs Windows temperature anomaly
Date: Thu, 6 Mar 2003 09:41:37 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz> <20030306091830.5a230e2d.corvusvcorax@gemia.de> <3E670D9E.6060604@wmich.edu>
In-Reply-To: <3E670D9E.6060604@wmich.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303060941.37642.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 March 2003 02:58 am, Ed Sweetman wrote:
snip
> i know for a fact my abit athlon motherboard's bus chip doesn't change
> temperature due to load in the system.  The only time it fluctuates is
> when the temperature of the room changes and that change is not due to
> the chip (unless i got no air circulation in the room then the computer
> as a whole will heat up all the air and that feeds back on itself)

Only because you are removing the heat as fast as it is being generated.

Which speaks for a good motherboard, heat sink, and fan combination,
along with decent AC for the room.

Additional heat generation with the use of Linux has been documented
going back to the 486 days, when problems were traced to an insufficient
heat sink. (system works with windows, crashes with Linux... replaced heat
sink and all is well).

The entire thread has been about a burst of activity that causes a thermal
spike in one or two possible locations not in the CPU. The internal
ambient temperature takes at least 3-5 seconds to change before the
sensor can report it. If the chip is already operating just below it's 
critical temperature (and that varies among chips, even in the same lot)
then it will work with windows.

Linux has a much higher demand on the hardware, partially due to the
ability to generate DMA requests faster. This adds extra heat to the
bridges, and COULD push the chip over the critical temperature for
brief times (I would guess it would be in the millisecond range). Sustained
DMA activity would be a suspect in something like this.

It would be an interesting research topic to put high precision sensors
on all of the important chips on a motherboard (say between the chip and
heat sink) and come up with a time sequence and thermal map of a
collection of motherboards....

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
