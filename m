Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVLOQxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVLOQxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVLOQxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:53:00 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:45171 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750759AbVLOQw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:52:59 -0500
Date: Thu, 15 Dec 2005 17:52:55 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051215165255.GA5510@harddisk-recovery.com>
References: <20051215135812.14578.qmail@science.horizon.com> <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 08:15:49AM -0800, Linus Torvalds wrote:
> First off, the data structure is called a "semaphore", and always has 
> been. It's _never_ been called a "mutex" in the first place, and the 
> operations have been called "down()" and "up()", because I thought calling 
> them P() and V() was just too damn traditional and confusing (I don't 
> speak dutch, and even if I did, I think shortening names to that degree is 
> just evil).

Just FYI, according to Dijkstra[1] V means "verhoog" which is dutch for
"increase". P means "prolaag" which isn't a dutch word, just something
Dijkstra invented. I guess he did that because "decrease" is "verlaag"
in dutch and that would give you the confusing V() and V()
operations...

Other explanations you see in dutch CS courses are "passeer" (pass),
"probeer" (try), "vrijgave" (unlock).

I do agree that Dijkstra should have used Prolaag() and Verhoog(), but
I guess those operations wouldn't have sticked in the english CS
literature.


Erik

[1] http://www.cs.utexas.edu/users/EWD/ewd00xx/EWD74.PDF

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
