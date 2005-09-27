Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbVI0VV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVI0VV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbVI0VV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:21:27 -0400
Received: from 75.80-203-232.nextgentel.com ([80.203.232.75]:51950 "EHLO
	lincoln.jordet.nu") by vger.kernel.org with ESMTP id S965150AbVI0VV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:21:26 -0400
Message-ID: <1127855989.4339b77537987@webmail.jordet.nu>
Date: Tue, 27 Sep 2005 23:19:49 +0200
From: Stian Jordet <liste@jordet.nu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olaf Hering <olh@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
References: <20050926184451.GB11752@suse.de> <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org> <1127831274.433956ea35992@webmail.jordet.nu> <Pine.LNX.4.58.0509270734340.3308@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509270734340.3308@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 217.8.143.72
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sitat Linus Torvalds <torvalds@osdl.org>:
> Well, looking at your messages, I bet that the appended patch works for
> you, since your irq's are all in the legacy range.
>
> It is also conceptually closer to what the code _used_ to be (it used to
> say "if we have an IO-APIC, don't do this", now it says "if this irq is
> bound to an IO-APIC, don't do this")

No dice. My irq's beyond 15 are changed. What used to be 19 became 17, 18 became
16, 17 became 18 and 16 became 19. The others are normal, and while looking at
dmesg, the fixup is still happening. While it boots, and at first glance seems
to work, it hangs hard when I try to use usb. At least the bluetooth dongle,
haven't tried with anything else, but I suppose that'd do the same.

Sorry.

Best regards,
Stian

