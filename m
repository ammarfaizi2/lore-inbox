Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265404AbTGCVjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265406AbTGCVjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 17:39:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64527 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265404AbTGCVjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 17:39:14 -0400
Date: Thu, 3 Jul 2003 22:53:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Johoho <johoho@hojo-net.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030703225338.F20336@flint.arm.linux.org.uk>
Mail-Followup-To: Johoho <johoho@hojo-net.de>, linux-kernel@vger.kernel.org
References: <20030703023714.55d13934.akpm@osdl.org> <20030703103703.GA4266@gmx.de> <20030703120626.D15013@flint.arm.linux.org.uk> <20030703151529.B20336@flint.arm.linux.org.uk> <20030703214921.GM4266@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030703214921.GM4266@gmx.de>; from wodecki@gmx.de on Thu, Jul 03, 2003 at 11:49:21PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 11:49:21PM +0200, Wiktor Wodecki wrote:
> On Thu, Jul 03, 2003 at 03:15:29PM +0100, Russell King wrote:
> > Ok, Wiktor has tried removing these 6 patches, and his problem persists.
> > According to bk revtool, these 6 patches are the only changes which
> > went in for to pcmcia from .73 to .74.
> > 
> > If anyone else is having similar problems, they need to report them so
> > we can obtain more data points - I suspect some other change in some other
> > subsystem broke PCMCIA for Wiktor.
> > 
> > Wiktor - short of anyone else responding, you could try reversing each
> > of the nightly -bk patches from .74 to .73 and work out which set of
> > changes broke it.
> 
> it broke with the 2.5.73-rc2 patch. I assume it was:
> 
> ChangeSet@1.1348.20.5, 2003-06-23 23:52:55+01:00,
> rmk@flint.arm.linux.org.uk
>   [SERIAL] 8250_cs update - incorporate pcmcia-cs 3.1.34 serial_cs fixes

-rc2 or -bk2?

Hmm.  That's actually the 3rd of a set of 3 csets which only touch
8250_cs.c.  If you aren't using a card with a serial port built in
(eg, modem) then these csets shouldn't make any difference to you.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

