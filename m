Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbTCWLmc>; Sun, 23 Mar 2003 06:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbTCWLmb>; Sun, 23 Mar 2003 06:42:31 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:16947 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S263031AbTCWLma>; Sun, 23 Mar 2003 06:42:30 -0500
From: Jos Hulzink <josh@stack.nl>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.5.65: 3C905 driver doesn't work.
Date: Sun, 23 Mar 2003 12:53:30 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200303211618.36485.josh@stack.nl> <20030321153704.GA3762@suse.de>
In-Reply-To: <20030321153704.GA3762@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303231253.30685.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 March 2003 16:37, Dave Jones wrote:
> On Fri, Mar 21, 2003 at 04:18:36PM +0100, Jos Hulzink wrote:
>  > 2.5.65 doesn't connect to my network via my network card:
>  >
>  > 00:0b.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
>  > [Boomerang]
>  >
>  > My switch does show a link, but the dhcpcd negotiation fails, and no
>  > activity is shown.
>  >
>  > All kernel logs look normal, no errors, card is detected correctly.
>
> try booting with..
> "acpi=off"
> "noapic"
> "acpi=off noapic"
>
> For me, the third one gets it working again on two boxes.
> Without that, packets are sent, but nothing is ever recieved.
>

Okay, this indeed works for me too.

Interesting is this:

MPS 1.4 disabled in BIOS (no irq rerouting table in memory), acpi enabled in 
kernel, apic on: 3Com module tries to claim IRQ 0, which is of course 
incorrect.

the IRQ rerouting causes trouble for my SCSI card too, I guess we're still a 
long way from usable ACPI and APIC :( If I can be of any help to test things, 
please let me know.

Jos
