Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752710AbWKBH3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbWKBH3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbWKBH3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:29:37 -0500
Received: from www.osadl.org ([213.239.205.134]:15027 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1752710AbWKBH3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:29:36 -0500
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required)
	[2.6.18-rc4-mm1]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20061102001838.GA911@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
	 <1162417916.15900.271.camel@localhost.localdomain>
	 <20061102001838.GA911@rhlx01.hs-esslingen.de>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 08:31:16 +0100
Message-Id: <1162452676.15900.287.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 01:18 +0100, Andreas Mohr wrote:
> You applied a nice lameness filter, by secretly making sure that -dyntick1
> is unavailable and a new -dyntick2 took its place, right? ;)

:)

> It seems we have C2 APIC issues here, from a cursory glance at the log...

Yes, it stops in C2. Probably I was a bit over optimistic with the
detection. Well it detects it, but not without help from the keyboard
operator :(

> Note that it stalls directly after the
> input: AT Translated Set 2 keyboard as /class/input/input0
> line (from that point on it needs additional "support" via keyboard press).

Does it resume normal operation after the "ACPI: lapic on CPU 0 stops in
C2[C2]" message ?

It is easy to fix by marking all AMDs broken again, but I really want to
avoid this.

	tglx


