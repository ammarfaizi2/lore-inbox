Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUGFPnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUGFPnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUGFPnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 11:43:09 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:3510 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S264045AbUGFPm5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 11:42:57 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: crash city this morning
Date: Tue, 6 Jul 2004 11:42:55 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407061142.56009.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.57.221] at Tue, 6 Jul 2004 10:42:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

While running 2.6.7-mm6, my mouse usb has now powered itself down 2 
times, requireing a reboot to recover, and this last time I rebooted 
to 2.6.7 plain, but have had at least 3 pieces of kde do an exit 
since doing so.

>From my messages log, the second time the mouse died:

Jul  6 11:20:46 coyote kernel: usb 1-1: USB disconnect, address 2
Jul  6 11:20:46 coyote kernel: Unable to handle kernel NULL pointer 
dereference at virtual
 address 0000002c
Jul  6 11:20:46 coyote kernel:  printing eip:
Jul  6 11:20:46 coyote kernel: c0274290
Jul  6 11:20:46 coyote kernel: *pde = 00000000
Jul  6 11:20:46 coyote kernel: Oops: 0000 [#1]
Jul  6 11:20:46 coyote kernel: PREEMPT
Jul  6 11:20:46 coyote kernel: Modules linked in: nvidia snd_seq_oss 
snd_seq_midi_event sn
d_seq snd_pcm_oss snd_mixer_oss snd_via82xx snd_ac97_codec snd_pcm 
snd_timer snd_page_allo
c snd_mpu401_uart snd_rawmidi snd_seq_device snd ohci1394 ieee1394 sg 
st
Jul  6 11:20:46 coyote kernel: CPU:    0
Jul  6 11:20:46 coyote kernel: EIP:    0060:[<c0274290>]    Tainted: P   
VLI
Jul  6 11:20:46 coyote kernel: EFLAGS: 00010246   (2.6.7-mm6)
Jul  6 11:20:46 coyote kernel: EIP is at usb_unlink_urb+0x0/0x40
Jul  6 11:20:46 coyote kernel: eax: 00000000   ebx: dff82000   ecx: 
dfc0c16c   edx: c15ca7
e8
Jul  6 11:20:46 coyote kernel: esi: c03a2540   edi: dffd3600   ebp: 
dffd83c0   esp: c1542e
b0
Jul  6 11:20:46 coyote kernel: ds: 007b   es: 007b   ss: 0068
Jul  6 11:20:46 coyote kernel: Process khubd (pid: 23, 
threadinfo=c1542000 task=c15696d0)
Jul  6 11:20:46 coyote kernel: Stack: c0284dbc dffb48a0 c026ed0e 
dffb48b4 c03a2560 c0207fa
6 dffb48b4 dffd36c4
Jul  6 11:20:46 coyote kernel:        c02081d2 dffb48b4 dffd36c4 
c02071ba 00000001 dffb48a
0 c02753ff dffd3800
Jul  6 11:20:46 coyote kernel:        00000010 dffd3600 c0270ed8 
c032c500 c03122ba dffd371
c 00000002 00000003
Jul  6 11:20:46 coyote kernel: Call Trace:
Jul  6 11:20:46 coyote kernel:  [<c0284dbc>] hid_disconnect+0x2c/0xa0
Jul  6 11:20:46 coyote kernel:  [<c026ed0e>] 
usb_unbind_interface+0x6e/0x70
Jul  6 11:20:46 coyote kernel:  [<c0207fa6>] 
device_release_driver+0x56/0x60
Jul  6 11:20:46 coyote kernel:  [<c02081d2>] 
bus_remove_device+0x52/0x90
Jul  6 11:20:46 coyote kernel:  [<c02071ba>] device_del+0x5a/0x90
Jul  6 11:20:46 coyote kernel:  [<c02753ff>] 
usb_disable_device+0x9f/0xe0
Jul  6 11:20:46 coyote kernel:  [<c0270ed8>] usb_disconnect+0x98/0x120
Jul  6 11:20:46 coyote kernel:  [<c0271d6b>] 
hub_port_connect_change+0x36b/0x390
Jul  6 11:20:46 coyote kernel:  [<c0271fc3>] hub_events+0x233/0x340
Jul  6 11:20:46 coyote kernel:  [<c0272105>] hub_thread+0x35/0x110
Jul  6 11:20:46 coyote kernel:  [<c01132b0>] 
autoremove_wake_function+0x0/0x50
Jul  6 11:20:46 coyote kernel:  [<c0103c5e>] ret_from_fork+0x6/0x14
Jul  6 11:20:46 coyote kernel:  [<c01132b0>] 
autoremove_wake_function+0x0/0x50
Jul  6 11:20:46 coyote kernel:  [<c02720d0>] hub_thread+0x0/0x110
Jul  6 11:20:46 coyote kernel:  [<c010213d>] 
kernel_thread_helper+0x5/0x18
Jul  6 11:20:46 coyote kernel: Code: 0b 83 e0 03 40 0f af e8 e9 ee fe 
ff ff c1 f8 0f 83 e0
 0f 8b 6c 83 3c e9 c4 fe ff ff b8 ed ff ff ff e9 50 ff ff ff 90 8d 74 
26 00 <f6> 40 2c 10
74 2a 8b 50 20 85 d2 74 11 8b 92 c0 00 00 00 85 d2
Jul  6 11:21:22 coyote login(pam_unix)[2546]: session opened for user 
root by LOGIN(uid=0)
Jul  6 11:21:22 coyote  -- root[2546]: ROOT LOGIN ON tty2
Jul  6 11:21:31 coyote gpm: gpm shutdown succeeded
Jul  6 11:21:31 coyote gpm: gpm startup succeeded

This didn't restart the mouse;

Jul  6 11:23:15 coyote kernel:  <7>mtrr: no MTRR for d0000000,2000000 
found

Is this related?

Jul  6 11:23:28 coyote shutdown: shutting down for system reboot
Jul  6 11:23:28 coyote init: Switching to runlevel: 6
---------------
at which point I rebooted to 2.6.7, reset my XF86Config to use the 
old, known stable nv driver, but when startx was run, I got crash 
notices from several pieces of kde, and a ctl+d to end a shell just 
made another crash notice.  Signal 11's, all of them.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
