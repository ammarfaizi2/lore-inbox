Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTL3SrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 13:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbTL3SrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 13:47:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:8088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264830AbTL3SrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 13:47:15 -0500
Date: Tue, 30 Dec 2003 10:47:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
In-Reply-To: <20031230181741.D13556@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0312301045170.2065@home.osdl.org>
References: <20031005171055.A21478@flint.arm.linux.org.uk>
 <20031228174622.A20278@flint.arm.linux.org.uk> <20031228182545.B20278@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0312281248190.11299@home.osdl.org> <20031230114324.A1632@flint.arm.linux.org.uk>
 <20031230165042.B13556@flint.arm.linux.org.uk> <20031230181741.D13556@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Russell King wrote:
> 
> - i8042_noaux=1 - this doesn't seem to make any difference, although
>   this does appear to leave the CTR set as 0x65, which appears to be
>   the BIOS-set value.

Doesn't that leave the kbd mask the same? In particular, it still sets the 
"disable" bit, aka I8042_CTR_KBDDIS later on..

What happens if you just define I8042_CTR_KBDDIS to zero?

		Linus
