Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272268AbTHIGep (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 02:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272271AbTHIGep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 02:34:45 -0400
Received: from deepthought.resolution.de ([195.30.142.42]:37338 "EHLO
	deepthought.resolution.de") by vger.kernel.org with ESMTP
	id S272268AbTHIGek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 02:34:40 -0400
Subject: Re: unexpected IRQ trap at vector a0
From: Christian Reichert <c.reichert@resolution.de>
To: Yaroslav Halchenko <yoh@onerussian.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030809022532.GA6345@washoe.rutgers.edu>
References: <20030809022532.GA6345@washoe.rutgers.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2003 08:34:28 +0200
Message-Id: <1060410869.2887.31.camel@stargate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !


The boot option you have tried is not compleately correct.

Please gove it one try with option:

   pci=noacpi

if that doesn't help try:

   acpi=off

and let us know the results ...


Cheers,
    Chris


On Sat, 2003-08-09 at 04:25, Yaroslav Halchenko wrote:
> Dear developers and bug-finders,
> 
> I've got a new desktop - some kind of Pentium IV with hyper-threading,
> so immediately decided to switch it to 2.6.0-test2-bk8 kernel which was
> running on my desktop/laptops for quite a while, but I've got next
> problem: when it boots I begin getting my console as well as
> syslog/messages flooded with
> 
> unexpected IRQ trap at vector a0
> 
> (actually first it hanged with PNPBIOS problem - I turned it off)
> 
> I modified kernel a bit to don't get all my dmesg filled with only
> this error message, so now it is reported only on 1st occurrence (as
> well as next string Yarik: APIC is On).
> 
> So this error fires up for the first time in the context:
> 
>    i2c-piix4 version 2.7.0 (20021208)
>    Advanced Linux Sound Architecture Driver Version 0.9.6 (Mon Jul 28
> 11:08:42 2003 UTC).
>    request_module: failed /sbin/modprobe -- snd-card-0. error = -16
>    specify port
>    specify port
>    PCI: Setting latency timer of device 0000:00:1f.5 to 64
> unexpected IRQ trap at vector a0
>    intel8x0: clocking to 48000
>    ALSA device list:
>      #0: Intel ICH5 at 0xfebff800, irq 17
>    
> And later I'm getting also 
> IPv6 over IPv4 tunneling driver
> irq 9: nobody cared!
> Call Trace:
>  [<c010b347>] __report_bad_irq+0x2a/0x8b
>  [<c010b431>] note_interrupt+0x6f/0x9f
>  [<c010b748>] do_IRQ+0x161/0x192
>  [<c0109a9c>] common_interrupt+0x18/0x20
>  [<c010b2dd>] handle_IRQ_event+0x24/0x64
>  [<c010b69f>] do_IRQ+0xb8/0x192
>  [<c0105000>] _stext+0x0/0x64
>  [<c0109a9c>] common_interrupt+0x18/0x20
>  [<c0106e1e>] default_idle+0x0/0x2c
>  [<c0105000>] _stext+0x0/0x64
>  [<c0106e47>] default_idle+0x29/0x2c
>  [<c0106eb7>] cpu_idle+0x3a/0x3c
>  [<c045481f>] start_kernel+0x16c/0x183
>  [<c045440e>] unknown_bootoption+0x0/0xfd
> 
> handlers:
> [<c01f807f>] (acpi_irq+0x0/0x16)
> Disabling IRQ #9
> 
> 
> My logs and kernel configuration (it was patched by
> sched-2.6.0-test1-G7, though error existed in pure vanilla kernel as
> well - I just already had compiled patched version in my hands already
> so decided to proceed with it)
> 
> http://www.onerussian.com/acpi.PIV/
> 
> I will provide any additional necessary information.
> 
> Thank you in advance for your help
> 
>                                   .-.
> =------------------------------   /v\  ----------------------------=
> Keep in touch                    // \\     (yoh@|www.)onerussian.com
> Yaroslav Halchenko              /(   )\               ICQ#: 60653192
>                    Linux User    ^^-^^    [175555]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


