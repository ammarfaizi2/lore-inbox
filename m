Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTJVL0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263541AbTJVL0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:26:38 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:56456 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263540AbTJVL0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:26:36 -0400
Message-ID: <3F9669BF.1040408@t-online.de>
Date: Wed, 22 Oct 2003 13:27:59 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031011
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.demon.co.uk>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: VIA IDE performance under 2.6.0-test7/8?
References: <C0D45ABB3F45D5118BBC00508BC292DB016038F5@imgserv04> <3F957DAC.6080901@superbug.demon.co.uk>
In-Reply-To: <3F957DAC.6080901@superbug.demon.co.uk>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: GtMRm8ZEQeOK5xPFgRN24jTy8CuyWkcb06pqJ4fevhHRD+b8udgXwM@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James!

> Can you also send the output from "cat /proc/interrupts".
> It looks like you are not using IO-APIC, but instead using XT-PIC.
> XT-PIC is a lot slower than IO-APIC.

Reading the  previous messages I compared the SuSE 2.4.20-4GB and the 
2.6.0-test8-bk1 kernel.

The mainboard is a VIA EPIA 5000 (cpu Via Eden 533 Mhz, Via 8601A 
Northbridge, VT8231 Southbridge)

hdparm -I /dev/hd? displays no difference ... udma2 is the used mode.

hdparm -T /dev/hd? measures transfer rates of 60-63 MB/s, there is no 
significant difference between
the kernel versions.

hdparm -t /dev/hd? mesasures 18 MB/s for kernel 2.6.0-test8-bk1 and 27 
MB/s for kernel 2.4.20.
This is a significant  :-(

2.4.20 gives almost exactly 50% better performance compared to 
2.6.0-test8 ... is this pure accident or could this give a hint?

> Just turn on SMB support in the "make menuconf", and it should enable 
> IO-APIC.

Compiling the kernel with and without smb support as well as trying the 
other APIC related new configuration options
does change nothing.  There is allways a "No local APIC present or 
hardware disabled" message. I believe that there
really is no IO-APIC, at least I found no related BIOS configuration option.

/proc/interrupts indicates an XT-PIC for both kernel versions.

IRQ setup is identical, IDE IRQs are not shared with any other devices.

The drive is the only drive attached.

Playing around with different read-ahead values does not help.

Any ideas?

cu,
 Knut Petersen


