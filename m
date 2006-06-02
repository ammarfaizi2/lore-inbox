Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWFBHRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWFBHRp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWFBHRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:17:45 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:35745 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751249AbWFBHRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:17:44 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Query: No IDE DMA for IBM 365X with PIIX chipset?
Date: Fri, 02 Jun 2006 17:17:37 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <clnv729389elk916k55gpjql7tc1m8n40n@4ax.com>
References: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com> <1149169812.12932.20.camel@localhost> <447F0DF0.9070009@rainbow-software.org>
In-Reply-To: <447F0DF0.9070009@rainbow-software.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 17:55:28 +0200, Ondrej Zary <linux@rainbow-software.org> wrote:

>Alan Cox wrote:
>> On Sul, 2006-05-28 at 15:29 +1000, Grant Coady wrote:
>>> PIIXa: chipset revision 2
>>> PIIXa: not 100% native mode: will probe irqs later
>>> PIIXa: neither IDE port enabled (BIOS)
>> 
>> It thinks the chip has not been activated, and then falls back to the
>> legacy driver. Could be incorrect enable checks or other problems.
>> 
>>> 00:01.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
>>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>>>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>>>         Latency: 0
>>> 00: 86 80 2e 12 07 00 80 02 02 00 01 06 00 00 00 00
>>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 
>> 82371FB, whee thats prehistoric 8)

Only a little ten-year-old...
>> 
>> I don't actually have any support for the 371FB PIIX in either driver as
>> I've not been able to find a source for the data sheet to the chip. It
>> may work if added to the drivers/scsi/pata_oldpiix identifiers in the
>> 2.6.17rc5-mm kernel. Would be useful to know as I don't know anyone else
>> with that chip any more 8)

Boots 2.6.16.18, 2.6.17rc5 but panics with 2.6.17rc5-mm2 :(  

>Isn't that this one? 
>http://www.intel.com/design/chipsets/datashts/290550.htm
>Used in i430FX chipset. I have some boards with that and they always 
>worked fine. Haven't tried any recent kernels, though.

Yep:

2.2.2. DID-DEVICE IDENTIFICATION REGISTER (Function 0)
Address Offset: 02-03h
Default Value: 122Eh (PIIX)		<<==

~# lspci -n
00:00.0 Class 0600: 8086:1235 (rev 02)
00:01.0 Class 0601: 8086:122e (rev 02)	<<==
00:03.0 Class 0300: 1023:9320 (rev e3)

Grant.
