Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTI3StS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTI3StE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 14:49:04 -0400
Received: from hibernia.jakma.org ([213.79.33.168]:20119 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261649AbTI3Ssw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 14:48:52 -0400
Date: Tue, 30 Sep 2003 19:48:22 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: kartikey bhatt <kartik_me@hotmail.com>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Can't X be elemenated?
In-Reply-To: <LAW11-F18b4SaFMwr9y00007564@hotmail.com>
Message-ID: <Pine.LNX.4.56.0309301648110.22571@fogarty.jakma.org>
References: <LAW11-F18b4SaFMwr9y00007564@hotmail.com>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003, kartikey bhatt wrote:

> 1st. X is bloat.

This isnt true.

[paul@fogarty paul]$ cat /proc/`pidof X`/status | grep ^Vm
VmSize:    47700 kB
VmLck:         0 kB
VmRSS:     22580 kB
VmData:    25540 kB
VmStk:        72 kB
VmExe:      1488 kB
VmLib:      1580 kB

X is actually quite tiny, ~3MB of exe+lib. The data size is due,
vastly, to the X /clients/ using the server (in the above case RH9
GNOME + windowmaker + xchat2 + galeon + few xterms).

Here's Xipaq (tinyX handheld X server):

~ $  cat /proc/`pidof Xipaq`/status | grep ^Vm
VmSize:     5072 kB
VmLck:         0 kB
VmRSS:      3164 kB
VmData:     1788 kB
VmStk:        16 kB
VmExe:       848 kB
VmLib:      2028 kB

That's Xipaq, exe is smaller, but libs are bigger, balances out to 
~3MB again. However, the data segment is much smaller, < 2MB compared 
to > 25MB for the desktop case. The handheld runs the GPE 
(http://gpe.handhelds.org) environment.

So perhaps you could come to the conclusion that 'X' (in the X server
sense) is not bloat, but that the /clients/ on modern desktops are?

> Though it's good for server environments. For desktop pcs it's too
> heavy. 

You are misinformed. See above.

> 2nd. It's process based client/server architecture is a bottleneck.

Why do you think so? For large amounts of data, X clients can use 
shared memory. Further, even if they must transfer data (ie 
pixmaps/pics) across the socket connection, the X server can cache 
it, and the client can use it by reference. (ie a once off cost).

Also, local X clients use unix sockets - blazingly fast.

> It's not as interactive as is supposed to be.

Have you tried 2.6.0-test6? The interactivity problems were the 
kernel's fault more than that of 'X'.

> 3rd. Most important. I can't impress or convince my
> window(crash)(TM) user friends, relatives (who saw X running on my
> pc) to use Linux.

You wont impress /anyone/ with "just X" (ie just the X server) -
cause all you'll get is a tiled background of tiny X logos and an X
mouse pointer.
 
> 4th. I want to see desktop being ruled by Linux.

"X" isnt the obstacle.

To be able to constructively criticise something you first need to 
/understand/ it. You dont.

Most of you what you complain about, bloat and heavyness, is due to
the desktop environment - not X itself. Try running GPE
(http://gpe.handhelds.org) or (easier/actually practical too for a
desktop) Xfce (http://www.xfce.org)

Finally, this isnt a kernel problem.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Real wealth can only increase.
		-- R. Buckminster Fuller
