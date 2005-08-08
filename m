Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVHHPbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVHHPbE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVHHPbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:31:04 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:22673 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1750936AbVHHPbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:31:03 -0400
Date: Mon, 8 Aug 2005 17:30:16 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Yani Ioannou <yani.ioannou@gmail.com>
cc: LM-Sensors Mailing List <lm-sensors@lm-sensors.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: General Protection Fault with bcmsensors
Message-ID: <Pine.LNX.4.60.0508081716070.24140@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting following general protection fault with bmcsensors and 
i2c-ipmi obtained from today's CVS and with 2.6.13-rc6 kernel. After that 
system doesn't seem to hang immediatelly (as I was able to do the dmesg 
below), however it seems that the internal IPMI watchdog restarted the 
system after a while (or perhaps it did it on its own?), since it did 
reboot then.

---------------
[  957.987401] bmcsensors.o
[  957.998712] i2c-ipmi.o
[  957.998719] i2c-ipmi.o: BMC access for i2c modules initialized.
[  958.001767] ipmi device interface version v33
[  958.004867] IPMI System Interface driver version v33, KCS version v33, SMIC version v33, BT version v33
[  958.005264] ipmi_si: Found SMBIOS-specified state machine at I/O address 0xca2, slave address 0x20
[  959.172987] bmcsensors.o: Registered client, scanning for sensors...
[  959.172995] i2c-ipmi.o: Registered IPMI interface 0 with version 1.5
[  959.451432] IPMI Watchdog: Starting now!
[  959.451445]  IPMI kcs interface initialized
[  987.802234] bmcsensors.o: all sensors detected
[  987.802260] bmcsensors.o: registering sensor 0: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0x003f)
[  987.802264] bmcsensors.o: sensors.conf: label temp1 "Planar Temp 1"
[  987.802267] bmcsensors.o: using upper critical threshold for upper limit
[  987.802270] bmcsensors.o: using lower critical threshold for lower limit
[  987.802279] bmcsensors.o: registering sensor 1: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0x003f)
[  987.802281] bmcsensors.o: sensors.conf: label temp2 "Planar Temp 2"
[  987.802283] bmcsensors.o: using upper critical threshold for upper limit
[  987.802286] bmcsensors.o: using lower critical threshold for lower limit
[  987.802291] bmcsensors.o: registering sensor 2: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0x003f)
[  987.802294] bmcsensors.o: sensors.conf: label temp3 "CPU 2 Temp"
[  987.802296] bmcsensors.o: using upper critical threshold for upper limit
[  987.802298] bmcsensors.o: using lower critical threshold for lower limit
[  987.802306] bmcsensors.o: registering sensor 3: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0x003f)
[  987.802309] bmcsensors.o: sensors.conf: label temp4 "CPU 1 Temp"
[  987.802311] bmcsensors.o: using upper critical threshold for upper limit
[  987.802313] bmcsensors.o: using lower critical threshold for lower limit
[  987.802319] bmcsensors.o: registering sensor 4: (type 0x02) (fmt=0; m=63; b=0; k1=0; k2=13; cap=0x76; mask=0x003f)
[  987.802321] bmcsensors.o: sensors.conf: label in1 "Planar 12V"
[  987.802323] bmcsensors.o: using upper critical threshold for upper limit
[  987.802325] bmcsensors.o: using lower critical threshold for lower limit
[  987.802331] bmcsensors.o: registering sensor 5: (type 0x02) (fmt=0; m=12; b=0; k1=0; k2=13; cap=0x76; mask=0x003f)
[  987.802334] bmcsensors.o: sensors.conf: label in2 "CPU 2 VCore"
[  987.802336] bmcsensors.o: using upper critical threshold for upper limit
[  987.802338] bmcsensors.o: using lower critical threshold for lower limit
[  987.802344] bmcsensors.o: registering sensor 6: (type 0x02) (fmt=0; m=13; b=0; k1=0; k2=13; cap=0x76; mask=0x003f)
[  987.802346] bmcsensors.o: sensors.conf: label in3 "CPU 2 2.5V"
[  987.802348] bmcsensors.o: using upper critical threshold for upper limit
[  987.802350] bmcsensors.o: using lower critical threshold for lower limit
[  987.802356] bmcsensors.o: registering sensor 7: (type 0x02) (fmt=0; m=26; b=0; k1=0; k2=13; cap=0x76; mask=0x003f)
[  987.802359] bmcsensors.o: sensors.conf: label in4 "Planar 5VSB"
[  987.802361] bmcsensors.o: using upper critical threshold for upper limit
[  987.802363] bmcsensors.o: using lower critical threshold for lower limit
[  987.802369] bmcsensors.o: registering sensor 8: (type 0x02) (fmt=0; m=12; b=0; k1=0; k2=13; cap=0x76; mask=0x003f)
[  987.802371] bmcsensors.o: sensors.conf: label in5 "CPU 1 VCore"
[  987.802373] bmcsensors.o: using upper critical threshold for upper limit
[  987.802375] bmcsensors.o: using lower critical threshold for lower limit
[  987.802381] bmcsensors.o: registering sensor 9: (type 0x02) (fmt=0; m=13; b=0; k1=0; k2=13; cap=0x76; mask=0x003f)
[  987.802384] bmcsensors.o: sensors.conf: label in6 "CPU 1 2.5V"
[  987.802386] bmcsensors.o: using upper critical threshold for upper limit
[  987.802388] bmcsensors.o: using lower critical threshold for lower limit
[  987.802393] bmcsensors.o: registering sensor 10: (type 0x02) (fmt=0; m=26; b=0; k1=0; k2=13; cap=0x76; mask=0x003f)
[  987.802396] bmcsensors.o: sensors.conf: label in7 "Planar 5V"
[  987.802398] bmcsensors.o: using upper critical threshold for upper limit
[  987.802400] bmcsensors.o: using lower critical threshold for lower limit
[  987.802406] bmcsensors.o: registering sensor 11: (type 0x04) (fmt=0; m=29; b=0; k1=0; k2=9; cap=0x76; mask=0x003f)
[  987.802409] bmcsensors.o: sensors.conf: label fan1 "Fan 2 Tach"
[  987.802411] bmcsensors.o: using lower critical threshold for upper limit
[  987.802413] bmcsensors.o: using upper critical threshold for lower limit
[  987.802418] bmcsensors.o: registering sensor 12: (type 0x04) (fmt=0; m=29; b=0; k1=0; k2=9; cap=0x76; mask=0x003f)
[  987.802421] bmcsensors.o: sensors.conf: label fan2 "Fan 4 Tach"
[  987.802423] bmcsensors.o: using lower critical threshold for upper limit
[  987.802425] bmcsensors.o: using upper critical threshold for lower limit
[  987.802432] bmcsensors.o: registering sensor 13: (type 0x04) (fmt=0; m=29; b=0; k1=0; k2=9; cap=0x76; mask=0x003f)
[  987.802435] bmcsensors.o: sensors.conf: label fan3 "Fan 1 Tach"
[  987.802437] bmcsensors.o: using lower critical threshold for upper limit
[  987.802439] bmcsensors.o: using upper critical threshold for lower limit
[  987.802444] bmcsensors.o: registering sensor 14: (type 0x04) (fmt=0; m=29; b=0; k1=0; k2=9; cap=0x76; mask=0x003f)
[  987.802447] bmcsensors.o: sensors.conf: label fan4 "Fan 3 Tach"
[  987.802449] bmcsensors.o: using lower critical threshold for upper limit
[  987.802451] bmcsensors.o: using upper critical threshold for lower limit
[  987.802457] bmcsensors.o: registering sensor 15: (type 0x04) (fmt=0; m=29; b=0; k1=0; k2=9; cap=0x76; mask=0x003f)
[  987.802459] bmcsensors.o: sensors.conf: label fan5 "Fan 5 Tach"
[  987.802461] bmcsensors.o: using lower critical threshold for upper limit
[  987.802463] bmcsensors.o: using upper critical threshold for lower limit
[  987.802468] bmcsensors.o: 0 reservations cancelled
[  987.802470] bmcsensors.o: registered 4 temp, 7 volt, 0 current, 5 fan sensors
[  987.802472] bmcsensors.o: bmcsensor thread done
[ 1007.059503] general protection fault: 0000 [1] SMP
[ 1007.059511] CPU 1
[ 1007.059514] Modules linked in: ipmi_si ipmi_devintf i2c_ipmi bmcsensors i2c_isa i2c_amd756 nfsd exportfs lockd nfs_acl parport_pc lp parport 
autofs4 sunrpc powernow_k8 freq_table binfmt_misc dm_mod video thermal processor hotkey fan container button battery ac ipv6 usbkbd usbhid 
ohci_hcd i2c_amd8111 i2c_core hw_random shpchp tg3 ide_cd cdrom sg usbcore ext3 jbd sd_mod
[ 1007.059533] Pid: 3655, comm: sensors Not tainted 2.6.13-rc6
[ 1007.059535] RIP: 0010:[<ffffffff801fed50>] <ffffffff801fed50>{strcmp+0}
[ 1007.059547] RSP: 0018:ffff810071653cb0  EFLAGS: 00010246
[ 1007.059552] RAX: ffff000a36343735 RBX: ffff81003596f608 RCX: ffff8100328f96d0
[ 1007.059555] RDX: 0000000000000037 RSI: ffff8100710ac9cc RDI: ffff000a36343735
[ 1007.059560] RBP: ffff8100328f9680 R08: 000003fa892e45c7 R09: ffff81003535301c
[ 1007.059563] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8100710ac910
[ 1007.059567] R13: ffff810071653d48 R14: ffff810036776d70 R15: ffff810076d33bf0
[ 1007.059571] FS:  00002aaaaaad9e40(0000) GS:ffffffff80541880(0000) knlGS:00000000627c2bb0
[ 1007.059574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1007.059577] CR2: 00002aaaadb48000 CR3: 0000000071725000 CR4: 00000000000006e0
[ 1007.059581] Process sensors (pid: 3655, threadinfo ffff810071652000, task ffff810035c58a20)
[ 1007.059583] Stack: ffffffff801c59d1 ffff8100710ac910 ffff810071653ed8 ffff810071653d38
[ 1007.059590]        ffff810071653d48 ffff810036776d70 ffffffff80192565 000001b600008001
[ 1007.059596]        ffff810037ff7080 ffff810036776cb0
[ 1007.059599] Call Trace:<ffffffff801c59d1>{sysfs_lookup+81} <ffffffff80192565>{do_lookup+245}
[ 1007.059614]        <ffffffff80193076>{__link_path_walk+2582} <ffffffff80193659>{link_path_walk+137}
[ 1007.059626]        <ffffffff801818b3>{get_unused_fd+227} <ffffffff8014a509>{remove_wait_queue+25}
[ 1007.059640]        <ffffffff80193c9d>{path_lookup+461} <ffffffff801951cc>{open_namei+172}
[ 1007.059649]        <ffffffff8025867a>{tty_ldisc_deref+122} <ffffffff8018261d>{filp_open+45}
[ 1007.059660]        <ffffffff80182712>{sys_open+82} <ffffffff8010dcf2>{system_call+126}
[ 1007.059673]
[ 1007.059678]
[ 1007.059678] Code: 0f b6 17 89 d0 2a 06 48 ff c6 84 c0 74 04 0f be c0 c3 48 ff
[ 1007.059687] RIP <ffffffff801fed50>{strcmp+0} RSP <ffff810071653cb0>
[ 1007.059693]
---------------

Martin

