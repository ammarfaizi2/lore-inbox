Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272424AbTGZF4d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 01:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272425AbTGZF4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 01:56:33 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:46389 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S272424AbTGZF4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 01:56:30 -0400
Date: Sat, 26 Jul 2003 02:11:36 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: i8042 problem
Message-ID: <20030726021136.A19309@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vojtech:

On my old laptop, i8042 refuses to work with 2.6.0-test1-bk2.
After a reboot, keyboard is dead. Hooking external keyboard
revives the internal keyboard. Here's the dmesg with DEBUG:

Linux version 2.6.0-test1-bk2 (zaitcev@niphredil) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #6 Fri Jul 25 20:28:14 PDT 2003
...
Kernel command line: ro root=/dev/hda1 vga=0x0f05 console=ttyS0,38400
...
hda: 2822400 sectors (1445 MB) w/96KiB Cache, CHS=2800/16/63
 hda: hda1 hda2 hda3
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 45 <- i8042 (return) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: 0f <- i8042 (return) [2]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: a9 <- i8042 (return) [2]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [3]
drivers/input/serio/i8042.c: 5b <- i8042 (return) [3]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [4]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [4]
drivers/input/serio/i8042.c: a5 <- i8042 (return) [4]
drivers/input/serio/i8042.c: a7 -> i8042 (command) [4]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [5]
drivers/input/serio/i8042.c: 74 <- i8042 (return) [5]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [5]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [5]
drivers/input/serio/i8042.c: 54 <- i8042 (return) [5]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [6]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [6]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [6]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [6]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [8]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [8]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [8]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [8]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [13]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [13]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [13]
serio: i8042 AUX port at 0x60,0x64 irq 12
drivers/input/serio/i8042.c: 60 -> i8042 (command) [26]
drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [26]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [28]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [28]
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [28]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [38]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [40]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [40]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [50]
drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [50]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [51]
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
 <------------- This is it, keyboard is dead.
.......
 V---- Trying to hook external keyboard now
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, kbd, 0) [109588]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [109613]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [109613]
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [109614]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109619]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [109639]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [109660]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [109680]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109687]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [109708]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109714]
drivers/input/serio/i8042.c: f8 -> i8042 (kbd-data) [109735]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109742]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [109763]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109770]
drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [109790]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109797]
drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [109818]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109825]
drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [109846]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109852]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [109873]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109879]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [109900]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [109921]
atkbd.c: Unknown key (set 0, scancode 0x2, on isa0060/serio0) pressed.
input: AT Set 2 keyboard on isa0060/serio0
 <----- Now we are talking!

Any ideas?

-- Pete
