Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTDTNLq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 09:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTDTNLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 09:11:46 -0400
Received: from zork.zork.net ([66.92.188.166]:12001 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263571AbTDTNLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 09:11:45 -0400
To: linux-kernel@vger.kernel.org
Subject: irq balancing; kernel vs. userspace
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: ARGUMENTUM AD BACULUM, HACKING
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 20 Apr 2003 14:23:46 +0100
In-Reply-To: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com> (Linus
 Torvalds's message of "Sat, 19 Apr 2003 20:11:40 -0700 (PDT)")
Message-ID: <6uwuhpl2u5.fsf@zork.zork.net>
User-Agent: Gnus/5.090019 (Oort Gnus v0.19) Emacs/21.2 (gnu/linux)
References: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I'd play with the userspace IRQ-balancer, but booting with
noirqbalance seems not to not balance.  Possibly I misunderstand how
this all fits together.

$ uname -a
Linux peng-33 2.5.68 #1 SMP Sun Apr 20 13:06:57 IST 2003 i686 unknown unknown GNU/Linux
$ cat /proc/cmdline
auto BOOT_IMAGE=default ro root=801 noirqbalance
$ cat /proc/interrupts 
           CPU0       CPU1       
  0:     853487     854900    IO-APIC-edge  timer
  1:          9          4    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  4:      15548      15161    IO-APIC-edge  serial
  8:          2          1    IO-APIC-edge  rtc
  9:          3          2   IO-APIC-level  eth1
 10:       1784       1805   IO-APIC-level  via82cxxx, eth0
 11:      10939      10860   IO-APIC-level  aic7xxx
 12:         39         21    IO-APIC-edge  i8042
NMI:          0          0 
LOC:    1708150    1708149 
ERR:          0
MIS:          0

-- 
Sean Neakums - <sneakums@zork.net>
