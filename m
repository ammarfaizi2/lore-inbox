Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbRCWP3K>; Fri, 23 Mar 2001 10:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRCWP3A>; Fri, 23 Mar 2001 10:29:00 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:24847 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131152AbRCWP2v>;
	Fri, 23 Mar 2001 10:28:51 -0500
Date: Fri, 23 Mar 2001 16:28:02 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux should better cope with power failure
To: otto.wyss@bluewin.ch, linux-kernel@vger.kernel.org
Message-id: <3ABB6B82.62293CAD@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a similar experience: 
X crashed , hosing the console , so I could not initiate
a proper shutdown.

Here I must note that the response you got on linux-kernel is
shameful.

What I did was to write a kernel/apmd patch , that performed a
proper shutdown when I press the power button ( which luckily
works as long as the kernel works ).

Ask me for details, if interested.
The patch was for 2.2.x IIRC, so I would have to rewrite it almost
from scratch.


Otto Wyss (otto.wyss@bluewin.ch) wrote :

> Lately I had an USB failure, leaving me without any access to my system 
> since I only use an USB-keyboard/-mouse. All I could do in that 
> situation was switching power off and on after a few minutes of 
> inactivity. From the impression I got during the following startup, I 
> assume Linux (2.4.2, EXT2-filesystem) is not very suited to any power 
> failiure or manually switching it off. Not even if there wasn't any 
> activity going on. 
> 
> Shouldn't a good system allways try to be on the save side? Shouldn't 
> Linux try to be more fail save? There is currently much work done in 
> getting high performance during high activity but it seems there is no 
> work done at all in getting a save system during low/no activity. I 
> think this is a major drawback and should be addressed as fast as 
> possible. Bringing a system to save state should allway have a high priority. 
> 
> How could this be accomplished: 
> 1. Flush any dirty cache pages as soon as possible. There may not be any 
> dirty cache after a certain amount of idle time. 
> 2. Keep open files in a state where it doesn't matter if they where 
> improperly closed (if possible). 
> 3. Swap may not contain anything which can't be discarded. Otherwise 
> swap has to be treated as ordinary disk space. 
> 
> These actions are not filesystem dependant. It might be that certain 
> filesystem cope better with power failiure than others but still it's 
> much better not to have errors instead to fix them. 
> 
> Don't we tell children never go close to any abyss or doesn't have 
> alpinist a saying "never go to the limits"? So why is this simple rule 
> always broken with computers? 
> 
> O. Wyss 

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
