Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263532AbTC3KIw>; Sun, 30 Mar 2003 05:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263533AbTC3KIw>; Sun, 30 Mar 2003 05:08:52 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:45702 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263532AbTC3KIv>; Sun, 30 Mar 2003 05:08:51 -0500
Subject: Re: 3c59x gives HWaddr FF:FF:...
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Thomas Backlund <tmb@iki.fi>, "J.A. Magallon" <jamagallon@able.es>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <86y92xh9wt.fsf@trasno.mitica>
References: <20030328145159.GA4265@werewolf.able.es>
	 <20030328124832.44243f83.akpm@digeo.com>
	 <20030328230510.GA5124@werewolf.able.es>
	 <20030328151624.67a3c8c5.akpm@digeo.com>
	 <20030329004630.GA2480@werewolf.able.es>
	 <0d0001c2f616$6a678dc0$9b1810ac@xpgf4>  <86y92xh9wt.fsf@trasno.mitica>
Content-Type: text/plain
Organization: 
Message-Id: <1049019577.597.6.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 30 Mar 2003 12:19:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-30 at 04:21, Juan Quintela wrote:
> In my experience, that bug is related with acpi.  In a kernel compiled
> without acpi, the card works perfectly, in a kernel compiled with acpi
> it depend on the phase of the moon and similar things :(

I'm not using ACPI but APM and, on a vanilla 2.4.20 kernel, that's what
I'm seeing with my 3CCFE575CT on my kernel dmesg ring:

<snip>
Yenta IRQ list 08d8, PCI irq5
Socket status: 30000020
Yenta IRQ list 08d8, PCI irq10
Socket status: 30000006
cs: cb_alloc(bus 6): vendor 0x10b7, device 0x5257
PCI: Failed to allocate resource 0(1000-2c3) for 06:00.0
PCI: Enabling device 06:00.0 (0000 -> 0003)
<snip>
eth0: command 0x5800 did not complete! Status=0xffff
eth0: command 0x2804 did not complete! Status=0xffff
<snip>

However, Alan Cox patches for 2.4.20 and Red Hat's linux kernel both
seem to work OK... I think it's related to PCI resource assignment.

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

