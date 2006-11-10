Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946597AbWKJNQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946597AbWKJNQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946599AbWKJNQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:16:09 -0500
Received: from stingr.net ([212.193.32.15]:4485 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S1946597AbWKJNQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:16:07 -0500
Date: Fri, 10 Nov 2006 16:15:54 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Paul P Komkoff Jr <i@stingr.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Dumb question] 100k RTC interrupts/sec on SMP system: why?
Message-ID: <20061110131554.GB18001@stingr.net>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Paul P Komkoff Jr <i@stingr.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061109100953.GE2226@stingr.net> <20061109204145.56d02153.akpm@osdl.org> <20061110123541.GA18001@stingr.net> <1163163603.3138.700.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1163163603.3138.700.camel@laptopd505.fenrus.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Arjan van de Ven:

Hi, Arjan!

> On Fri, 2006-11-10 at 15:35 +0300, Paul P Komkoff Jr wrote:
> > ce: <Cronyx Tau-PCI/32-Lite> at 0xfb013000 irq 217
> 
> what kind of device is this? Did the driver come with the kernel?

It's E1 interface card, I use them for telephony.

I am pretty sure that Tau32 isn't guilty (I did tests with and without
it installed), see interrupts

[stingray@voipng ~]$ cat /proc/interrupts
           CPU0       CPU1
  0:    9833272    9829747    IO-APIC-edge  timer
  6:          3          2    IO-APIC-edge  floppy
  7:          1          1    IO-APIC-edge  parport0
  8: 3673166897 3674697116   IO-APIC-level  rtc
 10:          0          0   IO-APIC-level  ohci_hcd:usb1
177:        586        401   IO-APIC-level  acpi
185:       9787       6905   IO-APIC-level  aic7xxx
193:          6          9   IO-APIC-level  aic7xxx
201:     249751          6   IO-APIC-level  eth0
217:   78926484   78899594   IO-APIC-level  Cronyx Tau-PCI/32
NMI:          0          0
LOC:   19663975   19663974
ERR:          0
MIS:          0

This is after 22 hours of uptime.

> Also have you tried acpi=off or the linux firmware test kit (see url in
> sig) to check the bios?

Didn't acpi=off meant to hose interrupt routing, SMP, and poweroff?
I'll try it right now.
And thanks, I didn't know about firmware test kit either ... will
download it right now and test in a few hours.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
