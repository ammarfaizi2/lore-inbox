Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTL3TkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTL3TkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:40:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21007 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263370AbTL3TkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:40:07 -0500
Date: Tue, 30 Dec 2003 19:40:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Message-ID: <20031230194003.E13556@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
References: <20031005171055.A21478@flint.arm.linux.org.uk> <20031228174622.A20278@flint.arm.linux.org.uk> <20031228182545.B20278@flint.arm.linux.org.uk> <Pine.LNX.4.58.0312281248190.11299@home.osdl.org> <20031230114324.A1632@flint.arm.linux.org.uk> <20031230165042.B13556@flint.arm.linux.org.uk> <20031230181741.D13556@flint.arm.linux.org.uk> <Pine.LNX.4.58.0312301045170.2065@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0312301045170.2065@home.osdl.org>; from torvalds@osdl.org on Tue, Dec 30, 2003 at 10:47:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 10:47:10AM -0800, Linus Torvalds wrote:
> On Tue, 30 Dec 2003, Russell King wrote:
> > 
> > - i8042_noaux=1 - this doesn't seem to make any difference, although
> >   this does appear to leave the CTR set as 0x65, which appears to be
> >   the BIOS-set value.
> 
> Doesn't that leave the kbd mask the same? In particular, it still sets the 
> "disable" bit, aka I8042_CTR_KBDDIS later on..

Seems to.  With noaux unset, CTR is set to 0x47.

> What happens if you just define I8042_CTR_KBDDIS to zero?

That still causes suspend to fail.  I've separately tested I8042_CTR_KBDINT
set to zero as well, and that still causes failure.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
