Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWGHKaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWGHKaz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWGHKaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:30:55 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:60423 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750902AbWGHKay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:30:54 -0400
Message-ID: <44AF895C.6070800@superbug.co.uk>
Date: Sat, 08 Jul 2006 11:30:52 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.4 (X11/20060609)
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: linux-kernel@vger.kernel.org, Marc Perkel <marc@perkel.com>
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
References: <44793100.50707@perkel.com> <44793E2B.2050100@perkel.com> <20060528101849.GL13513@lug-owl.de> <447B3408.1020001@superbug.co.uk>
In-Reply-To: <447B3408.1020001@superbug.co.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> Jan-Benedict Glaw wrote:
>> On Sat, 2006-05-27 23:07:39 -0700, Marc Perkel <marc@perkel.com> wrote:
>>> Marc Perkel wrote:
>> [forcedeth not working correctly]
>>> Also - why is it that I can load a 3 year old version of Windows XP on 
>>> this motherboad and it just work but I load a modern Linux Kernel and it 
>>> can't find the Ethernet card?
>> That is either because Windows XP is totally superior to Linux, or
>> because the vendor (NVidia in this case) wrote a Windows driver, but
>> they didn't write something for Linux _and_ didn't publish any specs
>> for this ethernet controller.  So it took some time to reverse
>> engineer the Windows driver...
>>
>> MfG, JBG
>>
> 
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
> 
> The only help this email is, is to confirm that if someone is raising
> problems with the forcedeth driver, it is most likely to be a truthful
> report and if they also have a serial port, they might even be able to
> give some good diagnosis output.
> 
> James
> 

For those interested, I am using the forcedeth driver again in
2.6.16-ck9 kernel, and it has not caused any machine hangs so far (2 days).
