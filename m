Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWH1Rkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWH1Rkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWH1Rkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:40:36 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:14825
	"EHLO sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S1751088AbWH1Rkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:40:35 -0400
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux@horizon.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Serial custom speed deprecated?
From: Michael Poole <mdpoole@troilus.org>
Date: Mon, 28 Aug 2006 13:40:35 -0400
In-Reply-To: <Pine.LNX.4.61.0608281248420.683@chaos.analogic.com> (linux-os@analogic.com's message of "Mon, 28 Aug 2006 12:57:03 -0400")
Message-ID: <87hczwkbcc.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
References: <20060826181639.6545.qmail@science.horizon.com>
	<Pine.LNX.4.61.0608280817030.32531@chaos.analogic.com>
	<1156775994.6271.28.camel@localhost.localdomain>
	<Pine.LNX.4.61.0608281047360.388@chaos.analogic.com>
	<87lkp8kgdv.fsf@graviton.dyn.troilus.org>
	<Pine.LNX.4.61.0608281248420.683@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os \(Dick Johnson\) writes:

> On Mon, 28 Aug 2006, Michael Poole wrote:
>
>> What baud rate does your system define CBAUDEX | B0 to be?  On my
>
> B0 is 0 (zero), no bits. If you are trying to play semantic games and
> claim B0 is 1, i.e., bit 0, then it would not be written as B0, it
> would be written as B(0) or B:0. B0 is defined to be the baud-rate
> used to hang up the modem. It is zero in all bits on most all
> implementations including my Sun. On most recent Linux distributions,
> CBAUDEX is (octal) 0010000. Since B0 is zero, ORing it into CBAUDEX
> does nothing.

Thanks, Sherlock!  Again: What does CBAUDEX, by itself, do on your
system?  As Alan Cox obviously thought the rest of the world was
bright enough to notice, and as I tried to explain, the CBAUDEX bit is
currently not defined when set by itself (i.e. as if it were CBAUDEX,
CBAUDEX | B0, CBAUDEX << 0 or however else you want to denote it);
there is always some other low-order (CBAUD) bit associated with it:

>> AMD64 machine, both the x86-64 and i386 asm/termbits.h files skip
>> CBAUDEX -- B38400 is 0000017 and B57600 is 0010001 (CBAUDEX | B50).
>> The headers do not define any baud rate between those two, either by
>> rate or by c_cflag value.

Michael Poole
