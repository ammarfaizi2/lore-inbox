Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTLEWmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264528AbTLEWmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:42:06 -0500
Received: from mail.netzentry.com ([157.22.10.66]:57351 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S264507AbTLEWl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:41:59 -0500
Message-ID: <3FD109B6.8080503@netzentry.com>
Date: Fri, 05 Dec 2003 14:41:58 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mfedyk@matchmail.com
CC: linux-kernel@vger.kernel.org
Subject: RE: Catching NForce2 lockup with NMI watchdog
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Everyone with this problem should turn on the nmi_watchdog, as
 >someone may
 >have the right circumstances to produce an oops where the
 >others didn't.
 >
 >I say that you're not serious about getting this fixed unless
 >you're going
 >to do all of:

To quote Allen Martin:

 >NVIDIA doesn't provide a windows driver to setup APIC interrupts.
 >
 >APIC functionality is exported through the ACPI methods and MP
 >table in the system BIOS which the motherboard vendors supply.

 >Likely the root of the problem has to do with the way the Linux
 >kernel is using the ACPI methods to setup the interrupts which
 >is different from win 9x/2k/XP.  I can help track this down,
 >unfortunately so far I've been unable to reproduce the hangs
 >on any of the boards I have.

and

 >> Do you know whether the nforce2's with apic support the timer
 >> (IRQ 0) in
 >> IO-APIC mode?  To me, it seems like a bug:
 >> "Dec  4 20:13:11 tesore kernel: ..MP-BIOS bug: 8254 timer not
 >> connected to
 >> IO-APIC"
 >> (This message originates in arch/i386/kernel/io_apic.c)
 >>
 >
 >Yes, Win 9x/2k/XP use the system timer on irq0 and have no problem.  I
 >haven't looked at this yet.
 >

Is it not possible that Linux could be made to handling this hardware
correctly?


 >
 > o turn on nmi_watchdog
 > o try the patches posted[1]
 > o contact nvidia or your motherboard manufacturer saying you
 >need linux
 >   support, and return the board if they don't. (phone, fax,
 >email, or even
 >   local office if there is one)
 >
 >I bought a VIA board to avoid the problems I expected from the
 >nforce, and I
 >needed a system (server) that would *work* now.
 >
 >[1] If you're worried about your file system, just boot the
 >patched kernel in
 >single mode, and that will mount all of your file systems
 >read-only so there
 >will be little chance of corruption.
 >
 >Mike

