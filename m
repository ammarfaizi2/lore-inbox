Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313529AbSDYXqf>; Thu, 25 Apr 2002 19:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313533AbSDYXqe>; Thu, 25 Apr 2002 19:46:34 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64707 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313529AbSDYXqd>; Thu, 25 Apr 2002 19:46:33 -0400
Date: Thu, 25 Apr 2002 19:46:33 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200204252346.g3PNkXb00413@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic while booting on a P2 with linux-2.5.10
In-Reply-To: <mailman.1019767440.8207.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pentium2 266MHz,
> Intel 440LX Chipset, Gigabyte mainboard,
> Advansys SCSI OEM card (bundled with TEAC8x burner)
> nVidia riva128 graphic card 4MB RAM,
> 8GB IDE HDD,
> USB ACM modem, USB scanner, ...

Same trace here. I've got P-III/733, no SCSI or other unusual
peripherals. Works like a charm with all sorts of 2.4.x.

Can add EIP points to __ide_end_requiest
> Trace; c01b9f41 <ide_end_request+11/20>
> Trace; c01c1d83 <cdrom_pc_intr+d3/1e0>
> Trace; c01b7e5d <ide_intr+ed/1a0>
> Trace; c01c1cb0 <cdrom_pc_intr+0/1e0>
> Trace; c010856a <handle_IRQ_event+3a/70>
> Trace; c0108761 <do_IRQ+91/f0>
> Trace; c010728e <common_interrupt+22/28>
> Trace; c0110018 <mtrr_add_page+2c8/370>
> Trace; c011139e <apm_bios_call+6e/80>
> Trace; c0111446 <apm_get_event+26/70>
> Trace; c01116a0 <apm_cpu_idle+130/140>

My trace is the same interrupt, but it starts at some unrelated
thread, so I do not think it's APM. Probably IDE.

-- Pete
