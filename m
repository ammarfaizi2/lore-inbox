Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264295AbUD2MN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbUD2MN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264316AbUD2MN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:13:28 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:17115 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S264295AbUD2MN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:13:26 -0400
Date: Fri, 30 Apr 2004 00:12:06 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: Vanja Hrustic <vanja@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI problem with RICOH RL5C475 PCI/PCMCIA adapter, on 2.4.26
Message-ID: <816034775.1083283926@T400>
In-Reply-To: <20040428183325.2860bd95.vanja@pobox.com>
References: <20040428183325.2860bd95.vanja@pobox.com>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, 28 April 2004 6:33 p.m. +0200 Vanja Hrustic 
<vanja@pobox.com> wrote:

> I have PCI-PCMCIA adapter (Ricoh RL5C475 based) in a desktop machine.
>
> Initially, I had problems making it work, but managed to get help on
> comp.os.linux.portable. Now, most of the cards work okay.
>
> However, I still have one wireless PCMCIA card (Prism GT based) which
> doesn't work, and was advised to post the problem here.
>
> Dave (from comp.os.linux.portable) said:
>
> "This part is a tricky one.  It is a bug in the kernel's PCI resource
> allocation code.  It tries to allocate CardBus memory resources from
> whatever memory ranges happened to be allocated for the bridge device
> by the BIOS at power-up time; but in this case, those memory windows
> are too small.  There isn't a simple fix for this and I don't have a
> good suggestion for what to do about it; you can report it on the
> linux-kernel mailing list."

Ok, so I see the same thing with a Ricoh PC104+ to Cardbus adaptor on a 
little industrial PC, except I'm using an Atheros-based wireless card 
instead.  I get this with 2.4.25:

01:00.0 Class 0200: 168c:0013 (rev 01)
        Subsystem: 1186:3202
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 12
        Region 0: [virtual] Memory at d5120000 (32-bit, non-prefetchable) 
[size=
8K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


cs: cb_alloc(bus 1): vendor 0x168c, device 0x0013
PCI: Failed to allocate resource 0(d5120000-d5121fff) for 01:00.0
PCI: Enabling device 01:00.0 (0000 -> 0002)

Again, any assistance greatly appreciated, and I'll test any proposed 
patches.

Andrew

