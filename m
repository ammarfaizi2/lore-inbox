Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbTJKLOo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 07:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTJKLOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 07:14:44 -0400
Received: from wiggis.ethz.ch ([129.132.86.197]:24013 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S263281AbTJKLOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 07:14:18 -0400
From: Thom Borton <borton@phys.ethz.ch>
To: Dave Jones <davej@redhat.com>
Subject: Re: PCMCIA CD-ROM does not work
Date: Sat, 11 Oct 2003 13:14:18 +0200
User-Agent: KMail/1.5.4
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200310101652.53796.borton@phys.ethz.ch> <200310101843.17341.borton@phys.ethz.ch> <20031010164747.GG25856@redhat.com>
In-Reply-To: <20031010164747.GG25856@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LY+h/HcfUaibIGN"
Message-Id: <200310111314.20368.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_LY+h/HcfUaibIGN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hey

If have now compiled a series of kernels starting from 2.4.18 up to 
2.4.22. The drive stops working with 2.4.21. That is indeed where the 
"drivers/ide/legacy" directory was introduced.

What do you mean by binary search? What's a "pre"?

Further: In 2.4.22 I get an Oops and the whole system stops when I 
unplug the pcmcia card -> hard reset. 

It says:

///////////
remove_proc_entry: hde/identify busy, count=1
remove_proc_entry: ide2/hde busy, count=1
Unable to handle kernel paging request at virtual address 655f6373
 printing eip:
c011c5b5
*pde = 00000000
Oops: 0002
CPU:     0
.......
.......
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
///////////

Sound's scarry, but doesnt tell me a lot, except that I have to reboot 
the system.

I attached the syslog files for the various working and non-working 
configurations.

Thanks for your help, 

Thom

On Friday 10 October 2003 18:47, Dave Jones wrote:
> On Fri, Oct 10, 2003 at 06:43:17PM +0200, Thom Borton wrote:
>  > You were both right. With CONFIG_ISA the system does not hang
>  > when I plug in the PCMCIA card, but I cannot mount it later.
>  >
>  > What can I do then?
>
> Binary search to find the exact pre that broke this would be
> a good start.
>
> 		Dave

-- 
Thom Borton
Switzerland

--Boundary-00=_LY+h/HcfUaibIGN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslog-2.4.19-success.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.4.19-success.txt"

:   Serial sub-system self-test: passed.
Oct 10 17:47:21 grisu kernel:   Internal registers self-test: passed.
Oct 10 17:47:21 grisu kernel:   ROM checksum self-test: passed (0x04f4518b).
Oct 10 17:47:21 grisu kernel:   Receiver lock-up workaround activated.
Oct 10 17:47:21 grisu apmd[320]: apmd 3.2.0 interfacing with apm driver 1.16 and APM BIOS 1.2
Oct 10 17:47:23 grisu modprobe: modprobe: Can't locate module char-major-6
Oct 10 17:47:23 grisu last message repeated 5 times
Oct 10 17:47:23 grisu modprobe: modprobe: Can't locate module char-major-4
Oct 10 17:47:24 grisu last message repeated 3 times
Oct 10 17:47:26 grisu kernel: Linux Kernel Card Services 3.1.22
Oct 10 17:47:26 grisu kernel:   options:  [pci] [cardbus] [pm]
Oct 10 17:47:26 grisu kernel: PCI: Found IRQ 9 for device 00:0c.0
Oct 10 17:47:26 grisu kernel: PCI: Sharing IRQ 9 with 00:0a.0
Oct 10 17:47:26 grisu kernel: Yenta IRQ list 00b8, PCI irq9
Oct 10 17:47:26 grisu kernel: Socket status: 30000416
Oct 10 17:47:26 grisu cardmgr[388]: watching 1 socket
Oct 10 17:47:26 grisu kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct 10 17:47:26 grisu kernel: cs: IO port probe 0x0800-0x08ff: clean.
Oct 10 17:47:26 grisu kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x33f 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x3f8-0x3ff 0x4d0-0x4d7
Oct 10 17:47:26 grisu kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct 10 17:47:26 grisu cardmgr[389]: starting, version is 3.2.5
Oct 10 17:47:28 grisu anacron[414]: Anacron 2.3 started on 2003-10-10
Oct 10 17:47:29 grisu /usr/sbin/cron[416]: (CRON) INFO (pidfile fd = 3)
Oct 10 17:47:29 grisu /usr/sbin/cron[417]: (CRON) STARTUP (fork ok)
Oct 10 17:47:29 grisu anacron[414]: Normal exit (0 jobs run)
Oct 10 17:47:29 grisu /usr/sbin/cron[417]: (CRON) INFO (Running @reboot jobs)
Oct 10 17:47:49 grisu cardmgr[389]: socket 0: Ninja ATA
Oct 10 17:47:49 grisu kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Oct 10 17:47:50 grisu cardmgr[389]: executing: 'modprobe ide-cs'
Oct 10 17:47:53 grisu kernel: hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI CD/DVD-ROM drive
Oct 10 17:47:53 grisu kernel: ide2 at 0x180-0x187,0x386 on irq 3
Oct 10 17:47:53 grisu kernel: ide_cs: hde: Vcc = 5.0, Vpp = 0.0
Oct 10 17:47:53 grisu cardmgr[389]: executing: './ide start hde'
Oct 10 17:47:53 grisu kernel: hde: bad special flag: 0x03
Oct 10 17:48:09 grisu kernel: hde: ATAPI 16X CD-ROM drive, 128kB Cache
Oct 10 17:48:09 grisu kernel: Uniform CD-ROM driver Revision: 3.12
Oct 10 17:48:10 grisu kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Oct 10 17:48:10 grisu kernel: ISOFS: changing to secondary root
Oct 10 17:48:15 grisu kernel: ide2: unexpected interrupt, status=0xff, count=1
Oct 10 17:48:15 grisu cardmgr[389]: executing: './ide stop hde'
Oct 10 17:48:15 grisu modprobe: modprobe: Can't locate module block-major-33
Oct 10 17:48:15 grisu cardmgr[389]: + open() failed: No such device or address
Oct 10 17:48:16 grisu cardmgr[389]: executing: 'modprobe -r ide-cs'

--Boundary-00=_LY+h/HcfUaibIGN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslog-2.4.20-success.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.4.20-success.txt"

Oct 11 12:29:51 grisu cardmgr[382]: socket 0: Ninja ATA
Oct 11 12:29:51 grisu cardmgr[382]: executing: 'modprobe ide-cs'
Oct 11 12:29:54 grisu kernel: hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI CD/DVD-ROM drive
Oct 11 12:29:54 grisu kernel: ide2 at 0x180-0x187,0x386 on irq 3
Oct 11 12:29:54 grisu kernel: hde: ATAPI 16X CD-ROM drive, 128kB Cache
Oct 11 12:30:02 grisu kernel: ide_cs: hde: Vcc = 5.0, Vpp = 0.0
Oct 11 12:30:02 grisu cardmgr[382]: executing: './ide start hde'
Oct 11 12:30:02 grisu kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Oct 11 12:30:02 grisu kernel: ISOFS: changing to secondary root
Oct 11 12:30:11 grisu kernel: ide2: unexpected interrupt, status=0xff, count=4
Oct 11 12:30:11 grisu cardmgr[382]: executing: './ide stop hde'
Oct 11 12:30:11 grisu modprobe: modprobe: Can't locate module block-major-33
Oct 11 12:30:11 grisu cardmgr[382]: + open() failed: No such device or address
Oct 11 12:30:11 grisu cardmgr[382]: executing: 'modprobe -r ide-cs'

--Boundary-00=_LY+h/HcfUaibIGN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslog-2.4.21-fail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.4.21-fail.txt"

Oct 10 18:22:48 grisu kernel: Yenta IRQ list 00b8, PCI irq9
Oct 10 18:22:48 grisu kernel: Socket status: 30000006
Oct 10 18:22:48 grisu cardmgr[381]: watching 1 socket
Oct 10 18:22:48 grisu kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct 10 18:22:48 grisu kernel: cs: IO port probe 0x0800-0x08ff: clean.
Oct 10 18:22:48 grisu kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x33f 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x3f8-0x3ff 0x4d0-0x4d7
Oct 10 18:22:48 grisu kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct 10 18:22:48 grisu cardmgr[382]: starting, version is 3.2.5
Oct 10 18:23:25 grisu kernel: cs: socket c17ff800 voltage interrogation timed out

--Boundary-00=_LY+h/HcfUaibIGN--

