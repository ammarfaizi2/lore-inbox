Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTLLV1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTLLV1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:27:37 -0500
Received: from tantale.fifi.org ([216.27.190.146]:31127 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262030AbTLLV0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:26:19 -0500
To: "Jeremy Kusnetz" <JKusnetz@nrtc.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 is freezing my systems hard after 24-48 hours
References: <F7F4B5EA9EBD414D8A0091E80389450569D3C9@exchange.nrtc.coop>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 12 Dec 2003 13:26:12 -0800
In-Reply-To: <F7F4B5EA9EBD414D8A0091E80389450569D3C9@exchange.nrtc.coop>
Message-ID: <871xr9budn.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeremy Kusnetz" <JKusnetz@nrtc.org> writes:

> I've read that enabling ip-chains compatibility would cause this,
> but I do not have this feature enabled at all.
> 
> I have a cluster of 8 servers all doing the same thing that I
> upgraded to a stock 2.4.23 kernel, after that period of time one
> random one will lock up hard.  No output to screen, can't sysrq or
> anything, only physically hitting the power button can get me out of
> it.  I've gotten nothing in any of my logs to give any indication on
> what's going on.
> 
> They don't seem to come when the server is under load, but more on
> how long the server has been up.  Actually I do have this kernel
> running in my development environment, but none of those machines
> have ever locked up, it seems they need some load to eventually
> cause this to happen.
> 
> I had been running 2.4.20 with no problems before the upgrade.
> 
> I haven't tried running a bk series kernel yet, in the mean time
> I've downgraded to 2.4.22 with the do_brk patch.  I haven't had this
> kernel up long enough to see if it will crash.

You're not alone... I have the same problems: 2.4.22 works, 2.4.23
locks up apparently randomly. I cannot get a backtrace with sysrq
either.

Have you tried running with the NMI watchdog? I cannot run it myself
because I have to disable APIC support since my motherboard is
buggy. To do so, try booting with "nmi_watchdog=1" or "nmi_watchdog=2"
depending on your configuration. Check Documentation/nmi_watchdog.txt
for details.  Also verify that the NMI oopser works by checking for a
non-zero NMI count in /proc/interrupts.

If only I could get a backtrace... :-)

Phil.
