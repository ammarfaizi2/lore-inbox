Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUHJJEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUHJJEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUHJJCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:02:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23315 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263725AbUHJJAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:00:37 -0400
Date: Tue, 10 Aug 2004 10:00:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040810100023.A18024@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <20040809113829.GB9793@elf.ucw.cz> <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net> <1092098630.14100.73.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1092098630.14100.73.camel@gaston>; from benh@kernel.crashing.org on Tue, Aug 10, 2004 at 10:43:50AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 10:43:50AM +1000, Benjamin Herrenschmidt wrote:
> > > Aha, so you are saying these do not need to be done in hardware order?
> > 
> > AFAICT, no.
> 
> As stated in my previous mail, I don't agree here... there are
> dependencies that cannot be dealt otherwise. USB was an example
> (ieee1394 is another), IDE is one, SCSI, i2c, whatever ... 
> 
> Of course, if we consider those "bus" drivers not to have class
> and thus not to be stopped and only the "leaf" devices to get stopped,
> that may work... I'm not sure we are not missing something there
> though...

Would a PCMCIA bridge be a "leaf" device in that definition, despite
having child devices?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
