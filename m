Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTLPBm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 20:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTLPBm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 20:42:57 -0500
Received: from mxsf06.cluster1.charter.net ([209.225.28.206]:774 "EHLO
	mxsf06.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264283AbTLPBmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 20:42:55 -0500
Date: Mon, 15 Dec 2003 20:40:48 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031216014048.GA22988@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200312152354.32777.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312152354.32777.ross@datscreative.com.au>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-wli-2 i686
X-Uptime: 20:25:54 up 18:34,  4 users,  load average: 1.72, 1.17, 1.06
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Mon, Dec 15, 2003 at 11:54:32PM +1000, Ross Dickson wrote:
> <snip>
> 
> Out of curiosity of the 10 lines with predelay count like follows
> 
> ..APIC TIMER ack delay, predelay count: 20769 
> 
> Do any of them exceed your safe count of 20779? and any really close
> in value to the reload count of 20791?
> 

I have an Asus A7N8X deluxe rev. 2, so no BIOS updates. I am running
2.6.0-test11-wli-2 with your(Ross Dickson) two patches that I diffed
for 2.6.  Default delay times, 19hrs uptime, grep tested.

..APIC TIMER ack delay, reload:25053, safe:25038
..APIC TIMER ack delay, predelay count:24988 
..APIC TIMER ack delay, predelay count:24954 
..APIC TIMER ack delay, predelay count:25011 
..APIC TIMER ack delay, predelay count:24970 
..APIC TIMER ack delay, predelay count:25032 
..APIC TIMER ack delay, predelay count:24991 
..APIC TIMER ack delay, predelay count:24949 
..APIC TIMER ack delay, predelay count:25013 
..APIC TIMER ack delay, predelay count:24971 
..APIC TIMER ack delay, predelay count:24928 

> On our pheonix bios's we regularly see 2 or 3 of them exceed the safe count
> (indication of potential lockup without the patch) often with one of them 
> within 4 counts of the reload value (really quick).
> 
> Can you also advise if your bios setting of the  "C1 disconnect" is set to on, off,
> or auto? - trying to gain a clue as to how award can have disconnect running
> and avoid lockups.
> 

athcool version 0.3.1

nVIDIA nForce2 (10de 01e0) found
'Halt Disconnect and Stop Grant Disconnect' bit is enabled.

> Also are you running with DDR333 or DDR400 ram and how many sticks?
> 

1 stick, DDR400 Corsair, 5-2-2-2

> I have heard lockups are not supposed to happen at all if the fsb (host bus
> clock speed) matches the ddr speed. One of my systems went about 4 hours
> (xp2500 333fsb, DDR333) without the apic delay patch on a pheonix bios
> before lockup.
> 
I run sync memory timings and have seen pretty good uptimes without
the patches.

> So far it appears to be safe with a barton core cpu to read the local apic
> timer count register as the v2 apic delay patch does. 
> 

I am running the barton core here, so far so good it seems.  Time will
only tell I guess.  We are getting in the right direction I hope.

> So far I cannot use my v2 apic delay patch for long periods with my throughbred
> core XP2200 without hard lockups (pheonix bios, fsb266, DDR400 ram).
> 
> Regards
> Ross.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
