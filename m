Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263317AbREWXbS>; Wed, 23 May 2001 19:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263319AbREWXbI>; Wed, 23 May 2001 19:31:08 -0400
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:47299 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S263317AbREWXat>;
	Wed, 23 May 2001 19:30:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel freeze
In-Reply-To: <Pine.LNX.4.10.10105231215280.11617-100000@coffee.psychology.mcmaster.ca>
	<3B0BFD7F.B32695C8@bluewin.ch>
From: Jens Gecius <jens@gecius.de>
Date: 23 May 2001 19:30:47 -0400
In-Reply-To: <3B0BFD7F.B32695C8@bluewin.ch> (Stephan Brauss's message of "Wed, 23 May 2001 20:12:15 +0200")
Message-ID: <8766erwsm0.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Stephan Brauss <sbrauss@bluewin.ch> writes:

> > what do you mean by freeze?  in theory, the fact that the irq
> I cannot ping the machine anymore, no Ooops, no kernel messages, the
> attached screen is freezed (which implies that no more interrupts
> are handled, right?)

Excuse me hopping in.

I have that situation here, too. Screen frozen, no pings from the
local network, sysrq doesn't work (keyboard dead).

BUT: the other interface (internet) works just fine. When I look
in the logs afterwards, I find everything worked fine except the
following:

maniac kernel: NETDEV WATCHDOG: eth1: transmit timed out
maniac kernel: eth1: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3,
t=21.

Basically, the nic for my local lan is gone. And due to the fact, that
the box is unsuable for me (don't have another internet connection to
log in *that* remote), I have to reboot hard. Thank god there's
reiserfs ;-).

All this happened on 2.4.3 and 2.4.4 (don't excactly remember on
earlier 2.4).

I followed your suggestion regarding PCI-slots. Both my nics used to
use PCI 4 and 5 (on a gigabyte vxd7, dual 1GHz). Only the one in slot
4 had the problems. I switched the card to slot 1 and will monitor the
situation. I'll mail the list in case it doesn't change my situation.

Any other hints are welcome (other than the noapic, which didn't help).

-- 
Tschoe,                    Get my gpg-public-key here
 Jens                     http://gecius.de/gpg-key.txt
