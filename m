Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265268AbUFOBnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUFOBnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 21:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUFOBnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 21:43:47 -0400
Received: from palrel13.hp.com ([156.153.255.238]:48874 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265268AbUFOBnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 21:43:45 -0400
Date: Mon, 14 Jun 2004 18:43:44 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [3/12] remove irda usage of isa_virt_to_bus()
Message-ID: <20040615014344.GA17657@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote :
> 
>  * Removed uses of isa_virt_to_bus
> This resolves Debian BTS #218878.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=218878
> 
> 	From: Paavo Hartikainen <pahartik@sci.fi>
> 	To: Debian Bug Tracking System <submit@bugs.debian.org>
> 	Subject: IrDA modules fail to load
> 	Message-Id: <E1AGYn5-0000LT-00@mufasa.vip.fi>
> 
> When trying to "modprobe irda irtty", it fails with following message:
>   FATAL: Error inserting irda (/lib/modules/2.6.0-test9/kernel/net/irda/irda.ko): \
> Unknown symbol in module, or unknown parameter (see dmesg) And in "dmesg" I see \
> these:  irda: Unknown symbol isa_virt_to_bus
>   irda: Unknown symbol isa_virt_to_bus

	Could you please send this directly to me. I hate scrubbing
large patches from the mailing list archive.
	Note that before even thinking of pushing this patch in the
kernel, we need to perform testing with the hardware on i386 and
potentially on ARM. The author only tried with irtty that doesn't use
this function, so that's not a valid test at all. Finding people test
those changes is going to be tough, as usual.
	I'm also wondering about the validity of those changes, but
that's another matter I need to go through. During 2.5.X, some people
assured me that using isa_virt_to_bus was safe on all platform with an
ISA bus...

	Thanks...

	Jean

