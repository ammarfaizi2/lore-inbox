Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTEUX73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTEUX73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:59:29 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:25093 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id S262379AbTEUX71 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:59:27 -0400
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: e100 driver
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D724@orsmsx402.jf.intel.com>
	<20030521233220.GA20622@fargo>
From: moffe@amagerkollegiet.dk (=?iso-8859-1?q?Rasmus_B=F8g_Hansen?=)
Date: Thu, 22 May 2003 02:12:20 +0200
In-Reply-To: <20030521233220.GA20622@fargo> (
 =?iso-8859-1?q?David_G=F3mez's_message_of?= "Thu, 22 May 2003 01:32:20
 +0200")
Message-ID: <87wugjsuu3.fsf@grignard.amagerkollegiet.dk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gómez <david@pleyades.net> writes:

> Hi Scott,
>
>> > I reloaded again the e100 module with this parameter. Let's 
>> > see how it performs. Thanks for the advice ;)
>> > 
>> > I'll let you know if checksum errors doesn't show anymore.
>> 
>> There are several new reports of this problem, so we're trying to repro now...
>
> Indeed disabling hardware receive hecksums made the problem go away, it's been
> more that a day with no errors in my logs. If you want to know more about my
> hardware/software configuration, let me know.

I have had some of these too but never paid them any attention
(2.4.21-rc2).

I too tried disabling hardware checksums - now I don't see anything in
the logs...

00:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at a000 [size=64]
        Region 2: Memory at d4800000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 17 00 90 02 08 00 00 02 08 20 00 00
10: 00 00 00 d5 01 a0 00 00 00 00 80 d4 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38

I disabled the PXE function on the boot rom using the DOS intel tool;
otherwise I haven't messed with the firmware.

/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
Memory is like gasoline. You use it up when you are running. Of 
course you get it all back when you reboot.
                                         -- Microsoft help desk
----------------------------------[ moffe at amagerkollegiet dot dk ] --

