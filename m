Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130874AbQJIWnl>; Mon, 9 Oct 2000 18:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S130865AbQJIWnc>; Mon, 9 Oct 2000 18:43:32 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16394 "EHLO neon-gw.transmeta.com") by vger.kernel.org with ESMTP id <S129090AbQJIWnX>; Mon, 9 Oct 2000 18:43:23 -0400
Date: Mon, 9 Oct 2000 15:28:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test10-pre1
Message-ID: <Pine.LNX.4.10.10010091526450.1090-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Largely VM balancing and OOM things (get rid of the VM livelock that
existed in test9), and USB fixes.

And a number of random driver fixes (SMP locking on network drivers, what 
not).

		Linus

-----

 - pre1:
    - Roger Larsson: ">=" instead of ">" to make the VM not get stuck.
    - Gideon Glass: brw_kiovec() failure case oops fix
    - Rik van Riel: better memory balancing and OOM killer
    - Ivan Kokshaysky: alpha compile fixes
    - Vojtech Pavlik: forgotten ENOUGH macro in via82cxxx ide driver
    - Arnaldo Carvalho de Melo: acpi resource leak fix
    - Brian Gerst: use mov's instead of xchg in kernel trap entry
    - Torben Mathiasen: tlan timer being added twice bug
    - Andrzej Krzysztofowicz: config file fixes
    - Jean Tourrilhes: Wavelan lockup on SMP fix
    - Roman Zippel: initdata must be initialized (even if it is to zero:
      gcc is strange)
    - Jean Tourrilhes: hp100 driver lockup at startup on SMP
    - Russell King: fix silly minixfs uninitialized error bug
    - (various): fix uid hashing to use "uid_t" instead of "unsigned short"
    - Jaroslav Kysela: isapnp timeout fix. NULL ptr dereference fix.
    - Alain Knaff: fdformat should work again.
    - Randy Dunlap: USB - fix bluetooth, acm, printer, serial to work
      with urb->dev changes. 
    - Randy Dunlap: USB whiteheat serial driver firmware update.
    - Randy Dunlap: USB hub memory corruption and pegasus driver update
    - Andre Hedrick: IDE Makefile cleanup

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
