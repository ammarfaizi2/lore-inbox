Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131437AbRCPXw4>; Fri, 16 Mar 2001 18:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131440AbRCPXwq>; Fri, 16 Mar 2001 18:52:46 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:65191 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131437AbRCPXwf>; Fri, 16 Mar 2001 18:52:35 -0500
Date: Fri, 16 Mar 2001 18:52:53 -0500
From: "Michael B. Allen" <mballen@erols.com>
To: linux-kernel@vger.kernel.org
Subject: parport not detected
Message-ID: <20010316185253.A865@nano.foo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The parallel port is not being detected on my ABIT KT7A KT133 w/ Athlon
900 running 2.2.17 w/ Hendricks IDE patches and RH 6.2. I tried most of
the settings in the bios.

BIOS options are:

728/IRQ5
378/IRQ7
3BC/IRQ7

with the possible modes:

Normal
EPP
	1.9 or 1.7
ECP
	DMA 3 or 1
ECP+EPP
	1.9 or 1.7 and DMA 3 or 1

Of the above what's optimal?

[miallen@nano /etc]$ cat conf.modules
alias eth0 3c59x
alias char-major-6 parport_pc
alias parport_lowlevel parport_pc

Also, the module is loading with depmod:

[miallen@nano 0]$ for i in /proc/parport/0/*; do echo $i; cat $i; done
/proc/parport/0/autoprobe
/proc/parport/0/devices
/proc/parport/0/hardware
base:   0x3bc
irq:    none
dma:    none
modes:  SPP
/proc/parport/0/irq
none

I also tried an options line in modules.conf. I believe it was:

options parport_pc io=0x3bc irq=7

That was reflected in /proc but no difference in actually "detecting"
the parallel port. I did see the light come on on the printer once
though. Also, if I build parpart into the kernel I get nothing but a
hard lockup on 'Starting kswapd v 1.5'.

Any ideas?

Thanks,
Mike
