Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTGCOBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTGCOBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:01:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16648 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263281AbTGCOBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:01:08 -0400
Date: Thu, 3 Jul 2003 15:15:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Wiktor Wodecki <wodecki@gmx.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.5.74-mm1
Message-ID: <20030703151529.B20336@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Wiktor Wodecki <wodecki@gmx.de>, Andrew Morton <akpm@osdl.org>
References: <20030703023714.55d13934.akpm@osdl.org> <20030703103703.GA4266@gmx.de> <20030703120626.D15013@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030703120626.D15013@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Jul 03, 2003 at 12:06:26PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 12:06:26PM +0100, Russell King wrote:
> On Thu, Jul 03, 2003 at 12:37:03PM +0200, Wiktor Wodecki wrote:
> > On my thinkpad T20 it boots up fine, however when I insert my ne2000
> > pcmcia card it instantly freezes. No Ooops or log message at all.
> > 2.5.73-mm1 did fine.
> 
> Grr.
> 
> Can you try taking off each patch in reverse order at:
> 
> 	http://patches.arm.linux.org.uk/pcmcia/pcmcia-event-20030623-*
> 
> and seeing which one caused your problem?

Ok, Wiktor has tried removing these 6 patches, and his problem persists.
According to bk revtool, these 6 patches are the only changes which
went in for to pcmcia from .73 to .74.

If anyone else is having similar problems, they need to report them so
we can obtain more data points - I suspect some other change in some other
subsystem broke PCMCIA for Wiktor.

Wiktor - short of anyone else responding, you could try reversing each
of the nightly -bk patches from .74 to .73 and work out which set of
changes broke it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

