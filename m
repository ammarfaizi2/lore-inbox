Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTE3KUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 06:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTE3KUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 06:20:34 -0400
Received: from catv-50622120.szolcatv.broadband.hu ([80.98.33.32]:34176 "EHLO
	catv-50622120.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S262984AbTE3KUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 06:20:33 -0400
Message-ID: <3ED7338E.7030009@freemail.hu>
Date: Fri, 30 May 2003 12:33:50 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm2
References: <3ED70B9A.5050104@freemail.hu> <20030530012710.57cca756.akpm@digeo.com> <3ED728DF.8030203@freemail.hu> <3ED72E97.7060008@freemail.hu>
In-Reply-To: <3ED72E97.7060008@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan wrote:

> OK, compiled as built-in, not too many problems left. 


One problem is found: I enabled ACPI and disabled APM.
On poweroff, I got an oops after every service stopped.
I was able to read some lines vaguely, it wrote something about
"acpi_poweroff called", "IRQ#20 disabled", but I was not able to
write the oops down because the machine switched itself off.

Here are some info I was able to gather:
ASUS P2B-D with 2 PIII/500

# lspci -s 00:04.3
00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
[root@catv-50622120 proc]# lspci -s 00:04.3 -vvv
00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
# cat interrupts
           CPU0       CPU1
  0:      23121     462231    IO-APIC-edge  timer
  1:       2493         11    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:       9135        756    IO-APIC-edge  i8042
 14:      14296       2371    IO-APIC-edge  ide0
 15:       4055       1804    IO-APIC-edge  ide1
 16:          1         90   IO-APIC-level  eth1
 19:        373          4   IO-APIC-level  eth0
 20:          0          0   IO-APIC-level  acpi
NMI:          0          0
LOC:     485147     485151
ERR:          0
MIS:          0

Best regards,
Zoltán Böszörményi


