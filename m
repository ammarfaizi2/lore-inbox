Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTJDSDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 14:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTJDSDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 14:03:41 -0400
Received: from codepoet.org ([166.70.99.138]:45766 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S262683AbTJDSDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 14:03:40 -0400
Date: Sat, 4 Oct 2003 12:03:38 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Philippe Lochon <plochon.n0spam@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility ?
Message-ID: <20031004180338.GA24607@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Philippe Lochon <plochon.n0spam@free.fr>,
	linux-kernel@vger.kernel.org
References: <3F7EDCDD.7090500@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7EDCDD.7090500@free.fr>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Oct 04, 2003 at 04:44:45PM +0200, Philippe Lochon wrote:
> Hi,
> 
> I'm running Mandrake 9.2RC1 (kernel 2.4.22) and I can't make work S-ATA 
> boot drive and Intel Pro onboard network.
> 
> The Asus P4C800E-Dlx in the only mainboard in the P4x800 family with 
> ICH5R and Intel 82547EI (Gb onboard chip, it uses e1000 driver).
> 
> The chips share the same IRQ :
> # grep eth0 /proc/interrupts
>  17:         83   IO-APIC-level  Intel ICH5, eth0
> (note that there's no error about this in syslog)
> 
> 1) Boot on S-ATA drive / Mandrake 9.2RC1 with "acpi=off"
> -> boot OK, but no ping, "NETDEV WATCHDOG: eth0: transmit timed out" in 
> syslog.
> (full log and config on http://plochon.free.fr/mdk92RC1.html )
> 
> 2) Boot on S-ATA drive / Mandrake 9.2RC1 with "acpi=off" and "noapic"
> -> boot hang (when displays "hde: attached ide_disk driver" where hde is 
> the S-ATA boot drive)

I have an Asus P4P800 and I see the same thing.  I have to enter
the BIOS and set IDE to Compatible mode, even with the latest
libata.  Dunno why, but with the ICH5 in native mode it simply
won't boot.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
