Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTJOHku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 03:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJOHku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 03:40:50 -0400
Received: from wiggis.ethz.ch ([129.132.86.197]:31658 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S262109AbTJOHkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 03:40:47 -0400
From: Thom Borton <borton@phys.ethz.ch>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: PCMCIA CD-ROM does not work
Date: Wed, 15 Oct 2003 09:40:55 +0200
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.44.0310131027060.3684-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310131027060.3684-100000@logos.cnet>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HoPj/ax/vKubJFv"
Message-Id: <200310150940.56025.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_HoPj/ax/vKubJFv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hello Marcelo

The problem starts with 2.4.21-pre1. A couple of seconds after I plug 
in the PCMCIA card, the system stops. No noise, no oops, just freeze.

Attached you find the corresponding syslog entries.

Thanks a lot, Tobias

On Monday 13 October 2003 14:35, Marcelo Tosatti wrote:
> On Sat, 11 Oct 2003, Thom Borton wrote:
> > Hey
> >
> > If have now compiled a series of kernels starting from 2.4.18 up
> > to 2.4.22. The drive stops working with 2.4.21. That is indeed
> > where the "drivers/ide/legacy" directory was introduced.
> >
> > What do you mean by binary search? What's a "pre"?
>
> Try 2.4.21-pre1, 2.4.21-pre2, 2.4.21-pre3 etc. to find exactly
> where it stopped working. You can find the patches against 2.4.20
> at
>
> ftp.kernel.org/pub/linux/kernel/v2.4/testing/old/
>
> > Further: In 2.4.22 I get an Oops and the whole system stops when
> > I unplug the pcmcia card -> hard reset.
> >
> > It says:
> >
> > ///////////
> > remove_proc_entry: hde/identify busy, count=1
> > remove_proc_entry: ide2/hde busy, count=1
> > Unable to handle kernel paging request at virtual address
> > 655f6373 printing eip:
> > c011c5b5
> > *pde = 00000000
> > Oops: 0002
> > CPU:     0
> > .......
> > .......
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> > In interrupt handler - not syncing
> > ///////////
> >
> > Sound's scarry, but doesnt tell me a lot, except that I have to
> > reboot the system.
>
> Can you please post the full kernel panic message?
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Thom Borton
Switzerland

--Boundary-00=_HoPj/ax/vKubJFv
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslog-2.4.21-pre1-fail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.4.21-pre1-fail.txt"

Oct 15 09:32:10 grisu kernel: PCI: Found IRQ 9 for device 00:0c.0
Oct 15 09:32:10 grisu kernel: PCI: Sharing IRQ 9 with 00:0a.0
Oct 15 09:32:10 grisu kernel: Yenta IRQ list 00b8, PCI irq9
Oct 15 09:32:10 grisu kernel: Socket status: 30000006
Oct 15 09:32:10 grisu cardmgr[385]: watching 1 socket
Oct 15 09:32:10 grisu kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct 15 09:32:10 grisu kernel: cs: IO port probe 0x0800-0x08ff: clean.
Oct 15 09:32:10 grisu kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x33f 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x3f8-0x3ff 0x4d0-0x4d7
Oct 15 09:32:10 grisu kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct 15 09:32:10 grisu cardmgr[386]: starting, version is 3.2.5
Oct 15 09:32:12 grisu anacron[411]: Anacron 2.3 started on 2003-10-15
Oct 15 09:32:12 grisu /usr/sbin/cron[413]: (CRON) INFO (pidfile fd = 3)
Oct 15 09:32:12 grisu /usr/sbin/cron[414]: (CRON) STARTUP (fork ok)
Oct 15 09:32:13 grisu anacron[411]: Will run job `cron.daily' in 5 min.
Oct 15 09:32:13 grisu anacron[411]: Jobs will be executed sequentially
Oct 15 09:32:13 grisu /usr/sbin/cron[414]: (CRON) INFO (Running @reboot jobs)
Oct 15 09:32:45 grisu cardmgr[386]: socket 0: Ninja ATA
Oct 15 09:32:45 grisu kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Oct 15 09:32:45 grisu cardmgr[386]: executing: 'modprobe ide-cs'
Oct 15 09:32:48 grisu kernel: hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI CD/DVD-ROM drive
Oct 15 09:32:48 grisu kernel: ide2 at 0x180-0x187,0x386 on irq 3
Oct 15 09:32:48 grisu kernel: ide_cs: hde: Vcc = 5.0, Vpp = 0.0
Oct 15 09:32:48 grisu cardmgr[386]: executing: './ide start hde'
Oct 15 09:32:49 grisu kernel: hde: bad special flag: 0x03

--Boundary-00=_HoPj/ax/vKubJFv--

