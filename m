Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWI0BOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWI0BOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 21:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWI0BOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 21:14:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:31197 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932223AbWI0BOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 21:14:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DwYmVLD/x5kZvFhC5SInhozCb4iNE/1buos7DIZwT+62/0gEHTawIVWrtRLWI0QYf+LHMMrbyQHPCYlsvsTpVdGbZgLu4HKY8v06NO1d9H8JJX7PFnLTlSRQQ4QUDkkYjt3aEwW6DEWc7Ek62xp2jux72MPOTkm9Rap3js///vs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time: acpi_pm clocksource has been installed.
Date: Wed, 27 Sep 2006 03:15:30 +0200
User-Agent: KMail/1.9.4
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com> <200609270236.58148.jesper.juhl@gmail.com> <20060926175440.bb88b130.rdunlap@xenotime.net>
In-Reply-To: <20060926175440.bb88b130.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609270315.30897.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 02:54, Randy Dunlap wrote:
> On Wed, 27 Sep 2006 02:36:58 +0200 Jesper Juhl wrote:
> 
> > On Wednesday 27 September 2006 02:33, Randy Dunlap wrote:
> > > On Wed, 27 Sep 2006 02:22:18 +0200 Jesper Juhl wrote:
> > > 
> > > > I get this in dmesg with 2.6.18-git6 :
> > > >       a3:<6>Time: acpi_pm clocksource has been installed.
> > > > 
> > > > Looks like some printk() somewhere is not adding \n correctly after
> > > > outputting a message priority or a message priority too much is
> > > > used... I've not investigated where this happens, but just wanted to
> > > > report it.
> > > 
> > > Hi,
> > > How about posting (pasting) some of the message log before that?
> > > 
> > Sure, below is the entire dmesg output from this boot of the box 
> > (including the line above) :
> 
> OK, would you boot with "initcall_debug" on the kernel command
> line and post the relevant output again, please?

Sure thing :

Real Time Clock Driver v1.12ac
Calling initcall 0xc0491cc0: serial8250_init+0x0/0xf0()
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Calling initcall 0xc0491db0: serial8250_pci_init+0x0/0x20()
Calling initcall 0xc0491f10: firmware_class_init+0x0/0x70()
Calling initcall 0xc0492000: topology_sysfs_init+0x0/0x70()
Calling initcall 0xc04928a0: floppy_init+0x0/0x620()
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Calling initcall 0xc0492ec0: rhine_init+0x0/0x20()
via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
Calling initcall 0xc0492fd0: net_olddevs_init+0x0/0x40()
ACPI: PCI Interrupt 0000:04:07.0[A] -> Calling initcall 0xc0493380: spi_transport_init+0x0/0x30()
Calling initcall 0xc04933b0: fc_transport_init+0x0/0x40()
Calling initcall 0xc04933f0: ahc_linux_init+0x0/0xa0()
Calling initcall 0xc0493490: init_sd+0x0/0x70()
Calling initcall 0xc0493500: init_sr+0x0/0x30()
Calling initcall 0xc0493530: init_sg+0x0/0x90()
Calling initcall 0xc04935c0: cdrom_init+0x0/0x10()
Calling initcall 0xc0493710: i8042_init+0x0/0x90()
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Calling initcall 0xc04938c0: mousedev_init+0x0/0xe0()
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 21 (level, low) -> IRQ 19
mice: PS/2 mouse device common for all mice
GSI 22 (level, low) -> IRQ 18
Calling initcall 0xc04939a0: atkbd_init+0x0/0x20()
Calling initcall 0xc04939c0: psmouse_init+0x0/0x50()
Calling initcall 0xc0493a10: edac_mc_init+0x0/0xe0()
EDAC MC: Ver: 2.0.1 Sep 27 2006
Calling initcall 0xc0494010: init_acpi_pm_clocksource+0x0/0x110()
Calling initcall 0xc0494150: init_soundcore+0x0/0x60()
Calling initcall 0xc0496cf0: init_syncookies+0x0/0x20()
Calling initcall 0xc0496d10: inet_diag_init+0x0/0x60()
Calling initcall 0xc0496d70: tcp_diag_init+0x0/0x10()
Calling initcall 0xc0496d80: cubictcp_register+0x0/0xc0()
TCP cubic registered
eth0: VIA Rhine II at 0xff5fec00, 00:50:ba:f2:a3:1d, IRQ 18.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
Calling initcall 0xc0496e40: af_unix_init+0x0/0x70()
input: AT Translated Set 2 keyboard as /class/input/input0
NET: Registered protocol family 1
Calling initcall 0xc0496eb0: packet_init+0x0/0x4c()
NET: Registered protocol family 17
Calling initcall 0xc047f2e0: amd_exit_cpu+0x0/0x20()
Calling initcall 0xc047f9b0: cyrix_exit_cpu+0x0/0x20()
Calling initcall 0xc047f9f0: nsc_exit_cpu+0x0/0x20()
Calling initcall 0xc047fcb0: centaur_exit_cpu+0x0/0x20()
Calling initcall 0xc047ff60: transmeta_exit_cpu+0x0/0x20()
Calling initcall 0xc0480f90: rise_exit_cpu+0x0/0x20()
Calling initcall 0xc0481040: nexgen_exit_cpu+0x0/0x20()
Calling initcall 0xc0481090: umc_exit_cpu+0x0/0x20()
Calling initcall 0xc0484900: check_nmi_watchdog+0x0/0x1b0()
Calling initcall 0xc0484b70: init_lapic_nmi_sysfs+0x0/0x40()
Calling initcall 0xc0484bf0: balanced_irq_init+0x0/0x1c0()
Starting balanced_irq
Calling initcall 0xc0486790: io_apic_bug_finalize+0x0/0x20()
Calling initcall 0xc0487f30: print_ipi_mode+0x0/0x30()
Using IPI Shortcut mode
Calling initcall 0xc0489750: clocksource_done_booting+0x0/0x20()
Calling initcall 0xc02449a0: acpi_poweroff_init+0x0/0x58()<6>Time: acpi_pm clocksource has been installed.

Calling initcall 0xc0490cd0: seqgen_init+0x0/0x10()
Calling initcall 0xc02eab10: net_random_reseed+0x0/0x70()
Calling initcall 0xc0496a70: tcp_congestion_default+0x0/0x10()
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1


-- 
Jesper Juhl <jesper.juhl@gmail.com>


