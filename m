Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbULATwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbULATwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 14:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbULATwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 14:52:37 -0500
Received: from web60507.mail.yahoo.com ([216.109.116.128]:35743 "HELO
	web60507.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261426AbULATw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 14:52:29 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=X3NRcacEKGnmHw8Y8I8n7uwrsPCF98B3afJmJ+6EnD1zgan/Dxs/GKZ4kHL2CXYigLOieVLSfD8uVfRf47Z9imFlOwhdAll+LmiE3zNfJHBM9cEx4DyEgjSTcARRfN7mvtoNTzYC/8HNol+XKdA84xC+bigpahGb93cxRepeBNY=  ;
Message-ID: <20041201195222.36584.qmail@web60507.mail.yahoo.com>
Date: Wed, 1 Dec 2004 11:52:22 -0800 (PST)
From: K G <gege86hu@yahoo.com>
Subject: Re: "irq 16: nobody cared!" -errors after motherboard-switch (ABIT IS7-E2 motherboard)
To: K G <gege86hu@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041201174010.95519.qmail@web60505.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- K G <gege86hu@yahoo.com> wrote:

> Hello!
> 
> This is a part from /var/log/dmesg (link to full
> file
> included later):
> 
> irq 16: nobody cared!
>  [<c0108366>] __report_bad_irq+0x2a/0x8b
>  [<c0108450>] note_interrupt+0x6f/0x9f
>  [<c010876e>] do_IRQ+0x161/0x192
>  [<c0106a40>] common_interrupt+0x18/0x20
>  [<c042ffd3>] cfb_imageblit+0x3b7/0x60c
>  [<c0106a40>] common_interrupt+0x18/0x20
>  [<c0426a37>] accel_putcs+0x29a/0x320
>  [<c0108752>] do_IRQ+0x145/0x192
>  [<c042007b>] cdrom_mrw_probe_pc+0xa5/0xa8
>  [<c04280a2>] fbcon_redraw+0x1e8/0x208
>  [<c042880a>] fbcon_scroll+0x748/0xc40
>  [<c037cbb1>] scrup+0x13b/0x14f
>  [<c037e5d7>] lf+0x73/0x75
>  [<c0380e6c>] vt_console_print+0x127/0x2ed
>  [<c0123a82>] __call_console_drivers+0x55/0x57
>  [<c0123b90>] call_console_drivers+0x85/0x11f
>  [<c0123f67>] release_console_sem+0x63/0xf3
>  [<c0123e6b>] printk+0x169/0x1bd
>  [<c075f834>] usb_pwc_init+0x43/0x3a7
>  [<c07428e5>] do_initcalls+0x28/0xb4
>  [<c0133ea4>] init_workqueues+0x17/0x2e
>  [<c0100520>] init+0xf3/0x263
>  [<c010042d>] init+0x0/0x263
>  [<c0104271>] kernel_thread_helper+0x5/0xb
> 
> handlers:
> [<c0435483>] (usb_hcd_irq+0x0/0x67)
> [<c0435483>] (usb_hcd_irq+0x0/0x67)
> Disabling IRQ #16
> 
> I've recently switched from an "ASUS P4T533-C"
> motherboard to an "ABIT IS7-E2", and got the errors
> mentioned above after boot. Only the motherboard and
> the ram was changed (rambus -> INFINEON 400Mhz DDR).
> 
> I've tried everything that I could do, bot non of
> them
> helped:
> 
> I've set the Sata to "enhanced mode" in BIOS
> Settings,
> which solved the problem for a guy with a similar
> ABIT
> motherboard, it didn't worked for me; Actually I've
> tried all Sata settings...
> 
> I've tried it with 2.6.7, 2.6.9, even 2.6.10-rc2
> kernels, same error everywhere.
> 
> Slax LiveCD got the same error, my installed system
> got the same error(SourceMage linux). Interestingly
> UHU-Linux hasn't got any errors(maybe because the
> 2.4
> kernel it uses).
> 
> So I've figured that the IRQ is shared between the
> two
> onboard 1.1 USB hubs and the vga card. My vga is an
> NVIDIA  GeForce4 Ti4200 btw.
> 
> If I disable the onboard usb in the BIOS, I get no
> errors. I also don't get any errors when I pass the
> "noirqdebug" parameter to the kernel. (Maybe the
> system is a bit slower I think.)
> 
> If I get the errors I can't start X with the nvidia
> driver, and my usb mouse stops working. However if I
> use vesa for video I can start X, and it runs just
> fine. USB mouse works too, if I plug it
> elsewhere(not
> in the motherboard's onboard usb hubs)
> 
> I have support of ACPI support in kernel, tried to
> boot with "noacpi" parameter, but nothing changed.
> Disabling ACPI support in kernel give the same
> results.
> 
> Oh, and when I tried to install windows XP for my
> sis
> on the same computer it hangs after it copied the
> files to hdd, and rebooted the system. It stays
> there
> with the blue background of the installer and a
> cursor. Mouse moves, but nothing happens. I've just
> wrote this here to give all info I can. :)
> 
> So I only want to know that why can it work
> flawlessly
> with noirqdebug on, and why it can't without.
> 
> I've put the board in the computer according to its'
> manual, and it is ok I think. Though if I messed up
> something, then I REALLY don't want to waste your
> time, but if someone would be so kind to explain me
> in
> cc than I would be really thankful :) I don't want
> to
> waste your time or the list's bandwith.
> 
> Here are the complete logs/files:
> 
> http://izone.sytes.net/logs/dmesg
> http://izone.sytes.net/logs/.config
> http://izone.sytes.net/logs/xorg.log
> 
> Or the compressed version with all of them:
> http://izone.sytes.net/logs/logs.tar.bz2
> 
> Kálmán Gergely
> 
> PS: This is a first post, so please be gentle :)
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


This post was done by me, but the Hungarian characters
in my name caused the list to show only the first K :)
I just don't wanted to be rude not to introduce myself

Kalman Gergely

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
