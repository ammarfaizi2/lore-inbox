Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131573AbRCSURD>; Mon, 19 Mar 2001 15:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131586AbRCSUQy>; Mon, 19 Mar 2001 15:16:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:45186 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131577AbRCSUQq>; Mon, 19 Mar 2001 15:16:46 -0500
Date: Mon, 19 Mar 2001 15:15:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Otto Wyss <otto.wyss@bluewin.ch>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
In-Reply-To: <3AB66233.B85881C7@bluewin.ch>
Message-ID: <Pine.LNX.3.95.1010319150027.9639A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2001, Otto Wyss wrote:

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

Unix and other such variants have what's called a Virtual File System
(VFS).  The idea behind this is to keep as much recently-used file stuff
in memory so that the system can be as fast as if you used a RAM disk
instead of real physical (slow) hard disks. If you can't cope with this,
use DOS. Even Windows tries to emulate Unix as far as VFS is concerned.
However Windows never reports any errors. By design, Windows keeps
trashing along until you must reinstall it because there is nothing left
of the file-system.

If you want file-system trashing errors hidden, use Windows. Unix and
its variants provide enough information in their file-systems to recover
the file-system, although not necessaily a particular file, upon startup,
if you have just switched the system off. It uses `fsck` for this.

If as you say; "bringing the system to a save state should always
have a high priority...", then mount the disks `sync`. 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


