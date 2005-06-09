Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVFISHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVFISHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 14:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVFISHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 14:07:09 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:49284 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262434AbVFISGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 14:06:30 -0400
Date: Thu, 09 Jun 2005 11:30:19 -0400 (EDT)
From: vcjones@networkingunlimited.com (Vincent C Jones)
Subject: Re: Linux v2.6.12-rc6 -- PCMCIA IDE oops
In-reply-to: <4cun0-5ok-7@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
Message-id: <20050609153019.2BE75219C1@X31.networkingunlimited.com>
Organization: 
Content-transfer-encoding: 7BIT
Newsgroups: linux.kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4cun0-5ok-7@gated-at.bofh.it> you write:
>
>It's being uploaded right now, the git tree is already up-to-date, and by 
>the time this hits the mailing list the mirroring of the tar-ball will 
>hopefully be done too.
>
>And since Jeff wrote me a shortlog script for git, the easist way to tell
>what's new since -rc5 is to just do the shortlog and diffstat output. 
>Network drivers, USB and CPU-freq stand out.
>
>And the good news is that people do seem to have taken my rumblings about 
>calming down for 2.6.12 seriously. Let's hope that pans out, and I can 
>release that one asap.. But give this a good beating first, and holler 
>(again, if you must) about any issues you have,
>
>		Linus
>
>---

PCMCIA still seems to have problems dealing with compact flash. Log
follows:


Jun  9 11:01:04 X31 kernel: hde: lost interrupt
Jun  9 11:01:34 X31 kernel: hde: lost interrupt
Jun  9 11:02:04 X31 kernel: hde: lost interrupt
Jun  9 11:02:34 X31 kernel: hde: lost interrupt
Jun  9 11:03:04 X31 kernel: hde: lost interrupt
Jun  9 11:03:34 X31 kernel: hde: lost interrupt
Jun  9 11:04:04 X31 kernel: hde: lost interrupt
Jun  9 11:04:34 X31 kernel: hde: lost interrupt
Jun  9 11:05:04 X31 kernel: hde: lost interrupt
Jun  9 11:05:34 X31 kernel: hde: lost interrupt
Jun  9 11:06:04 X31 kernel: hde: lost interrupt
Jun  9 11:06:34 X31 kernel: hde: lost interrupt
Jun  9 11:07:04 X31 kernel: hde: lost interrupt
Jun  9 11:07:34 X31 kernel: hde: lost interrupt
Jun  9 11:08:04 X31 kernel: hde: lost interrupt
Jun  9 11:08:34 X31 kernel: hde: lost interrupt
Jun  9 11:09:04 X31 kernel: hde: lost interrupt
Jun  9 11:09:34 X31 kernel: hde: lost interrupt
Jun  9 11:10:04 X31 kernel: hde: lost interrupt
Jun  9 11:10:34 X31 kernel: hde: lost interrupt
Jun  9 11:11:04 X31 kernel: hde: lost interrupt
Jun  9 11:11:34 X31 kernel: hde: lost interrupt
Jun  9 11:12:04 X31 kernel: hde: lost interrupt
Jun  9 11:12:34 X31 kernel: hde: lost interrupt
Jun  9 11:13:04 X31 kernel: hde: lost interrupt
Jun  9 11:13:34 X31 kernel: hde: lost interrupt
Jun  9 11:14:04 X31 kernel: hde: lost interrupt
Jun  9 11:14:34 X31 kernel: hde: lost interrupt
Jun  9 11:15:04 X31 kernel: hde: lost interrupt
Jun  9 11:15:34 X31 kernel: hde: lost interrupt
Jun  9 11:16:04 X31 kernel: hde: lost interrupt
Jun  9 11:16:34 X31 kernel: hde: lost interrupt
Jun  9 11:17:04 X31 kernel: hde: lost interrupt
Jun  9 11:17:10 X31 kernel: ------------[ cut here ]------------
Jun  9 11:17:10 X31 kernel: kernel BUG at drivers/block/as-iosched.c:1853!
Jun  9 11:17:10 X31 kernel: invalid operand: 0000 [#1]
Jun  9 11:17:10 X31 kernel: PREEMPT 
Jun  9 11:17:10 X31 kernel: Modules linked in: ipt_pkttype e1000 ipt_LOG ipt_limit ipt_state ipt_REJECT iptable_mangle ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip6table_filter ip6_tables subfs ipv6 vmnet vmmon snd_intel8x0m usbserial nvram cpufreq_userspace speedstep_centrino freq_table nsc_ircc irda crc_ccitt snd_pcm_oss snd_mixer_oss aes_i586 wlan_ccmp wlan_tkip snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc wlan_wep ide_cs pcmcia yenta_socket rsrc_nonstatic pcmcia_core rfcomm hidp l2cap evdev joydev sg st sr_mod cdrom ath_pci ath_rate_onoe wlan ath_hal hci_usb bluetooth ehci_hcd loop uhci_hcd usbcore psmouse video1394 ohci1394 raw1394 ieee1394 iptable_filter ip_tables parport_pc lp parport nls_iso8859_1 nls_cp437 vfat fat sd_mod scsi_mod dm_mod
Jun  9 11:17:10 X31 kernel: CPU:    0
Jun  9 11:17:10 X31 kernel: EIP:    0060:[<c0275cf4>]    Tainted: P      VLI
Jun  9 11:17:10 X31 kernel: EFLAGS: 00010216   (2.6.12-rc6-APM) 
Jun  9 11:17:10 X31 kernel: EIP is at as_exit_queue+0x44/0x60
Jun  9 11:17:10 X31 kernel: eax: e4be59d4   ebx: e4be59c0   ecx: 00000d11   edx: 00000001
Jun  9 11:17:10 X31 kernel: esi: efc2cbfc   edi: c037ed20   ebp: c041d98c   esp: cadcde0c
Jun  9 11:17:10 X31 kernel: ds: 007b   es: 007b   ss: 0068
Jun  9 11:17:10 X31 kernel: Process cardctl (pid: 16284, threadinfo=cadcc000 task=e36b30a0)
Jun  9 11:17:10 X31 kernel: Stack: eec6a240 c026c0c7 efc2cbec c026eb6c c041d500 cadcc000 c028a843 c041d608 
Jun  9 11:17:10 X31 kernel:        c037ed08 c0266bb6 ea663994 cadcc000 ea663994 ed7a31ec c02166d7 c041d620 
Jun  9 11:17:10 X31 kernel:        c02166e0 00000001 00000000 c0217068 c041d968 c026709f c041d5e4 c041d500 
Jun  9 11:17:10 X31 kernel: Call Trace:
Jun  9 11:17:10 X31 kernel:  [<c026c0c7>] elevator_exit+0x27/0x40
Jun  9 11:17:10 X31 kernel:  [<c026eb6c>] blk_cleanup_queue+0x7c/0x90
Jun  9 11:17:10 X31 kernel:  [<c028a843>] drive_release_dev+0x53/0xb0
Jun  9 11:17:10 X31 hal-subfs-mount[16318]: Mount point /media/idedisk can't get removed!
Jun  9 11:17:10 X31 kernel:  [<c0266bb6>] device_release+0x56/0x60
Jun  9 11:17:10 X31 kernel:  [<c02166d7>] kobject_cleanup+0x97/0xa0
Jun  9 11:17:10 X31 kernel:  [<c02166e0>] kobject_release+0x0/0x10
Jun  9 11:17:10 X31 kernel:  [<c0217068>] kref_put+0x38/0xb0
Jun  9 11:17:10 X31 kernel:  [<c026709f>] device_del+0x6f/0x90
Jun  9 11:17:10 X31 kernel:  [<c0282f41>] ide_unregister+0x251/0x360
Jun  9 11:17:10 X31 kernel:  [<f1d0089b>] ide_release+0x4b/0x50 [ide_cs]
Jun  9 11:17:10 X31 kernel:  [<f1d0094d>] ide_event+0xad/0xd0 [ide_cs]
Jun  9 11:17:10 X31 kernel:  [<f1cd6b2c>] send_event_callback+0x3c/0x40 [pcmcia]
Jun  9 11:17:10 X31 kernel:  [<c0267b20>] __bus_for_each_dev+0x50/0x80
Jun  9 11:17:10 X31 kernel:  [<c0267bf8>] bus_for_each_dev+0x28/0x50
Jun  9 11:17:10 X31 kernel:  [<f1cd6af0>] send_event_callback+0x0/0x40 [pcmcia]
Jun  9 11:17:10 X31 kernel:  [<f1cd6b7f>] send_event+0x4f/0x70 [pcmcia]
Jun  9 11:17:10 X31 kernel:  [<f1cd6af0>] send_event_callback+0x0/0x40 [pcmcia]
Jun  9 11:17:10 X31 kernel:  [<f1cd6af0>] send_event_callback+0x0/0x40 [pcmcia]
Jun  9 11:17:10 X31 kernel:  [<f1cd6c12>] ds_event+0x72/0xb0 [pcmcia]
Jun  9 11:17:10 X31 kernel:  [<f1dd0805>] send_event+0x95/0x130 [pcmcia_core]
Jun  9 11:17:10 X31 kernel:  [<f1dd08b8>] socket_shutdown+0x8/0x30 [pcmcia_core]
Jun  9 11:17:10 X31 kernel:  [<f1dd0dc8>] socket_remove+0x8/0x70 [pcmcia_core]
Jun  9 11:17:10 X31 kernel:  [<f1dd2a62>] pcmcia_eject_card+0x62/0x70 [pcmcia_core]
Jun  9 11:17:10 X31 kernel:  [<f1cd7f8d>] ds_ioctl+0x63d/0x680 [pcmcia]
Jun  9 11:17:10 X31 kernel:  [<c0174359>] dput+0x99/0x280
Jun  9 11:17:10 X31 kernel:  [<c016f2fa>] do_ioctl+0x6a/0xa0
Jun  9 11:17:10 X31 kernel:  [<c016f4b7>] vfs_ioctl+0x67/0x1f0
Jun  9 11:17:10 X31 kernel:  [<c016f69b>] sys_ioctl+0x5b/0x90
Jun  9 11:17:10 X31 kernel:  [<c0102bbb>] sysenter_past_esp+0x54/0x75
Jun  9 11:17:10 X31 kernel: Code: 8d 43 0c 39 43 0c 75 2d 8b 43 70 e8 f7 af ec ff 8b 83 cc 00 00 00 e8 0c af ff ff 8b 43 30 e8 e4 06 ed ff 89 d8 5b e9 dc 06 ed ff <0f> 0b 3d 07 52 26 34 c0 eb cb 0f 0b 3e 07 52 26 34 c0 eb c9 90 
Jun  9 11:17:34 X31 kernel:  <3>ide_timer_expiry: hwgroup->drive was NULL

IBM ThinkPad X31 (2884JUU), Pent M, 768M, "Crucial Tech" 1 GB
CompactFlash Memory Card. 2.6.12-rc6 (APM drivers).

Tainting is by mad wifi and vmware, lsmod ==>
Module                  Size  Used by
ipt_pkttype             1920  0 
e1000                 102516  0 
ipt_LOG                 7488  3 
ipt_limit               2816  3 
ipt_state               2176  2 
ipt_REJECT              5696  3 
iptable_mangle          3072  0 
ip6table_mangle         2560  0 
ip_nat_ftp              3776  0 
iptable_nat            23580  1 ip_nat_ftp
ip_conntrack_ftp       73296  1 ip_nat_ftp
ip_conntrack           44792  4 ipt_state,ip_nat_ftp,iptable_nat,ip_conntrack_ftp
ip6table_filter         3008  1 
ip6_tables             20224  2 ip6table_mangle,ip6table_filter
subfs                   8448  1 
ipv6                  260160  10 
vmnet                  31972  12 
vmmon                 170476  0 
snd_intel8x0m          19268  2 
usbserial              29608  0 
nvram                   9928  1 
cpufreq_userspace       4636  1 
speedstep_centrino      6024  0 
freq_table              4740  1 speedstep_centrino
nsc_ircc               17724  0 
irda                  123000  1 nsc_ircc
crc_ccitt               2240  1 irda
snd_pcm_oss            52256  0 
snd_mixer_oss          18880  1 snd_pcm_oss
aes_i586               39104  0 
wlan_ccmp               7104  0 
wlan_tkip              11648  0 
snd_intel8x0           32768  0 
snd_ac97_codec         76792  2 snd_intel8x0m,snd_intel8x0
snd_pcm                94792  6 snd_intel8x0m,snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              25860  1 snd_pcm
snd                    55524  9 snd_intel8x0m,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore              10336  1 snd
snd_page_alloc         10116  3 snd_intel8x0m,snd_intel8x0,snd_pcm
wlan_wep                6720  1 
ide_cs                  7044  1 
pcmcia                 27784  6 ide_cs
yenta_socket           22216  3 
rsrc_nonstatic         13568  1 yenta_socket
pcmcia_core            51012  4 ide_cs,pcmcia,yenta_socket,rsrc_nonstatic
rfcomm                 40284  0 
hidp                   16768  2 
l2cap                  27652  10 rfcomm,hidp
evdev                   9216  0 
joydev                  9856  0 
sg                     39456  0 
st                     40288  0 
sr_mod                 17508  0 
cdrom                  39200  1 sr_mod
ath_pci                60000  0 
ath_rate_onoe           8776  1 ath_pci
wlan                  115740  6 wlan_ccmp,wlan_tkip,wlan_wep,ath_pci,ath_rate_onoe
ath_hal               133456  2 ath_pci
hci_usb                15816  6 
bluetooth              51588  16 rfcomm,hidp,l2cap,hci_usb
ehci_hcd               35272  0 
loop                   58956  2 
uhci_hcd               33232  0 
usbcore               120956  5 usbserial,hci_usb,ehci_hcd,uhci_hcd
psmouse                28676  0 
video1394              20684  0 
ohci1394               34804  1 video1394
raw1394                31596  0 
ieee1394              104312  3 video1394,ohci1394,raw1394
iptable_filter          3200  1 
ip_tables              23104  8 ipt_pkttype,ipt_LOG,ipt_limit,ipt_state,ipt_REJECT,iptable_mangle,iptable_nat,iptable_filter
parport_pc             35652  1 
lp                     12100  0 
parport                37192  2 parport_pc,lp
nls_iso8859_1           4288  2 
nls_cp437               5888  2 
vfat                   13952  2 
fat                    52060  1 vfat
sd_mod                 18256  0 
scsi_mod              106184  4 sg,st,sr_mod,sd_mod
dm_mod                 57404  0 
-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
Phone: +1 201 568-7810
14 Dogwood Lane, Tenafly, NJ 07670
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com
