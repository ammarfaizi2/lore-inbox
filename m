Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVALSqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVALSqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVALSpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:45:05 -0500
Received: from dhcp18-126.bio.purdue.edu ([128.210.18.126]:13952 "EHLO
	lapdog.ravenhome.net") by vger.kernel.org with ESMTP
	id S261228AbVALSoE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:44:04 -0500
From: Praedor Atrebates <praedor@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel paging request
Date: Wed, 12 Jan 2005 13:43:59 -0500
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501121343.59427.praedor@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me any answer you might have to offer me as I am not subscribed to 
the list.  

I am running Mandrake 10.1 on a Gateway Solo laptop, Pentium M, ATI Radeon 
9000, firewire, builtin e1000 ethernet.  Kernel is 2.6.8.1-12mdk.  I have 
lately been running into a tremendous problem with kernel paging request 
errors/Oops's at seemingly random moments.  Right now I am running a 
2.6.0-rc2.2mdk kernel because under the 2.6.8.1 kernel the errors were 
happening so often that the system was unusable for any length of time.  I am 
virtually certain to see one upon shutdown even with the current running 
kernel as well.  The latest such error produced this:

Jan 12 10:31:09 dhcp18-126 kernel: NET: Unregistered protocol family 23
Jan 12 10:32:19 dhcp18-126 kernel: Unable to handle kernel paging request at 
virtual address d56c34ac
Jan 12 10:32:19 dhcp18-126 kernel:  printing eip:
Jan 12 10:32:19 dhcp18-126 kernel: c01294a3
Jan 12 10:32:19 dhcp18-126 kernel: *pde = 0e1a6067
Jan 12 10:32:19 dhcp18-126 kernel: *pte = 00000000
Jan 12 10:32:19 dhcp18-126 kernel: Oops: 0000 [#1]
Jan 12 10:32:19 dhcp18-126 kernel: Modules linked in: crc-ccitt sg st sr_mod 
sd_mod scsi_mod fglrx exportfs lockd sunrpc md5 ipv6 snd-seq-oss 
snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-intel8x0 
snd-ac97-codec snd-pcm snd-timer snd-page-alloc gameport snd-mpu401-uart 
snd-rawmidi snd-seq-device snd soundcore parport_pc lp parport driverloader 
af_packet floppy ds yenta_socket pcmcia_core eth1394 e1000 tulip raw ide-cd 
cdrom ohci1394 ieee1394 loop nls_iso8859-1 ntfs ext3 jbd intel-agp agpgart 
nvram evdev ehci-hcd uhci-hcd usbcore rtc reiserfs
Jan 12 10:32:19 dhcp18-126 kernel: CPU:    0
Jan 12 10:32:19 dhcp18-126 kernel: EIP:    0060:[notifier_call_chain+35/64]    
Tainted: P   VLI
Jan 12 10:32:19 dhcp18-126 kernel: EIP:    0060:[<c01294a3>]    Tainted: P   
VLI
Jan 12 10:32:19 dhcp18-126 kernel: EFLAGS: 00010286   (2.6.8.1-12mdk)
Jan 12 10:32:19 dhcp18-126 kernel: EIP is at notifier_call_chain+0x23/0x40
Jan 12 10:32:19 dhcp18-126 kernel: eax: 00000001   ebx: d56c34ac   ecx: 
00000000   edx: 00000001
Jan 12 10:32:20 dhcp18-126 kernel: esi: cf264800   edi: 00000006   ebp: 
c3eade7c   esp: c3eade64
Jan 12 10:32:20 dhcp18-126 kernel: ds: 007b   es: 007b   ss: 0068
Jan 12 10:32:20 dhcp18-126 kernel: Process rmmod (pid: 3956, 
threadinfo=c3eac000 task=c253a0b0)
Jan 12 10:32:20 dhcp18-126 kernel: Stack: d56c34ac 00000006 cf264800 cf264800 
cf264800 cf264938 c3eadea4 c02769a2
Jan 12 10:32:20 dhcp18-126 kernel:        c03e5520 00000006 cf264800 d0ee1cae 
cf264938 cf264800 cc40ec98 ccf64000
Jan 12 10:32:20 dhcp18-126 kernel:        c3eadeb4 c0220537 cf264800 cf264a20 
c3eaded8 d0f7cb9f cf264800 ccf64000
Jan 12 10:32:20 dhcp18-126 kernel: Call Trace:
Jan 12 10:32:20 dhcp18-126 kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
Jan 12 10:32:20 dhcp18-126 kernel:  [<c0107bbf>] show_stack+0x7f/0xa0
Jan 12 10:32:20 dhcp18-126 kernel:  [show_registers+342/464] 
show_registers+0x156/0x1d0
Jan 12 10:32:20 dhcp18-126 kernel:  [<c0107d56>] show_registers+0x156/0x1d0
Jan 12 10:32:20 dhcp18-126 kernel:  [die+102/208] die+0x66/0xd0
Jan 12 10:32:20 dhcp18-126 kernel:  [<c0107ef6>] die+0x66/0xd0
Jan 12 10:32:20 dhcp18-126 kernel:  [do_page_fault+966/1456] 
do_page_fault+0x3c6/0x5b0
Jan 12 10:32:20 dhcp18-126 kernel:  [<c0119b26>] do_page_fault+0x3c6/0x5b0
Jan 12 10:32:20 dhcp18-126 kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 12 10:32:20 dhcp18-126 kernel:  [<c0107849>] error_code+0x2d/0x38
Jan 12 10:32:20 dhcp18-126 kernel:  [unregister_netdevice+338/606] 
unregister_netdevice+0x152/0x25e
Jan 12 10:32:20 dhcp18-126 kernel:  [<c02769a2>] 
unregister_netdevice+0x152/0x25e
Jan 12 10:32:20 dhcp18-126 kernel:  [unregister_netdev+23/32] 
unregister_netdev+0x17/0x20
Jan 12 10:32:20 dhcp18-126 kernel:  [<c0220537>] unregister_netdev+0x17/0x20
Jan 12 10:32:20 dhcp18-126 kernel:  [pg0+280554399/1069613056] 
ether1394_remove_host+0x6f/0x90 [eth1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [<d0f7cb9f>] 
ether1394_remove_host+0x6f/0x90 [eth1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [pg0+279897277/1069613056] 
__unregister_host+0x8d/0xc0 [ieee1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [<d0edc4bd>] __unregister_host+0x8d/0xc0 
[ieee1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [pg0+279897361/1069613056] 
highlevel_for_each_host_unreg+0x21/0x30 [ieee1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [<d0edc511>] 
highlevel_for_each_host_unreg+0x21/0x30 [ieee1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [pg0+279917671/1069613056] 
nodemgr_for_each_host+0x47/0x80 [ieee1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [<d0ee1467>] 
nodemgr_for_each_host+0x47/0x80 [ieee1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [pg0+279897499/1069613056] 
hpsb_unregister_highlevel+0x7b/0x90 [ieee1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [<d0edc59b>] 
hpsb_unregister_highlevel+0x7b/0x90 [ieee1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [pg0+280562478/1069613056] 
ether1394_exit_module+0x1e/0x2d [eth1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [<d0f7eb2e>] 
ether1394_exit_module+0x1e/0x2d [eth1394]
Jan 12 10:32:20 dhcp18-126 kernel:  [sys_delete_module+306/384] 
sys_delete_module+0x132/0x180
Jan 12 10:32:20 dhcp18-126 kernel:  [<c0131902>] sys_delete_module+0x132/0x180
Jan 12 10:32:20 dhcp18-126 kernel:  [sysenter_past_esp+82/113] 
sysenter_past_esp+0x52/0x71
Jan 12 10:32:20 dhcp18-126 kernel:  [<c0106dcd>] sysenter_past_esp+0x52/0x71
Jan 12 10:32:20 dhcp18-126 kernel: Code: b8 fe ff ff ff c3 89 f6 55 31 d2 89 
e5 57 56 53 83 ec 0c 8b 45 08 8b 7d 0c 8b 75 10 8b 18 eb 19 89 74 24 08 89 7c 
24 04 89 1c 24 <ff> 13 a9 00 80 00 00 89 c2 75 07 8b 5b 04 85 db 75 e3 83 c4 
0c

A previous such error (very brief) produced:

Jan  6 14:23:17 lapdog kernel: NET: Registered protocol family 4
Jan  6 14:23:17 lapdog kernel: Unable to handle kernel paging request at 
virtual
 address d0bb24b4
Jan  6 14:23:17 lapdog kernel:  printing eip:
Jan  6 14:23:17 lapdog kernel: c012942f
Jan  6 14:23:17 lapdog kernel: *pde = 012f3067
Jan  6 14:23:17 lapdog kernel: *pte = 00000000
Jan  6 14:23:17 lapdog kernel: Oops: 0000 [#2]

The same hex address region is involved.  From my system map the above two 
addresses fall between inter_module_unregister in my system map 
(c0129460) and before inter_module_get (c0129520).

Is this indicative of a hardware problem or a software problem?  I have booted 
up with memtest86+ and let it run for about an hour (couldn't afford to let 
it go longer at that point) and it found no problems at all.  

Thank you for any aid you can toss my way.

praedor
