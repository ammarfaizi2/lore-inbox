Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVLCWuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVLCWuX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLCWuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:50:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:44972 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751298AbVLCWuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:50:23 -0500
X-Authenticated: #428038
Date: Sat, 3 Dec 2005 23:50:20 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203225020.GF25722@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <4391E52D.6020702@unsolicited.net> <20051203222731.GC25722@merlin.emma.line.org> <1133649261.5890.7.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133649261.5890.7.camel@mindpipe>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Dec 2005, Lee Revell wrote:

> On Sat, 2005-12-03 at 23:27 +0100, Matthias Andree wrote:
> > A kernel that calls itself stable CAN NOT remove
> > features unless they had been critically broken from the beginning. 
> 
> So in your opinion we can't add support for new hardware to a stable
> kernel either because there's a chance of breaking something that worked
> before, which brings us right back to "stable" meaning "no progress
> allowed", which begs the question of why you want to upgrade at all.

Perhaps I did not word not clearly enough, please bear with me as I'm
not a native speaker.

There's a gray area between these two extremes. I don't mind if new
drivers are added, not even if they touch other parts of the code if
these changes are thoroughly (and I mean thoroughly, not a smoke test of
the "works for me" kind) examined.

If devfs had been marked "DEPRECATED, WILL BE REMOVED FROM 2.6.0", all
would have been fine. (I don't recall the exact version, 2.6.12? It
wasn't known beforehand), I certainly do not expect new drivers that are
added to support it.

First step, make a note "this driver has been added in Linux 2.6.14" so
that everyone is aware the driver doesn't need to support devfs as that
one was already deprecated then the driver moved in. Even better, mark
which deprecated subsystems are unsupported by the driver.

Second, schedule for removal such subsystems well ahead of time, for
instance, "DEPRECATED, WILL BE REMOVED JUST BEFORE 2.8.0", and only use
minor releases to that extent.

The point is, removing something that has worked well enough that some
people had a reason to use it, is not "stable".

Third, IF udev is so sexy but OTOH a real kernel-space devfs can be done
in 200 LoC as has been claimed so often, why in hell is this not
happening? Switch "broken bloaty bulky devfs" to "lean & clean devfs"?
This ship would have been flying the "clean-up nation" flags.

-- 
Matthias Andree
