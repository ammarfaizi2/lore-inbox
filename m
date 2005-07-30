Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbVG2Wzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbVG2Wzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVG2Wzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:55:39 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:60006 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262888AbVG2WzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:55:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=coLuZCEHOFZO1TSOARjZeqpWnX3rxED21RM9yQgcQ8CxDOr9x8kMtv9BDsXdR+aLizkTeuBU9ta+IOejyDtLUVAoMIvzz4upgFMCidMp/Cm9XMwar8GZa/GG4V2usvTKz3S8CEx3E2nuRvY+hXtxcYMNCkw2SfF/VFFH5MSRFaY=
Message-ID: <42EAD086.4010904@gmail.com>
Date: Sat, 30 Jul 2005 00:57:42 +0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050726)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Alexander Fieroch <fieroch@web.de>
CC: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alexey Dobriyan <adobriyan@gmail.com>, Natalie.Protasevich@UNISYS.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
References: <d6gf8j$jnb$1@sea.gmane.org>	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>	 <20050615143039.24132251.akpm@osdl.org>	 <1118960606.24646.58.camel@localhost.localdomain>	 <42B2AACC.7070908@web.de>	 <1119011887.24646.84.camel@localhost.localdomain>	 <42B302C2.9030009@web.de> <9a874849050617101712b80b15@mail.gmail.com> <42CBAFC6.6040608@web.de> <42EAAFD4.4010303@web.de>
In-Reply-To: <42EAAFD4.4010303@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Fieroch schrieb:

> Andrew Morton wrote:
>  > Is 2.6.13-rc4 running OK? If not, please cc linux-kernel on the 
> reply and
>  > re-summarise the problem, thanks.
>
> Same problems as before occur in kernel 2.6.13rc4, too.
>
> I've attached the syslog with kernel parameters "acpi=debug pci=routeirq
> apic=debug".
>
> Regards,
> Alexander
>
>------------------------------------------------------------------------
>
>           CPU0       CPU1       
>  0:      56856          0    IO-APIC-edge  timer
>  1:        147          0    IO-APIC-edge  i8042
>  7:          0          0    IO-APIC-edge  parport0
>  8:          0          0    IO-APIC-edge  rtc
>  9:          0          0   IO-APIC-level  acpi
> 10:          0          0    IO-APIC-edge  MPU401 UART
>169:        497          0   IO-APIC-level  skge, uhci_hcd:usb5, HDA Intel
>177:          0          0   IO-APIC-level  Ensoniq AudioPCI
>185:        274          0   IO-APIC-level  ide2, ide3, ehci_hcd:usb1, uhci_hcd:usb2
>193:       3920          0   IO-APIC-level  libata, uhci_hcd:usb3
>201:     900000          0   IO-APIC-level  ide0, uhci_hcd:usb4
>209:          5          0   IO-APIC-level  bttv0, ohci1394
>NMI:         52          1 
>LOC:      55103      55092 
>ERR:          1
>MIS:          0
>
>  
>
>------------------------------------------------------------------------
>
>
>Jul 29 12:42:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:37 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
>Jul 29 12:42:37 orclex kernel: 
>Jul 29 12:42:37 orclex kernel: Call Trace: <IRQ> <ffffffff80156e67>{__report_bad_irq+48} <ffffffff80156f60>{note_interrupt+144}
>Jul 29 12:42:37 orclex kernel: <ffffffff8015678b>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
>Jul 29 12:42:37 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff8016ac7f>{find_vma+22}
>Jul 29 12:42:37 orclex kernel: <ffffffff8011ecfe>{do_page_fault+409} <ffffffff801389c6>{do_wait+830}
>Jul 29 12:42:37 orclex kernel: <ffffffff801300a5>{default_wake_function+0} <ffffffff8010e4dd>{error_exit+0}
>Jul 29 12:42:37 orclex kernel: 
>Jul 29 12:42:37 orclex kernel: handlers:
>Jul 29 12:42:37 orclex kernel: [<ffffffff8031c835>] (ide_intr+0x0/0x17a)
>Jul 29 12:42:37 orclex kernel: [<ffffffff803615f5>] (usb_hcd_irq+0x0/0x68)
>Jul 29 12:42:37 orclex kernel: Disabling IRQ #201
>Jul 29 12:42:37 orclex kernel: scsi: unknown opcode 0x85
>Jul 29 12:42:37 orclex lpd[4513]: restarted
>Jul 29 12:42:38 orclex nmbd[4523]: [2005/07/29 12:42:38, 0, pid=4523] nmbd/asyncdns.c:start_async_dns(149)
>Jul 29 12:42:38 orclex nmbd[4523]:   started asyncdns process 4524
>Jul 29 12:42:38 orclex smartd[4530]: smartd version 5.32 Copyright (C) 2002-4 Bruce Allen
>Jul 29 12:42:38 orclex smartd[4530]: Home page is http://smartmontools.sourceforge.net/
>Jul 29 12:42:38 orclex smartd[4530]: Opened configuration file /etc/smartd.conf
>Jul 29 12:42:38 orclex smartd[4530]: Drive: DEVICESCAN, implied '-a' Directive on line 23 of file /etc/smartd.conf
>Jul 29 12:42:38 orclex smartd[4530]: Configuration file /etc/smartd.conf was parsed, found DEVICESCAN, scanning devices
>Jul 29 12:42:38 orclex smartd[4530]: Device: /dev/hda, opened
>Jul 29 12:42:47 orclex kernel: hda: lost interrupt
>Jul 29 12:42:47 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:47 orclex smartd[4530]: Device: /dev/hda, found in smartd database.
>Jul 29 12:42:48 orclex hddtemp[4508]: /dev/hda: IC35L060AVV207-0: 36 C
>Jul 29 12:42:48 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
>Jul 29 12:42:48 orclex kernel: 
>Jul 29 12:42:48 orclex kernel: Call Trace: <IRQ> <ffffffff80156e67>{__report_bad_irq+48} <ffffffff80156f60>{note_interrupt+144}
>Jul 29 12:42:48 orclex kernel: <ffffffff8015678b>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
>Jul 29 12:42:48 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff8010daae>{system_call+126}
>Jul 29 12:42:48 orclex kernel: 
>Jul 29 12:42:48 orclex kernel: handlers:
>Jul 29 12:42:48 orclex kernel: [<ffffffff8031c835>] (ide_intr+0x0/0x17a)
>Jul 29 12:42:48 orclex kernel: [<ffffffff803615f5>] (usb_hcd_irq+0x0/0x68)
>Jul 29 12:42:48 orclex kernel: Disabling IRQ #201
>Jul 29 12:42:58 orclex kernel: hda: lost interrupt
>Jul 29 12:42:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>Jul 29 12:42:59 orclex smartd[4530]: Device: /dev/hda, is SMART capable. Adding to "monitor" list.
>Jul 29 12:42:59 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>  
>
Hello Alexander,

do you run
A.) SATA in Enhanced Mode
B.) SATA+PATA or PATA operation mode?

This problem I can reproduce when I  set A.)+B.) in bios I
exactly get the same behavior of confused cd - drives.

Greets

Best regards
             Michael
