Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWEaVds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWEaVds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWEaVds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:33:48 -0400
Received: from mail.tmr.com ([64.65.253.246]:3987 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S965173AbWEaVdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:33:47 -0400
Message-ID: <447E0C29.1030404@tmr.com>
Date: Wed, 31 May 2006 17:35:37 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>,
       Linux Kernel M/L <linux-kernel@vger.kernel.org>
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
References: <44793100.50707@perkel.com> <44793E2B.2050100@perkel.com> <20060528101849.GL13513@lug-owl.de> <447B3408.1020001@superbug.co.uk>
In-Reply-To: <447B3408.1020001@superbug.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:

> I can concur that the forcedeth is unreliable on nvidia based motherboards.
> I have a ethernet device that works with forcedeth.
> 0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
> 0000:00:0a.0 0680: 10de:0057 (rev a3)
>         Subsystem: 147b:1c12
>         Flags: 66MHz, fast devsel, IRQ 11
>         Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at fc00 [size=8]
>         Capabilities: [44] Power Management version 2
> 
> It works in that it can actually send and receive packets.
> The problems are:
> 1) one cannot rmmod the forcedeth module. Even after ifdown etc.
> 2) the machine hangs randomly.
> Before someone asks, the MB has no serial port, so no stack trace available.
> 3) The netconsole fails to function with it.
> 
> I have installed a standard PCI based intel ethernet card, and only use
> that. Without the forcedeth loaded, no hangs since.
> 
> So, although I can confirm that there are certainly problems with the
> forcedeth driver, without a serial port, I am at a loss at how I might
> help diagnose the problem and fix it.

Watchdog timer? Compile with the appropriate timer(s) and set it with 
wdog or similar. Of course it may not be "hung enough" but it's worth a 
try, I would think.
> 
> The only help this email is, is to confirm that if someone is raising
> problems with the forcedeth driver, it is most likely to be a truthful
> report and if they also have a serial port, they might even be able to
> give some good diagnosis output.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

