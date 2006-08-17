Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWHQWOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWHQWOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWHQWOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:14:09 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:7808 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964824AbWHQWOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:14:08 -0400
Date: Fri, 18 Aug 2006 00:10:52 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 Spurious ACK/NAK on isa0060/serio0, 2.6.18-rc2 is fine
Message-ID: <20060817221052.GA3025@aitel.hist.no>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I tried 2.6.18-rc4-mm1 on my opteron. (Running 64-bit)

The kernel did not boot, but went into an infinite loop of

Spurious ACK on isa0060/serio0
over and over.  I have two keyboards, one attached the usual
way and another attached where a mouse usually goes.
This works fine with 2.6.18-rc2, but no longer now.
One keyboard is dead, and on the other, two of the
leds blink on and off.

Unplugging a keyboard changes the repeating message to
Spurious NAK ... instead.

Unplugging both keyboards stops the nonsense, but then - no keyboard.

This kernel also fails to mount root, a fact that is hard to see as
the stupid messages quickly scroll everything else away.
That might be something simple like the changed ATA config
or multithreaded pci probe.

There just cannot be any program "trying to access hw directly",
I don't get the root fs so I don't even have init running.

Helge Hafting
