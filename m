Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTJ2Syo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 13:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTJ2Syo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 13:54:44 -0500
Received: from pinguin13.kwc.at ([193.228.81.158]:49646 "EHLO
	mail.hello-penguin.com") by vger.kernel.org with ESMTP
	id S261299AbTJ2Sym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 13:54:42 -0500
Date: Wed, 29 Oct 2003 19:47:58 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Yaroslav Rastrigin <yarick@relex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI && vortex still broken in latest 2.4 and 2.6.0-test9
Message-ID: <20031029184758.GA1201@hello-penguin.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
References: <20031029134848.GA949@hello-penguin.com> <20031029140317.GF10693@merlin.emma.line.org> <200310291832.22650.yarick@relex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200310291832.22650.yarick@relex.ru>
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.22-stefan (i686)
X-PGP: Key fingerprint = C090 8941 DAD8 4B09 77B1  E284 7873 9310 3BDB EA79
X-MIL: A-6172171143
User-Agent: Mutt/1.5.4i
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 7 10 36 37 38 43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 06:32:22PM +0300, Yaroslav Rastrigin wrote:
> On Wednesday 29 October 2003 17:03, Matthias Andree wrote:
> > > Affected are at least
> > > IBM Thinkpad T21  http://lkml.org/lkml/2003/6/15/111
> > > IBM Thinkpad A21p (3c556B Laptop Hurricane)
> >
> > Might the problems you observe be related to the IBM BIOS?
> Yes. With IBM's DSDT, to be more specific. I've filed a bug in the bugzilla, 

Well, I could try a Dell BIOS on my A21p if buying a SCO-Linux license
doesn't fix the problem. :)

http://www.hello-penguin.com/thinkpad/
contains more info including a dump of /proc/acpi/dsdt
if somebody cares (to acpi_blacklist it).

Maybe this is interesting: It's a diff of lspci -vvvvvvvvv
without and with acpi enabled...

--- lspci-noacpi	2003-10-29 19:20:00.000000000 +0100
+++ lspci-acpi	2003-10-29 19:21:42.000000000 +0100
@@ -49,13 +49,13 @@
 
 00:03.0 Ethernet controller: 3Com Corporation 3c556B Hurricane CardBus (rev 20)
 	Subsystem: 3Com Corporation: Unknown device 6356
-	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
-	Latency: 80 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
+	Latency: 64 (2500ns min, 2500ns max)
 	Interrupt: pin A routed to IRQ 9
 	Region 0: I/O ports at 1800 [size=256]
-	Region 1: Memory at f0101400 (32-bit, non-prefetchable) [size=128]
-	Region 2: Memory at f0101000 (32-bit, non-prefetchable) [size=128]
+	Region 1: [virtual] Memory at f0101400 (32-bit, non-prefetchable) [size=128]
+	Region 2: [virtual] Memory at f0101000 (32-bit, non-prefetchable) [size=128]
 	Expansion ROM at <unassigned> [disabled] [size=128K]
 	Capabilities: [50] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)

-- 

  ciao - 
    Stefan
