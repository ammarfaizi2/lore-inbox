Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTGTOOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 10:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266924AbTGTOOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 10:14:51 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:40662 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261151AbTGTOOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 10:14:49 -0400
Message-ID: <3F1AA75B.6010405@blueyonder.co.uk>
Date: Sun, 20 Jul 2003 15:29:47 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suse-linux-e@suse.com, linux-kernel@vger.kernel.org
Subject: 2.4.22-pre7 Kernel oops in modprobe on SuSE 8.2 Athlon XP2200+/512Meg
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070006060206050408000703"
X-OriginalArrivalTime: 20 Jul 2003 14:29:48.0156 (UTC) FILETIME=[5F59E3C0:01C34ECB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070006060206050408000703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	I have been getting something similar with all kernels after about 
2.4.21-pre7-ac1. Switching to SuSE 8.2, the SuSE 2.4.20-4GB kernel and a 
modded kernel to include CH PRODUCTS Flight Control yoke and pedals work 
fine. All others up to 2.4.22-pre7 just halt needing a hardware reset, 
the ALT-SYSRQ keys do not work. CTRL-ALT-DEL gets as far as stopping 
HOTPLUG services and locks up with no oops displayed.
	Attached is an extract from /var/log/messages.
Regards
Sid.

-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop

--------------070006060206050408000703
Content-Type: text/plain;
 name="pre7-segfault"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pre7-segfault"

Jul 20 14:41:46 barrabas kernel: printer.c: usblp0: USB Unidirectional printer dev 3 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0604
Jul 20 14:41:46 barrabas kernel: printer.c: v0.11: USB Printer Device Class driver
Jul 20 14:41:46 barrabas insmod: Using /lib/modules/2.4.22-pre7/kernel/drivers/usb/printer.o
Jul 20 14:41:46 barrabas insmod: Symbol version prefix ''
Jul 20 14:41:46 barrabas kernel: Device not ready.  Make sure there is a disc in the drive.
Jul 20 14:41:50 barrabas kernel: usb.c: registered new driver hiddev
Jul 20 14:41:50 barrabas kernel: usb.c: registered new driver hid
Jul 20 14:41:50 barrabas kernel: hid-core.c: hid_init_reports usb_set_idle()=-911
Jul 20 14:41:50 barrabas kernel: Unable to handle kernel paging request at virtual address 47220100
Jul 20 14:41:50 barrabas kernel:  printing eip:
Jul 20 14:41:50 barrabas kernel: e0c21da7
Jul 20 14:41:50 barrabas kernel: *pde = 00000000
Jul 20 14:41:50 barrabas kernel: Oops: 0000
Jul 20 14:41:50 barrabas kernel: CPU:    0
Jul 20 14:41:50 barrabas kernel: EIP:    0010:[<e0c21da7>]    Not tainted
Jul 20 14:41:50 barrabas kernel: EFLAGS: 00010286
Jul 20 14:41:50 barrabas kernel: eax: 00000034   ebx: 47220100   ecx: dea12000   edx: de8fdf7c
Jul 20 14:41:50 barrabas kernel: esi: de599000   edi: de5ec644   ebp: 00000000   esp: dea13e0c
Jul 20 14:41:50 barrabas kernel: ds: 0018   es: 0018   ss: 0018
Jul 20 14:41:50 barrabas kernel: Process modprobe.old (pid: 1140, stackpage=dea13000)
Jul 20 14:41:50 barrabas kernel: Stack: e0c250a0 fffffc71 00000000 de599000 de5ec640 de599000 e0c257e0 de5ec600
Jul 20 14:41:50 barrabas kernel:        00000000 e0c222bf de599000 00000000 dff0aa90 c0156464 dce56500 00001032
Jul 20 14:41:50 barrabas kernel:        dff0aa90 00000000 e0c1ec60 e0c25780 e0c257e0 de5ec600 00000000 e0bd4dd6
Jul 20 14:41:50 barrabas kernel: Call Trace:    [<e0c250a0>] [<e0c257e0>] [<e0c222bf>] [get_new_inode+372/416] [<e0c1ec60>]
Jul 20 14:41:50 barrabas kernel: Call Trace:    [<e0c250a0>] [<e0c257e0>] [<e0c222bf>] [<c0156464>] [<e0c1ec60>]
Jul 20 14:41:50 barrabas kernel:   [<e0c25780>] [<e0c257e0>] [st:__insmod_st_O/lib/modules/2.4.22-pre7/kernel/drivers/scsi/s+
-258602/96] [<e0c25780>] [<e0c257c0>] [st:__insmod_st_O/lib/modules/2.4.22-pre7/kernel/drivers/scsi/s+-199840/96]
Jul 20 14:41:50 barrabas kernel:   [<e0c25780>] [<e0c257e0>] [<e0bd4dd6>] [<e0c25780>] [<e0c257c0>] [<e0be3360>]
Jul 20 14:41:50 barrabas kernel:   [st:__insmod_st_O/lib/modules/2.4.22-pre7/kernel/drivers/scsi/s+-259365/96] [st:__insmod_s
t_O/lib/modules/2.4.22-pre7/kernel/drivers/scsi/s+-259414/96] [st:__insmod_st_O/lib/modules/2.4.22-pre7/kernel/drivers/scsi/s
+-259414/96] [st:__insmod_st_O/lib/modules/2.4.22-pre7/kernel/drivers/scsi/s+-198432/96] [st:__insmod_st_O/lib/modules/2.4.22
-pre7/kernel/drivers/scsi/s+-261834/96] [<e0c257c0>]
Jul 20 14:41:50 barrabas kernel:   [<e0bd4adb>] [<e0bd4aaa>] [<e0bd4aaa>] [<e0be38e0>] [<e0bd4136>] [<e0c257c0>]
Jul 20 14:41:50 barrabas kernel:   [<e0c254e0>] [st:__insmod_st_O/lib/modules/2.4.22-pre7/kernel/drivers/scsi/s+-261927/96] [
st:__insmod_st_O/lib/modules/2.4.22-pre7/kernel/drivers/scsi/s+-211872/96] [<e0c24ff5>] [<e0c239d9>] [<e0c22484>]
Jul 20 14:41:50 barrabas kernel:   [<e0c254e0>] [<e0bd40d9>] [<e0be0460>] [<e0c24ff5>] [<e0c239d9>] [<e0c22484>]
Jul 20 14:41:50 barrabas kernel:   [<e0c257c0>] [sys_init_module+1679/1824] [<e0c20060>] [<e0c254c8>] [<e0c20060>] [system_ca
ll+51/56]
Jul 20 14:41:50 barrabas kernel:   [<e0c257c0>] [<c011f60f>] [<e0c20060>] [<e0c254c8>] [<e0c20060>] [<c010906f>]
Jul 20 14:41:50 barrabas kernel:
Jul 20 14:41:50 barrabas kernel: Code: 8b 1b 39 fb 74 73 8b 8e 44 0c 00 00 66 81 b9 d4 00 00 00 8e
Jul 20 14:41:50 barrabas /etc/hotplug/usb.agent[1114]: /etc/hotplug/usb.agent: line 442:  1140 Segmentation fault      $MODPR
OBE $MODULE >/dev/null 2>&1
Jul 20 14:41:50 barrabas /etc/hotplug/usb.agent[1114]: ... can't load module hid
Jul 20 14:41:50 barrabas /etc/hotplug/usb.agent[1114]: missing kernel or user mode driver hid


--------------070006060206050408000703--

