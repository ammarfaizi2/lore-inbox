Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVAMJJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVAMJJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 04:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVAMJJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 04:09:01 -0500
Received: from venus.vidconference.de ([212.227.158.183]:24267 "EHLO
	baldur.vidconference.de") by vger.kernel.org with ESMTP
	id S261318AbVAMJII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 04:08:08 -0500
Message-ID: <41E63A75.1020107@vidsoft.de>
Date: Thu, 13 Jan 2005 10:08:05 +0100
From: Gregor Jasny <jasny@vidsoft.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alsa-devel@lists.sourceforge.net
Subject: Linux 2.6.10 OOPS
Content-Type: multipart/mixed;
 boundary="------------080302020901030104070407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080302020901030104070407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

After removing an USB webcam with a built-in microphone (snd-usb-audio) 
the kernel oopsed and the PS/2 keyboard wasn't working anymore.

The Webcam is a Phillips 680 with pwc 10.0.6a (from Luc Saillard).

I've attached the decoded oops.

Cheers,
Gregor

--------------080302020901030104070407
Content-Type: text/plain;
 name="snd-oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snd-oops.txt"

Jan  6 10:30:50 dell1 kernel: usb 2-1: USB disconnect, address 2
Jan  6 10:30:51 dell1 udev[10422]: removing device node '/dev/video1'
Jan  6 10:30:51 dell1 udev[10430]: removing device node '/dev/dsp2'
Jan  6 10:30:51 dell1 udev[10434]: removing device node '/dev/audio2'
Jan  6 10:30:51 dell1 udev[10425]: removing device node '/dev/mixer2'
Jan  6 10:36:29 dell1 kernel: usb 1-2: new full speed USB device using uhci_hcd and address 2
Jan  6 10:36:30 dell1 kernel: Bluetooth: HCI USB driver ver 2.7
Jan  6 10:36:30 dell1 kernel: usbcore: registered new driver hci_usb
Jan  6 10:36:30 dell1 hcid[3447]: HCI dev 0 registered
Jan  6 10:36:30 dell1 usb.agent[10507]:      hci_usb: loaded successfully
Jan  6 10:36:30 dell1 usb.agent[10518]:      hci_usb: loaded successfully
Jan  6 10:36:30 dell1 hcid[3447]: HCI dev 0 up
Jan  6 10:36:30 dell1 hcid[3447]: Starting security manager 0
Jan  6 10:41:06 dell1 kernel: nsm_mon_unmon: rpc failed, status=-110
Jan  6 10:41:06 dell1 kernel: lockd: cannot unmonitor 192.168.1.3
Jan  6 10:41:06 dell1 kernel: RPC: error 5 connecting to server localhost
Jan  6 10:41:06 dell1 kernel: nsm_mon_unmon: rpc failed, status=-5
Jan  6 10:41:06 dell1 kernel: lockd: cannot monitor 192.168.1.3
Jan  6 10:41:06 dell1 kernel: lockd: failed to monitor 192.168.1.3
Jan  6 10:41:45 dell1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan  6 10:41:45 dell1 kernel:  printing eip:
Jan  6 10:41:45 dell1 kernel: c01c3fa6
Jan  6 10:41:45 dell1 kernel: *pde = 2c466067
Jan  6 10:41:45 dell1 kernel: *pte = 00000000
Jan  6 10:41:45 dell1 kernel: Oops: 0000 [#1]
Jan  6 10:41:45 dell1 kernel: Modules linked in: hci_usb loop bridge tun dummy rfcomm l2cap bluetooth parport_pc lp parport snd_usb_audio snd_usb_lib snd_b
t87x uhci_hcd hw_random pc87360 eeprom i2c_sensor i2c_isa i2c_i801 ov511 ovcamchip pwc usbcore tuner tvaudio bttv video_buf firmware_class i2c_algo_bit v4l
2_common btcx_risc i2c_core videodev snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_pa
ge_alloc
Jan  6 10:41:45 dell1 kernel: CPU:    0
Jan  6 10:41:45 dell1 kernel: EIP:    0060:[get_kobj_path_length+38/64]    Not tainted VLI
Jan  6 10:41:45 dell1 kernel: EFLAGS: 00010246   (2.6.10)
Jan  6 10:41:45 dell1 kernel: EIP is at get_kobj_path_length+0x26/0x40
Jan  6 10:41:45 dell1 kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: eb3468e8
Jan  6 10:41:45 dell1 kernel: esi: 00000001   edi: 00000000   ebp: ffffffff   esp: eff27d7c
Jan  6 10:41:45 dell1 kernel: ds: 007b   es: 007b   ss: 0068
Jan  6 10:41:45 dell1 kernel: Process events/0 (pid: 3, threadinfo=eff26000 task=c16f1020)
Jan  6 10:41:45 dell1 kernel: Stack: c036c980 eb3468c4 edc24a98 eb3468e8 c01c403f eb3468e8 c16e6f78 00000000
Jan  6 10:41:45 dell1 kernel:        eb346600 c036c980 eb3468c4 edc24a98 ed88180c c022994c eb3468e8 000000d0
Jan  6 10:41:45 dell1 kernel:        c036c980 edc24a80 ee4a382c c036c968 c01c7708 ee4a382c 00000000 00000000
Jan  6 10:41:45 dell1 kernel: Call Trace:
Jan  6 10:41:45 dell1 kernel:  [kobject_get_path+31/128] kobject_get_path+0x1f/0x80
Jan  6 10:41:45 dell1 kernel:  [class_hotplug+156/416] class_hotplug+0x9c/0x1a0
Jan  6 10:41:45 dell1 kernel:  [vsprintf+40/48] vsprintf+0x28/0x30
Jan  6 10:41:45 dell1 kernel:  [kobject_hotplug+486/720] kobject_hotplug+0x1e6/0x2d0
Jan  6 10:41:45 dell1 kernel:  [kobject_del+28/64] kobject_del+0x1c/0x40
Jan  6 10:41:45 dell1 kernel:  [class_device_del+152/192] class_device_del+0x98/0xc0
Jan  6 10:41:45 dell1 kernel:  [class_device_unregister+19/48] class_device_unregister+0x13/0x30
Jan  6 10:41:45 dell1 kernel:  [pg0+810058970/1069622272] snd_unregister_device+0x9a/0xf0 [snd]
Jan  6 10:41:45 dell1 kernel:  [pg0+810219216/1069622272] snd_pcm_dev_unregister+0x60/0xf0 [snd_pcm]
Jan  6 10:41:45 dell1 kernel:  [pg0+810079047/1069622272] snd_device_free+0xa7/0xc0 [snd]
Jan  6 10:41:45 dell1 kernel:  [pg0+810079632/1069622272] snd_device_free_all+0x60/0x70 [snd]
Jan  6 10:41:45 dell1 kernel:  [pg0+810061088/1069622272] snd_card_free_thread+0x0/0x80 [snd]
Jan  6 10:41:45 dell1 kernel:  [pg0+810060780/1069622272] snd_card_free+0x11c/0x250 [snd]
Jan  6 10:41:45 dell1 kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Jan  6 10:41:45 dell1 kernel:  [schedule+702/1248] schedule+0x2be/0x4e0
Jan  6 10:41:45 dell1 kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Jan  6 10:41:45 dell1 kernel:  [pg0+810061132/1069622272] snd_card_free_thread+0x2c/0x80 [snd]
Jan  6 10:41:45 dell1 kernel:  [worker_thread+429/592] worker_thread+0x1ad/0x250
Jan  6 10:41:45 dell1 kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jan  6 10:41:45 dell1 kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jan  6 10:41:45 dell1 kernel:  [worker_thread+0/592] worker_thread+0x0/0x250
Jan  6 10:41:45 dell1 kernel:  [kthread+170/176] kthread+0xaa/0xb0
Jan  6 10:41:45 dell1 kernel:  [kthread+0/176] kthread+0x0/0xb0
Jan  6 10:41:45 dell1 kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Jan  6 10:41:45 dell1 kernel: Code: 90 8d 74 26 00 55 bd ff ff ff ff 57 56 be 01 00 00 00 53 8b 54 24 14 31 db 8d b6 00 00 00 00 8d bf 00 00 00 00 8b 3a 89
 e9 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e 5f


symoops 2.4.9 on i686 2.6.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10/ (default)
     -m /boot/System.map-2.6.10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan  6 10:41:45 dell1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan  6 10:41:45 dell1 kernel: c01c3fa6
Jan  6 10:41:45 dell1 kernel: *pde = 2c466067
Jan  6 10:41:45 dell1 kernel: Oops: 0000 [#1]
Jan  6 10:41:45 dell1 kernel: CPU:    0
Jan  6 10:41:45 dell1 kernel: EIP:    0060:[get_kobj_path_length+38/64]    Not tainted VLI
Jan  6 10:41:45 dell1 kernel: EFLAGS: 00010246   (2.6.10)
Jan  6 10:41:45 dell1 kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: eb3468e8
Jan  6 10:41:45 dell1 kernel: esi: 00000001   edi: 00000000   ebp: ffffffff   esp: eff27d7c
Jan  6 10:41:45 dell1 kernel: ds: 007b   es: 007b   ss: 0068
Jan  6 10:41:45 dell1 kernel: Stack: c036c980 eb3468c4 edc24a98 eb3468e8 c01c403f eb3468e8 c16e6f78 00000000
Jan  6 10:41:45 dell1 kernel:        eb346600 c036c980 eb3468c4 edc24a98 ed88180c c022994c eb3468e8 000000d0
Jan  6 10:41:45 dell1 kernel:        c036c980 edc24a80 ee4a382c c036c968 c01c7708 ee4a382c 00000000 00000000
Jan  6 10:41:45 dell1 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>ecx; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>edx; eb3468e8 <pg0+2af5a8e8/3fc12400>
>>ebp; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>esp; eff27d7c <pg0+2fb3bd7c/3fc12400>

Jan  6 10:41:45 dell1 kernel: Code: 90 8d 74 26 00 55 bd ff ff ff ff 57 56 be 01 00 00 00 53 8b 54 24 14 31 db 8d b6 00 00 00 00 8d bf 00 00 00 00 8b 3a 89
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   90                        nop
Code;  00000001 Before first symbol
   1:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  00000005 Before first symbol
   5:   55                        push   %ebp
Code;  00000006 Before first symbol
   6:   bd ff ff ff ff            mov    $0xffffffff,%ebp
Code;  0000000b Before first symbol
   b:   57                        push   %edi
Code;  0000000c Before first symbol
   c:   56                        push   %esi
Code;  0000000d Before first symbol
   d:   be 01 00 00 00            mov    $0x1,%esi
Code;  00000012 Before first symbol
  12:   53                        push   %ebx
Code;  00000013 Before first symbol
  13:   8b 54 24 14               mov    0x14(%esp),%edx
Code;  00000017 Before first symbol
  17:   31 db                     xor    %ebx,%ebx
Code;  00000019 Before first symbol
  19:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  0000001f Before first symbol
  1f:   8d bf 00 00 00 00         lea    0x0(%edi),%edi
Code;  00000025 Before first symbol
  25:   8b 3a                     mov    (%edx),%edi
Code;  00000027 Before first symbol
  27:   89 00                     mov    %eax,(%eax)


2 warnings and 1 error issued.  Results may not be reliable.


--------------080302020901030104070407--
