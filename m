Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVHIQE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVHIQE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVHIQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:04:29 -0400
Received: from smtp1.poczta.onet.pl ([213.180.130.31]:52151 "EHLO
	smtp1.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S964838AbVHIQE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:04:29 -0400
Message-ID: <200508091804050500.042A58AE@friko2.onet.pl>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Tue, 09 Aug 2005 18:04:05 +0200
Reply-To: klasyk99@poczta.onet.pl
From: "Klasyk" <klasyk99@poczta.onet.pl>
To: linux-kernel@vger.kernel.org
Subject: my kernel sometimes did a crash, but no panic
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my kernel sometimes did a crash, but no panic
Keyboard hunged up :(
Network were working and I can log in. Without the keybord - it
generally worked.

In logs:
for example:

Aug  6 15:30:02 o kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00
000000
Aug  6 15:30:02 o kernel:  printing eip:
Aug  6 15:30:02 o kernel: c026b0d9
Aug  6 15:30:02 o kernel: *pde = 3588d001
Aug  6 15:30:02 o kernel: Oops: 0000 [#1]
Aug  6 15:30:02 o kernel: Modules linked in: ip_nat_irc
ip_conntrack_irc ip_nat_ftp ip_conntrack
_ftp ipt_MASQUERADE ipt_TCPMSS snd-usb-audio snd-usb-lib snd-seq-dummy
snd-seq-oss snd-seq-midi-ev
ent snd-seq snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-rawmidi
snd-seq-device snd-ac97-codec snd-pc
m snd-timer snd-page-alloc snd-util-mem snd-hwdep snd soundcore
cpufreq_powersave cpuid cpu5wdt ev
dev pcspkr ip6t_LOG ip6t_limit ip6table_filter ip6table_mangle
ip6_tables ipt_TOS ipt_state ipt_RE
JECT ipt_LOG ipt_limit iptable_filter iptable_mangle iptable_nat
ip_conntrack ip_tables md5 ipv6 p
pp_async ppp_generic slhc eagle-usb af_packet cpufreq_ondemand eeprom
asb100 i2c-sensor i2c-viapro
 ircomm-tty ircomm irda crc-ccitt floppy raw sg 8139too mii sr_mod
scsi_mod eth1394 ide-cd ohci139
4 ieee1394 loop via-agp bt878 tuner tvaudio bttv video-buf
firmware_class i2c-algo-bit v4l2-common
 btcx-risc tveeprom i2c-core nvidia agpgart usblp ehci-hcd uhci-hcd
pwc videodev usbcore
Aug  6 15:30:02 o kernel: CPU:    0
Aug  6 15:30:02 o kernel: EIP:    0060:[con_unify_unimap+329/368]
Tainted: P      VLI
Aug  6 15:30:02 o kernel: EIP:    0060:[<c026b0d9>]    Tainted: P
VLI
Aug  6 15:30:02 o kernel: EFLAGS: 00010246   (2.6.11-12mdkcustom)
Aug  6 15:30:02 o kernel: EIP is at get_kobj_path_length+0x19/0x30
Aug  6 15:30:02 o kernel: eax: 00000000   ebx: 00000000   ecx:
ffffffff   edx: f7d4a488
Aug  6 15:30:02 o kernel: esi: 00000001   edi: 00000000   ebp:
c1b19d58   esp: c1b19d4c
Aug  6 15:30:02 o su(pam_unix)[23584]: session closed for user root
Aug  6 15:30:02 o su(pam_unix)[25244]: session closed for user root
Aug  6 15:30:03 o su(pam_unix)[18603]: session closed for user root
Aug  6 15:30:03 o kernel: ds: 007b   es: 007b   ss: 0068
Aug  6 15:30:03 o kernel: Process events/0 (pid: 3,
threadinfo=c1b18000 task=c1aeb020)
Aug  6 15:30:03 o kernel: Stack: c0415200 f7d4a464 f74382f8 c1b19d7c
c026b15a f7d4a488 f7ff8d70
00000282
Aug  6 15:30:03 o kernel:        00000003 c0415200 f7d4a464 f74382f8
c1b19dc0 c02d9b29 f7d4a488
000000d0
Aug  6 15:30:03 o kernel:        f74382e0 f7d4a42c c1b19dac c026eb47
f7d4a42c 082b5bd4 00000000
f75cdaec
Aug  6 15:30:03 o kernel: Call Trace:
Aug  6 15:30:03 o kernel:  [show_registers+159/464]
show_stack+0x7f/0xa0
Aug  6 15:30:03 o kernel:  [<c0103d2f>] show_stack+0x7f/0xa0
Aug  6 15:30:03 o kernel:  [handle_BUG+106/192]
show_registers+0x15a/0x1d0
Aug  6 15:30:03 o kernel:  [<c0103eca>] show_registers+0x15a/0x1d0
Aug  6 15:30:03 o kernel:  [do_trap+62/240] die+0xce/0x160
Aug  6 15:30:03 o kernel:  [<c01040ae>] die+0xce/0x160
Aug  6 15:30:03 o kernel:  [do_page_fault+1073/1818]
do_page_fault+0x471/0x71a
Aug  6 15:30:03 o kernel:  [<c0116331>] do_page_fault+0x471/0x71a
Aug  6 15:30:03 o kernel:  [nmi_stack_correct+28/42]
error_code+0x2b/0x30
Aug  6 15:30:03 o kernel:  [<c01039cb>] error_code+0x2b/0x30
Aug  6 15:30:03 o kernel:  [con_insert_unipair+90/240]
kobject_get_path+0x1a/0x70
Aug  6 15:30:03 o kernel:  [<c026b15a>] kobject_get_path+0x1a/0x70
Aug  6 15:30:03 o kernel:  [skb_copy_bits+377/624]
class_hotplug+0x69/0x1a0
Aug  6 15:30:03 o kernel:  [<c02d9b29>] class_hotplug+0x69/0x1a0
Aug  6 15:30:03 o kernel:  [set_selection+1084/1264]
kobject_hotplug+0x1bc/0x2a0
Aug  6 15:30:03 o kernel:  [<c026be0c>] kobject_hotplug+0x1bc/0x2a0
Aug  6 15:30:03 o kernel:  [con_set_default_unimap+10/384]
kobject_del+0x1a/0x30
Aug  6 15:30:03 o kernel:  [<c026b50a>] kobject_del+0x1a/0x30
Aug  6 15:30:03 o kernel:  [skb_checksum+436/720]
class_device_del+0xa4/0xc0
Aug  6 15:30:03 o kernel:  [<c02d9fc4>] class_device_del+0xa4/0xc0
Aug  6 15:30:03 o kernel:  [skb_checksum+482/720]
class_device_unregister+0x12/0x20
Aug  6 15:30:03 o kernel:  [<c02d9ff2>]
class_device_unregister+0x12/0x20
Aug  6 15:30:03 o kernel:  [pg0+943977753/1068971008]
snd_unregister_device+0xa9/0x100 [snd]

Aug  6 15:30:03 o kernel:  [<f88ca519>]
snd_unregister_device+0xa9/0x100 [snd]
Aug  6 15:30:03 o kernel:  [pg0+944268948/1068971008]
snd_pcm_dev_unregister+0x64/0xd0 [snd-pcm]
Aug  6 15:30:04 o kernel:  [<f8911694>]
snd_pcm_dev_unregister+0x64/0xd0 [snd-pcm]
Aug  6 15:30:04 o kernel:  [pg0+943998790/1068971008]
snd_device_free+0xa6/0xc0 [snd]
Aug  6 15:30:04 o kernel:  [<f88cf746>] snd_device_free+0xa6/0xc0
[snd]
Aug  6 15:30:04 o kernel:  [pg0+943999348/1068971008]
snd_device_free_all+0x54/0x70 [snd]
Aug  6 15:30:04 o kernel:  [<f88cf974>] snd_device_free_all+0x54/0x70
[snd]
Aug  6 15:30:04 o kernel:  [pg0+943979379/1068971008]
snd_card_free+0x93/0x290 [snd]
Aug  6 15:30:04 o kernel:  [<f88cab73>] snd_card_free+0x93/0x290 [snd]
Aug  6 15:30:04 o kernel:  [pg0+943979932/1068971008]
snd_card_free_thread+0x2c/0x70 [snd]
Aug  6 15:30:04 o kernel:  [<f88cad9c>] snd_card_free_thread+0x2c/0x70
[snd]
Aug  6 15:30:04 o kernel:  [sys_timer_delete+134/192]
worker_thread+0x186/0x230
Aug  6 15:30:04 o kernel:  [<c0185996>] worker_thread+0x186/0x230
Aug  6 15:30:04 o kernel:  [__symbol_get+12/112] kthread+0x9c/0xd0
Aug  6 15:30:04 o kernel:  [<c018956c>] kthread+0x9c/0xd0
Aug  6 15:30:04 o kernel:  [kernel_thread+5/192]
kernel_thread_helper+0x5/0x10
Aug  6 15:30:04 o kernel:  [<c0101315>] kernel_thread_helper+0x5/0x10
Aug  6 15:30:04 o kernel: Code: 89 34 24 e8 da bc f8 ff eb dd 90 8d b4
26 00 00 00 00 55 89 e5 5
7 8b 55 08 56 be 01 00 00 00 53 31 db 8b 3a b9 ff ff ff ff 89 d8 <f2>
ae f7 d1 49 8b 52 24 8d 74 3
1 01 85 d2 75 e7 5b 89 f0 5e 5f


OR:

Aug  8 06:29:49 o kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00
000000
Aug  8 06:29:49 o kernel:  printing eip:
Aug  8 06:29:49 o kernel: c026b0d9
Aug  8 06:29:49 o kernel: *pde = 318e8001
Aug  8 06:29:49 o kernel: Oops: 0000 [#1]
Aug  8 06:29:49 o kernel: Modules linked in: ip_nat_irc
ip_conntrack_irc ip_nat_ftp ip_conntrack
_ftp ipt_MASQUERADE ipt_TCPMSS snd-usb-audio snd-usb-lib snd-seq-dummy
snd-seq-oss snd-seq-midi-ev
ent snd-seq snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-rawmidi
snd-seq-device snd-ac97-codec snd-pc
m snd-timer snd-page-alloc snd-util-mem snd-hwdep snd soundcore
cpufreq_powersave cpuid cpu5wdt ev
dev pcspkr ip6t_LOG ip6t_limit ip6table_filter ip6table_mangle
ip6_tables ipt_TOS ipt_state ipt_RE
JECT ipt_LOG ipt_limit iptable_filter iptable_mangle iptable_nat
ip_conntrack ip_tables md5 ipv6 p
pp_async ppp_generic slhc eagle-usb af_packet cpufreq_ondemand eeprom
asb100 i2c-sensor i2c-viapro
 ircomm-tty ircomm irda crc-ccitt floppy raw sg sr_mod scsi_mod
ide-floppy ide-tape eth1394 8139to
o mii ide-cd ohci1394 ieee1394 loop via-agp bt878 tuner tvaudio bttv
video-buf firmware_class i2c-
algo-bit v4l2-common btcx-risc tveeprom i2c-core nvidia agpgart usblp
ehci-hcd uhci-hcd pwc videod
ev usbcore video thermal tc1100-wmi process
Aug  8 06:29:49 o kernel: r fan container button battery ac
Aug  8 06:29:49 o kernel: CPU:    0
Aug  8 06:29:49 o kernel: EIP:    0060:[con_unify_unimap+329/368]
Tainted: P      VLI
Aug  8 06:29:49 o kernel: EIP:    0060:[<c026b0d9>]    Tainted: P
VLI
Aug  8 06:29:49 o su(pam_unix)[14680]: session closed for user root
Aug  8 06:29:49 o kernel: EFLAGS: 00010246   (2.6.11-12mdkcustom)
Aug  8 06:29:50 o kernel: EIP is at get_kobj_path_length+0x19/0x30
Aug  8 06:29:50 o kernel: eax: 00000000   ebx: 00000000   ecx:
ffffffff   edx: f758bc88
Aug  8 06:29:50 o kernel: esi: 00000001   edi: 00000000   ebp:
c1b29d58   esp: c1b29d4c
Aug  8 06:29:50 o kernel: ds: 007b   es: 007b   ss: 0068
Aug  8 06:29:50 o kernel: Process events/0 (pid: 3,
threadinfo=c1b28000 task=c1af3020)
Aug  8 06:29:50 o kernel: Stack: c0415200 f758bc64 f748ca78 c1b29d7c
c026b15a f758bc88 000000f0
00000286
Aug  8 06:29:50 o kernel:        c1ade4a0 c0415200 f758bc64 f748ca78
c1b29dc0 c02d9b29 f758bc88
000000d0
Aug  8 06:29:50 o kernel:        f748ca60 f758bc2c c1b29dac c026eb47
f758bc2c 08a743d4 00000000
f75d6eec
Aug  8 06:29:50 o kernel: Call Trace:
Aug  8 06:29:50 o kernel:  [show_registers+159/464]
show_stack+0x7f/0xa0
Aug  8 06:29:50 o kernel:  [<c0103d2f>] show_stack+0x7f/0xa0
Aug  8 06:29:50 o kernel:  [handle_BUG+106/192]
show_registers+0x15a/0x1d0Aug  8 06:29:50 o kernel:  [<c0103eca>]
show_registers+0x15a/0x1d0
Aug  8 06:29:50 o kernel:  [do_trap+62/240] die+0xce/0x160
Aug  8 06:29:50 o kernel:  [<c01040ae>] die+0xce/0x160
Aug  8 06:29:50 o kernel:  [do_page_fault+1073/1818]
do_page_fault+0x471/0x71a
Aug  8 06:29:50 o kernel:  [<c0116331>] do_page_fault+0x471/0x71a
Aug  8 06:29:50 o kernel:  [nmi_stack_correct+28/42]
error_code+0x2b/0x30
Aug  8 06:29:50 o kernel:  [<c01039cb>] error_code+0x2b/0x30
Aug  8 06:29:50 o kernel:  [con_insert_unipair+90/240]
kobject_get_path+0x1a/0x70
Aug  8 06:29:50 o kernel:  [<c026b15a>] kobject_get_path+0x1a/0x70
Aug  8 06:29:50 o kernel:  [skb_copy_bits+377/624]
class_hotplug+0x69/0x1a0
Aug  8 06:29:50 o kernel:  [<c02d9b29>] class_hotplug+0x69/0x1a0
Aug  8 06:29:50 o kernel:  [set_selection+1084/1264]
kobject_hotplug+0x1bc/0x2a0
Aug  8 06:29:50 o kernel:  [<c026be0c>] kobject_hotplug+0x1bc/0x2a0
Aug  8 06:29:50 o kernel:  [con_set_default_unimap+10/384]
kobject_del+0x1a/0x30
Aug  8 06:29:50 o kernel:  [<c026b50a>] kobject_del+0x1a/0x30
Aug  8 06:29:50 o kernel:  [skb_checksum+436/720]
class_device_del+0xa4/0xc0
Aug  8 06:29:50 o kernel:  [<c02d9fc4>] class_device_del+0xa4/0xc0
Aug  8 06:29:50 o kernel:  [skb_checksum+482/720]
class_device_unregister+0x12/0x20
Aug  8 06:29:50 o kernel:  [<c02d9ff2>]
class_device_unregister+0x12/0x20
Aug  8 06:29:50 o kernel:  [pg0+944182553/1068971008]
snd_unregister_device+0xa9/0x100 [snd]
Aug  8 06:29:50 o kernel:  [<f88fc519>]
snd_unregister_device+0xa9/0x100 [snd]
Aug  8 06:29:50 o kernel:  [pg0+944273044/1068971008]
snd_pcm_dev_unregister+0x64/0xd0 [snd-pcm]
Aug  8 06:29:50 o kernel:  [<f8912694>]
snd_pcm_dev_unregister+0x64/0xd0 [snd-pcm]
Aug  8 06:29:50 o kernel:  [pg0+944203590/1068971008]
snd_device_free+0xa6/0xc0 [snd]
Aug  8 06:29:50 o kernel:  [<f8901746>] snd_device_free+0xa6/0xc0
[snd]
Aug  8 06:29:50 o kernel:  [pg0+944204148/1068971008]
snd_device_free_all+0x54/0x70 [snd]
Aug  8 06:29:50 o kernel:  [<f8901974>] snd_device_free_all+0x54/0x70
[snd]
Aug  8 06:29:51 o kernel:  [pg0+944184179/1068971008]
snd_card_free+0x93/0x290 [snd]
Aug  8 06:29:51 o kernel:  [<f88fcb73>] snd_card_free+0x93/0x290 [snd]
Aug  8 06:29:51 o kernel:  [pg0+944184732/1068971008]
snd_card_free_thread+0x2c/0x70 [snd]
Aug  8 06:29:51 o kernel:  [<f88fcd9c>] snd_card_free_thread+0x2c/0x70
[snd]
Aug  8 06:29:51 o kernel:  [sys_timer_delete+134/192]
worker_thread+0x186/0x230
Aug  8 06:29:51 o kernel:  [<c0185996>] worker_thread+0x186/0x230
Aug  8 06:29:51 o kernel:  [__symbol_get+12/112] kthread+0x9c/0xd0
Aug  8 06:29:51 o kernel:  [<c018956c>] kthread+0x9c/0xd0
Aug  8 06:29:51 o kernel:  [kernel_thread+5/192]
kernel_thread_helper+0x5/0x10
Aug  8 06:29:51 o kernel:  [<c0101315>] kernel_thread_helper+0x5/0x10
Aug  8 06:29:51 o kernel: Code: 89 34 24 e8 da bc f8 ff eb dd 90 8d b4
26 00 00 00 00 55 89 e5 57 8b 55 08 56 be 01 00 00 00 53 31 db 8b 3a
b9 ff ff ff ff 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 3
1 01 85 d2 75 e7 5b 89 f0 5e 5f


OR


Aug  8 23:54:02 o kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00
000000
Aug  8 23:54:02 o su(pam_unix)[8638]: session closed for user root
Aug  8 23:54:02 o su(pam_unix)[9094]: session closed for user root
Aug  8 23:54:03 o su(pam_unix)[10551]: session closed for user root
Aug  8 23:54:03 o kernel:  printing eip:
Aug  8 23:54:03 o kernel: c026b0d9
Aug  8 23:54:03 o kernel: *pde = 349c4001
Aug  8 23:54:03 o kernel: Oops: 0000 [#1]
Aug  8 23:54:03 o kernel: Modules linked in: ip_nat_irc
ip_conntrack_irc ip_nat_ftp ip_conntrack
_ftp ipt_MASQUERADE ipt_TCPMSS snd-usb-audio snd-usb-lib snd-seq-dummy
snd-seq-oss snd-seq-midi-ev
ent snd-seq snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-rawmidi
snd-seq-device snd-ac97-codec snd-pc
m snd-timer snd-page-alloc snd-util-mem snd-hwdep snd soundcore
cpufreq_powersave cpuid cpu5wdt ev
dev pcspkr ip6t_LOG ip6t_limit ip6table_filter ip6table_mangle
ip6_tables ipt_TOS ipt_state ipt_RE
JECT ipt_LOG ipt_limit iptable_filter iptable_mangle iptable_nat
ip_conntrack ip_tables md5 ipv6 p
pp_async ppp_generic slhc af_packet cpufreq_ondemand eeprom asb100
i2c-sensor eagle-usb i2c-viapro
 ircomm-tty ircomm irda crc-ccitt floppy raw ide-floppy ide-tape
eth1394 8139too mii ide-cd ohci13
94 ieee1394 sg st sr_mod sd_mod scsi_mod loop via-agp bt878 tuner
tvaudio bttv video-buf firmware_
class i2c-algo-bit v4l2-common btcx-risc tveeprom i2c-core nvidia
agpgart usblp ehci-hcd uhci-hcd
pwc videodev usbcore video thermal tc1100-w
Aug  8 23:54:03 o kernel: i processor fan container button battery ac
Aug  8 23:54:03 o kernel: CPU:    0
Aug  8 23:54:03 o kernel: EIP:    0060:[con_unify_unimap+329/368]
Tainted: P      VLI
Aug  8 23:54:03 o kernel: EIP:    0060:[<c026b0d9>]    Tainted: P
VLI
Aug  8 23:54:03 o kernel: EFLAGS: 00010246   (2.6.11-12mdkcustom)
Aug  8 23:54:03 o kernel: EIP is at get_kobj_path_length+0x19/0x30
Aug  8 23:54:03 o kernel: eax: 00000000   ebx: 00000000   ecx:
ffffffff   edx: f622e888
Aug  8 23:54:03 o kernel: esi: 00000001   edi: 00000000   ebp:
c1b29d58   esp: c1b29d4c
Aug  8 23:54:03 o kernel: ds: 007b   es: 007b   ss: 0068
Aug  8 23:54:03 o kernel: Process events/0 (pid: 3,
threadinfo=c1b28000 task=c1af3020)
Aug  8 23:54:03 o kernel: Stack: c0415200 f622e864 f5c6bc78 c1b29d7c
c026b15a f622e888 f5ca7504
00000286
Aug  8 23:54:03 o kernel:        00000003 c0415200 f622e864 f5c6bc78
c1b29dc0 c02d9b29 f622e888
000000d0
Aug  8 23:54:03 o kernel:        f5c6bc60 f622e82c c1b29dac c026eb47
f622e82c 09dd17d4 00000000
f54510ec
Aug  8 23:54:04 o kernel: Call Trace:
Aug  8 23:54:04 o kernel:  [show_registers+159/464]
show_stack+0x7f/0xa0Aug  8 23:54:04 o kernel:  [<c0103d2f>]
show_stack+0x7f/0xa0
Aug  8 23:54:04 o kernel:  [handle_BUG+106/192]
show_registers+0x15a/0x1d0
Aug  8 23:54:04 o kernel:  [<c0103eca>] show_registers+0x15a/0x1d0
Aug  8 23:54:04 o kernel:  [do_trap+62/240] die+0xce/0x160
Aug  8 23:54:04 o kernel:  [<c01040ae>] die+0xce/0x160
Aug  8 23:54:04 o kernel:  [do_page_fault+1073/1818]
do_page_fault+0x471/0x71a
Aug  8 23:54:04 o kernel:  [<c0116331>] do_page_fault+0x471/0x71a
Aug  8 23:54:04 o kernel:  [nmi_stack_correct+28/42]
error_code+0x2b/0x30
Aug  8 23:54:04 o kernel:  [<c01039cb>] error_code+0x2b/0x30
Aug  8 23:54:04 o kernel:  [con_insert_unipair+90/240]
kobject_get_path+0x1a/0x70
Aug  8 23:54:04 o kernel:  [<c026b15a>] kobject_get_path+0x1a/0x70
Aug  8 23:54:04 o kernel:  [skb_copy_bits+377/624]
class_hotplug+0x69/0x1a0
Aug  8 23:54:04 o kernel:  [<c02d9b29>] class_hotplug+0x69/0x1a0
Aug  8 23:54:04 o kernel:  [set_selection+1084/1264]
kobject_hotplug+0x1bc/0x2a0
Aug  8 23:54:04 o kernel:  [<c026be0c>] kobject_hotplug+0x1bc/0x2a0
Aug  8 23:54:04 o kernel:  [con_set_default_unimap+10/384]
kobject_del+0x1a/0x30
Aug  8 23:54:04 o kernel:  [<c026b50a>] kobject_del+0x1a/0x30
Aug  8 23:54:04 o kernel:  [skb_checksum+436/720]
class_device_del+0xa4/0xc0
Aug  8 23:54:04 o kernel:  [<c02d9fc4>] class_device_del+0xa4/0xc0
Aug  8 23:54:04 o kernel:  [skb_checksum+482/720]
class_device_unregister+0x12/0x20
Aug  8 23:54:04 o kernel:  [<c02d9ff2>]
class_device_unregister+0x12/0x20
Aug  8 23:54:04 o kernel:  [pg0+943764761/1068971008]
snd_unregister_device+0xa9/0x100 [snd]
Aug  8 23:54:04 o kernel:  [<f8896519>]
snd_unregister_device+0xa9/0x100 [snd]
Aug  8 23:54:04 o kernel:  [pg0+944211604/1068971008]
snd_pcm_dev_unregister+0x64/0xd0 [snd-pcm]
Aug  8 23:54:04 o kernel:  [<f8903694>]
snd_pcm_dev_unregister+0x64/0xd0 [snd-pcm]
Aug  8 23:54:04 o kernel:  [pg0+943785798/1068971008]
snd_device_free+0xa6/0xc0 [snd]
Aug  8 23:54:04 o kernel:  [<f889b746>] snd_device_free+0xa6/0xc0
[snd]
Aug  8 23:54:04 o kernel:  [pg0+943786356/1068971008]
snd_device_free_all+0x54/0x70 [snd]
Aug  8 23:54:04 o kernel:  [<f889b974>] snd_device_free_all+0x54/0x70
[snd]
Aug  8 23:54:04 o kernel:  [pg0+943766387/1068971008]
snd_card_free+0x93/0x290 [snd]
Aug  8 23:54:04 o kernel:  [<f8896b73>] snd_card_free+0x93/0x290 [snd]
Aug  8 23:54:04 o kernel:  [pg0+943766940/1068971008]
snd_card_free_thread+0x2c/0x70 [snd]
Aug  8 23:54:04 o kernel:  [<f8896d9c>] snd_card_free_thread+0x2c/0x70
[snd]
Aug  8 23:54:04 o kernel:  [sys_timer_delete+134/192]
worker_thread+0x186/0x230
Aug  8 23:54:04 o kernel:  [<c0185996>] worker_thread+0x186/0x230
Aug  8 23:54:04 o kernel:  [__symbol_get+12/112] kthread+0x9c/0xd0
Aug  8 23:54:04 o kernel:  [<c018956c>] kthread+0x9c/0xd0
Aug  8 23:54:04 o kernel:  [kernel_thread+5/192]
kernel_thread_helper+0x5/0x10
Aug  8 23:54:04 o kernel:  [<c0101315>] kernel_thread_helper+0x5/0x10
Aug  8 23:54:04 o kernel: Code: 89 34 24 e8 da bc f8 ff eb dd 90 8d b4
26 00 00 00 00 55 89 e5 5
7 8b 55 08 56 be 01 00 00 00 53 31 db 8b 3a b9 ff ff ff ff 89 d8 <f2>
ae f7 d1 49 8b 52 24 8d 74 3
1 01 85 d2 75 e7 5b 89 f0 5e 5f


cat /proc/interrupts
           CPU0
  0:   64851118    IO-APIC-edge  timer
  1:      17356    IO-APIC-edge  i8042
  8:      70540    IO-APIC-edge  rtc
  9:          1   IO-APIC-level  acpi
 12:    1088765    IO-APIC-edge  i8042
 14:    1933706    IO-APIC-edge  ide0
 15:         14    IO-APIC-edge  ide1
 16:    4558899   IO-APIC-level  uhci_hcd, bttv0, bt878, nvidia
 17:       1161   IO-APIC-level  ehci_hcd, ohci1394, eth0
 18:     148797   IO-APIC-level  EMU10K1
 19:   13530877   IO-APIC-level  uhci_hcd, eth1
 21:   13539350   IO-APIC-level  uhci_hcd, uhci_hcd
NMI:          0
LOC:   64858492
ERR:          0
MIS:          0

it is not apic problem, i disabled it, and it didn't help
Linux o 2.6.11-12mdkcustom #2 Sat Aug 6 11:02:20 CEST 2005 i686 AMD
Duron(TM) unknown GNU/Linux



lsmod

Module                  Size  Used by
ip_nat_irc              1600  0
ip_conntrack_irc       70544  1 ip_nat_irc
ip_nat_ftp              2304  0
ip_conntrack_ftp       71568  1 ip_nat_ftp
ipt_MASQUERADE          3336  1
ipt_TCPMSS              3328  1
snd-usb-audio          65344  4
snd-usb-lib            13696  1 snd-usb-audio
snd-seq-dummy           2628  0
snd-seq-oss            31168  0
snd-seq-midi-event      6272  1 snd-seq-oss
snd-seq                46928  5
snd-seq-dummy,snd-seq-oss,snd-seq-midi-event
snd-pcm-oss            48480  0
snd-mixer-oss          17088  7 snd-pcm-oss
snd-emu10k1           108484  8
snd-rawmidi            19872  2 snd-usb-lib,snd-emu10k1
snd-seq-device          6796  5
snd-seq-dummy,snd-seq-oss,snd-seq,snd-emu10k1,snd-rawmidi
snd-ac97-codec         74296  1 snd-emu10k1
snd-pcm                80008  4
snd-usb-audio,snd-pcm-oss,snd-emu10k1,snd-ac97-codec
snd-timer              20356  3 snd-seq,snd-emu10k1,snd-pcm
snd-page-alloc          7492  2 snd-emu10k1,snd-pcm
snd-util-mem            3264  1 snd-emu10k1
snd-hwdep               6880  1 snd-emu10k1
snd                    46788  24
snd-usb-audio,snd-seq-oss,snd-seq,snd-pcm-oss,snd-mixer-oss,snd-emu10k1,snd-
rawmidi,snd-seq-device,snd-ac97-codec,snd-pcm,snd-timer,snd-hwdep
soundcore               7008  7 snd
cpufreq_powersave       1344  0
cpuid                   2308  0
cpu5wdt                 4444  0
evdev                   7744  0
pcspkr                  3108  0
ip6t_LOG                6784  6
ip6t_limit              1792  6
ip6table_filter         1984  1
ip6table_mangle         1856  0
ip6_tables             19008  4
ip6t_LOG,ip6t_limit,ip6table_filter,ip6table_mangle
ipt_TOS                 1856  16
ipt_state               1408  6
ipt_REJECT              5504  40
ipt_LOG                 6272  6
ipt_limit               1792  6
iptable_filter          2112  1
iptable_mangle          2048  1
iptable_nat            21340  4 ip_nat_irc,ip_nat_ftp,ipt_MASQUERADE
ip_conntrack           45568  7
ip_nat_irc,ip_conntrack_irc,ip_nat_ftp,ip_conntrack_ftp,ipt_MASQUERADE,ipt_s
tate,iptable_nat
ip_tables              20544  10
ipt_MASQUERADE,ipt_TCPMSS,ipt_TOS,ipt_state,ipt_REJECT,ipt_LOG,ipt_limit,ipt
able_filter,iptable_mangle,iptable_nat
md5                     3712  1
ipv6                  227968  28
ppp_async               9088  1
ppp_generic            24724  5 ppp_async
slhc                    6592  1 ppp_generic
af_packet              16200  4
cpufreq_ondemand        5148  0
eeprom                  5840  0
asb100                 22036  0
i2c-sensor              2752  2 eeprom,asb100
i2c-viapro              6416  0
eagle-usb             122688  0
ircomm-tty             21256  0
ircomm                 11460  1 ircomm-tty
irda                  117880  2 ircomm-tty,ircomm
crc-ccitt               1664  2 ppp_async,irda
floppy                 54032  0
raw                     6688  0
eth1394                17160  0
ide-floppy             16960  0
8139too                21376  0
mii                     4224  1 8139too
ide-tape               33424  0
ide-cd                 36484  0
ohci1394               31108  0
ieee1394              292088  2 eth1394,ohci1394
sg                     34076  0
st                     35804  0
sr_mod                 15268  0
sd_mod                 15824  0
scsi_mod              114696  4 sg,st,sr_mod,sd_mod
loop                   13640  0
via-agp                 7424  1
bt878                   8472  0
tuner                  25256  0
tvaudio                21412  0
bttv                  145552  1 bt878
video-buf              16772  1 bttv
firmware_class          7488  1 bttv
i2c-algo-bit            8392  1 bttv
v4l2-common             4736  1 bttv
btcx-risc               3848  1 bttv
tveeprom               11480  1 bttv
i2c-core               18964  9
eeprom,asb100,i2c-sensor,i2c-viapro,tuner,tvaudio,bttv,i2c-algo-bit,tveeprom

nvidia               3905276  12
agpgart                28136  2 via-agp,nvidia
usblp                  10688  0
ehci-hcd               28168  0
uhci-hcd               28624  0
pwc                    78836  1
videodev                7296  3 bttv,pwc
usbcore               104984  8
snd-usb-audio,snd-usb-lib,eagle-usb,usblp,ehci-hcd,uhci-hcd,pwc
video                  13892  0
thermal                10632  0
tc1100-wmi              5188  0
processor              19252  1 thermal
fan                     3140  0
container               3072  0
button                  4880  0
battery                 7492  0
ac                      3332  0

