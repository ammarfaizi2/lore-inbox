Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263621AbTCUOFZ>; Fri, 21 Mar 2003 09:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263622AbTCUOFZ>; Fri, 21 Mar 2003 09:05:25 -0500
Received: from bitmover.com ([192.132.92.2]:42155 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263621AbTCUOFY>;
	Fri, 21 Mar 2003 09:05:24 -0500
Date: Fri, 21 Mar 2003 06:16:20 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Roman Zippel <zippel@linux-m68k.org>,
       Nicolas Pitre <nico@cam.org>, Ben Collins <bcollins@debian.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030321141620.GA25142@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
	Roman Zippel <zippel@linux-m68k.org>, Nicolas Pitre <nico@cam.org>,
	Ben Collins <bcollins@debian.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home> <Pine.LNX.4.44.0303162014090.12110-100000@serv> <20030316215219.GX1252@dualathlon.random> <20030317215639.GG15658@atrey.karlin.mff.cuni.cz> <20030317220830.GM1324@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317220830.GM1324@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 11:08:30PM +0100, Andrea Arcangeli wrote:
> > Actually, fact that "longest path" algorithm may well choose
> > non-mainline branch because it likes it more worries me a bit.
> 
> AFIK it's supposed to be the "longest path" of Linus's and Marcelo's
> branches which means it'll reproduce all the modifcations of the
> mainline trees only.

By the way, we've been incrementally updating both trees and while in 
theory the incremental could result in shorter paths with less detail,
so far the incremental export and the one pass export result in exactly
the same path:

    slovax $ bk _eventpath 1.0 + | wc -l
       8498
    slovax $ cd ../linux-2.5-cvs/linux-2.5
    slovax $ rlog -r -N ChangeSet | grep revision
    revision 1.8498

I've actually reimported the data in one pass and diffed the RCS files,
it's the same.

HPA, should we be mirroring the CVS tarballs to kernel.org?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
