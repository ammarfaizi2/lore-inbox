Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWGNHhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWGNHhw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 03:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWGNHhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 03:37:52 -0400
Received: from quasar.dynaweb.hu ([195.70.37.87]:52096 "EHLO quasar.dynaweb.hu")
	by vger.kernel.org with ESMTP id S964802AbWGNHhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 03:37:52 -0400
Date: Fri, 14 Jul 2006 09:37:49 +0200
From: Rumi Szabolcs <rumi_ml@rtfm.hu>
To: "Allen Martin" <AMartin@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon64 + Nforce4 MCE panic
Message-Id: <20060714093749.07529924.rumi_ml@rtfm.hu>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B014AD9B84@hqemmail02.nvidia.com>
References: <20060713090146.690d4759.rumi_ml@rtfm.hu>
	<DBFABB80F7FD3143A911F9E6CFD477B014AD9B84@hqemmail02.nvidia.com>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 21:30:28 -0700
"Allen Martin" <AMartin@nvidia.com> wrote:

> I'm not sure why parsemce says this is a parity error, it's a K8 virtual
> northbridge watchdog timeout on an I/O transaction.   In other words a
> CPU PIO transaction to some device timed out, the timeout is usually set
> to 10s.  Prior to K8 these types of errors would usually be system
> hardlocks.
> 
> I've debugged a few of these before and they usually end up being IDE
> device issues.  The IDE controller is really thin (the ATA registers
> actually reside in the device) so for example if the CPU goes to read
> the ATA status register of some device and the device doesn't respond,
> the PCI transaction won't be terminated and the watchdog will fire.
> 
> -Allen

Hmm, this is informative, thanks a lot!

Actually what I've g00gled about the issue so far it seems that
only Nforce4 + A64 users used to get exactly the same error, some
are indeed suggesting NF4 is buggy when it comes to IDE DMA...
Isn't it possible that this is some NF4 specific problem, a chipset
bug or a motherboard design issue (some sporadic signal distortion
problem) that is specific to some but not all NF4-based motherboards?

In fact this particular system I'm having the problem with
contains the following parts:

1x Asrock NF4G-SATA2 motherboard (http://www.asrock.com/product/939NF4G-SATA2.htm)
1x Athlon64 "Venice" 3500+ with a huge Arctic cooler
1x Corsair kit of 2 matched 512MB DDR400 modules
1x Seagate 160GB SATA drive
1x well ventilated Chieftec rackmount chassis w/PSU

The former three are brand new, none of them was ever overclocked
or otherwise tortured, the latter two are reliably working since
years. The environmental temperatures were optimal at the time the
panic occurred, so it probably was not a heat related issue. In fact
the system was rather unloaded (idling around 3AM). The uptime was
about two weeks without any problem until the panic occurred.
So I have a reason to believe that this could be a chipset specific
problem which not only affects me but quite a number of NF4 users,
most of which (using Windo$$$) will probably never know why their
system suddenly hung after some weeks or months of use...

Or maybe just a neutrino hit to the CPU?
What do you think?

Regards,

Sab
