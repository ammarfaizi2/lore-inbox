Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVH3JlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVH3JlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 05:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVH3JlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 05:41:00 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:4149 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751338AbVH3JlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 05:41:00 -0400
Date: Tue, 30 Aug 2005 11:40:58 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Sven Ladegast <sven@linux4geeks.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050830094058.GA29214@bitwizard.nl>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:53:13AM +0200, Sven Ladegast wrote:
> >A trick to use would be to send an UDP packet at boot (after 1 minute
> >or so), and then randomly say "once a month" (i.e. about 1/30 chance of
> >sending a packet on the first day) The number of these random packets
> >recieved is a measure of the number of CPU-months that the kernel
> >runs.
> 
> This could be a sloution but like you know UDP packets may or may not 
> arrive the destination address. So the packet loss with this method could 
> be very high, expecially if you send only one packet. Using a 
> TCP-connection for this is a lot more stable and the payload can be 
> encrypted too.

The "load" that an UDP packet poses on a system is much lower than
for a TCP connection. The fact that UDP packets sometimes get lost
is not much of an issue: Those packets simply wouldn't get logged.
So what?

In 90%  (my guess, 90% of statistics is made up....) of the cases 
where the first packet doesn't reach the destination, any subsequent
packets also wouldn't. So if it is so unimportant as here, why bother
with the more overhead of the TCP connection?

The "in kernel module" that might send this, could put some easily
gathered information into the packet. The goal of logging kernels-
that-get-run would then be met. Installing a userspace program is
something that most testers won't be bothered to do.

A kernel option that is clearly documented what exact info is logged
would IMHO work better. (A userspace program is technically a better
solution, the social aspect of getting a bigger user-base is the main
reason for me to suggest the in-kernel approach).

(the people who go upgrading kernels tend to be different people from
those who go installing programs for fun.)

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
