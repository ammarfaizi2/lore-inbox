Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966238AbWKNSEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966238AbWKNSEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966240AbWKNSEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:04:23 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:9910 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S966238AbWKNSEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:04:23 -0500
Date: Tue, 14 Nov 2006 19:04:21 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061114180421.GA1910@rhlx01.hs-esslingen.de>
References: <EB12A50964762B4D8111D55B764A8454E0DBDE@scsmsx413.amr.corp.intel.com> <20061114173054.GA27092@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114173054.GA27092@rhlx01.hs-esslingen.de>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 06:30:54PM +0100, Andreas Mohr wrote:
> Hmm, hopefully it's easy to research where to enable HPET
> (if there is one at all!) on an el-cheapo VIA chipset...

http://forum.insanelymac.com/index.php?showtopic=31399&pid=219051&st=0&#entry219051
"The VIA VT8237 chipset also support HPET."

And this is confirmed by:

http://www.nabble.com/-PATCH--HPET:-do-not-use-64-bit-reads-t2500136.html
"However, there is no guarantee that the timer actually has 64 bits, the
specification only recommends it.  My x86-64 system has a 32-bit timer
(AMD64 with a VT8237 southbridge). "

Hmm, and I'm afraid I have a VT8235 only which possibly doesn't have HPET :-P

A relatively detailed (covers Windows XP timer details) HPET etc.
x86 timers discussion is at
"[Comp-arch] x86 High Precision Event Timers support"
https://www.gelato.unsw.edu.au/archives/comp-arch/2006-June/001320.html

Andreas Mohr
