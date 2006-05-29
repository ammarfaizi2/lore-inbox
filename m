Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWE2WHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWE2WHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWE2WHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:07:13 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:28807 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751418AbWE2WHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:07:11 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: James Courtier-Dutton <James@superbug.co.uk>
Subject: [BUG 6480]Re: Asus K8N-VM Motherboard Ethernet Problem
Date: Tue, 30 May 2006 00:03:38 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Marc Perkel <marc@perkel.com>,
       bugme@bugzilla.kernel.org, netdev@vger.kernel.org, aabdulla@nvidia.com
References: <44793100.50707@perkel.com> <20060528101849.GL13513@lug-owl.de> <447B3408.1020001@superbug.co.uk>
In-Reply-To: <447B3408.1020001@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605300003.39513.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Monday, 29. May 2006 19:48, James Courtier-Dutton wrote:
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

This sounds like  http://bugzilla.kernel.org/show_bug.cgi?id=6480

Maybe we can help to resolve this. I already stored a lot of info in
the bugzilla entry.

Could you please describe your setup further? I'm interested on
the devices behind your nvidia NIC, since we only have it at one customers
mail server behind a SonicWall, so we cannot really try a lot. 

For all other customers it works. I'm a bit lost on the cause.
I've seen 4% collisions, which might reduce performance,
but should not stop the transmitter forever.

PS: CC'ed some more relevant addresses to increase awareness.

Regards

Ingo Oeser
