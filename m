Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129514AbQLAKV7>; Fri, 1 Dec 2000 05:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQLAKVt>; Fri, 1 Dec 2000 05:21:49 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:20355 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129514AbQLAKVj>;
	Fri, 1 Dec 2000 05:21:39 -0500
Message-ID: <20001201175109.A4209@saw.sw.com.sg>
Date: Fri, 1 Dec 2000 17:51:09 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <20001117172336.B27444@saw.sw.com.sg> <3A269F47.17336A69@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <3A269F47.17336A69@Hell.WH8.TU-Dresden.De>; from "Udo A. Steinberg" on Thu, Nov 30, 2000 at 07:41:11PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 30, 2000 at 07:41:11PM +0100, Udo A. Steinberg wrote:
> I've been using an older EEPro100/B card until now and it's been working without any
> problems ever since the transmitter bugs were fixed. The boot output looked like this:
[snip]
> Today I've installed a new model with Wake-on-LAN support and got caught by
> above mentioned
> 
> eth0: card reports no RX buffers.
> eth0: card reports no resources.
> 
> messages as well. Strangely those messages only ever happen during bootup and
> *every* time. Shutting eth0 down and bringing it back up fixes the problem.

It's a known issue.
I've been promised that this issue would be looked up in Intel's errata by
people who had the access to it, but I haven't got the results yet.

> What puzzles me a bit is that the newer card (721383-xxx) is an 82559 chip,
> according to the Intel site, but the boot output doesn't say so:
[snip]

The card itself doesn't report its revision in details.
It can be checked by `lspci'.
Rev 8 is 82559, if I remember, and rev 9 is 82559ER.

> If you have any patches or tests that would help to find and fix this init
> bug, I'd offer to test them out, since I can reliably reproduce the problem.

Sorry, no patches so far...
I may suggest only workarounds that reduces the likelihood of the fails.

Best regards
		Andrey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
