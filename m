Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSIWN3v>; Mon, 23 Sep 2002 09:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSIWN3v>; Mon, 23 Sep 2002 09:29:51 -0400
Received: from isis.telemach.net ([213.143.65.10]:3080 "HELO isis.telemach.net")
	by vger.kernel.org with SMTP id <S261397AbSIWN3s>;
	Mon, 23 Sep 2002 09:29:48 -0400
Date: Mon, 23 Sep 2002 15:33:01 +0200
From: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.5.38-mm2
Message-Id: <20020923153301.2c87768d.Gregor.Fajdiga@telemach.net>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

I get this oops at startup in 2.5.38-mm2. The oops
might be in vanilla too, but didn't check.

ksymoops 2.4.4 on i686 2.5.38.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.38/ (default)
     -m /boot/System.map-2.5.38 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

c0117826 c02433c0 c02452c2 00000562 c0362c70 c0134386 c02452c2
       00000562 c150b080 ffffffff 00000000 00000fff c0362e94 dfdf9c80 c01d2e60
       04000000 c0362c70 c0109562 00000018 000001d0 dfdf9c80 c0362c60 0000000e
Call Trace: [<c0117826>] [<c0134386>] [<c01d2e60>] [<c0109562>] [<c01cc496>]
   [<c01d2e60>] [<c01cc8fc>] [<c01cc16d>] [<c01dcf6b>] [<c01050b1>] [<c0105060>]
   [<c0105539>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0117826 <__might_sleep+56/5d>
Trace; c0134386 <kmalloc+66/1f0>
Trace; c01d2e60 <ide_intr+0/1d0>
Trace; c0109562 <request_irq+52/a0>
Trace; c01cc496 <init_irq+206/350>
Trace; c01d2e60 <ide_intr+0/1d0>
Trace; c01cc8fc <hwif_init+10c/250>
Trace; c01cc16d <probe_hwif_init+1d/70>
Trace; c01dcf6b <ide_setup_pci_device+3b/60>
Trace; c01050b1 <init+51/1d0>
Trace; c0105060 <init+0/1d0>
Trace; c0105539 <kernel_thread_helper+5/c>


2 warnings issued.  Results may not be reliable.

If you need anymore info, please ask.

Also, please CC me, since I'm not on the list.

Best Regards,
Grega Fajdiga
