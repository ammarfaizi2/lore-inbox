Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWAEVEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWAEVEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWAEVEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:04:51 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:63942 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932182AbWAEVEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:04:50 -0500
Message-ID: <43BD89E9.6040305@ntlworld.com>
Date: Thu, 05 Jan 2006 21:04:41 +0000
From: ael <law_ence.dev@ntlworld.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, phil@netroedge.com, mdsxyz123@yahoo.com
Subject: Re: Oops in kernel 2.6.14.5
References: <43B8410A.10609@ntlworld.com> <20060104195137.GS3831@stusta.de>
In-Reply-To: <20060104195137.GS3831@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Jan 01, 2006 at 08:52:26PM +0000, ael wrote:
> 
>>Jan  1 18:12:05 conquest3 kernel: 00b7c00b
>>Jan  1 18:12:05 conquest3 kernel: PREEMPT
>>Jan  1 18:12:05 conquest3 kernel: Modules linked in: nls_cp850 isofs
>>snd_sbawe snd_opl3_lib snd_sb16_dsp snd_pcm_oss snd
>>_mixer_oss snd_pcm snd_timer snd_page_alloc snd_sb16_csp snd_sb_common
>>snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_dev
>>ice snd soundcore capability commoncap ipv6 nfsd exportfs lockd sunrpc
>>lp eeprom w83781d hwmon_vid hwmon i2c_isa mga drm
>> ide_cd cdrom analog ns558 gameport parport_pc parport floppy 8250_pnp
>>8250 serial_core tulip crc32 i2c_piix4 i2c_core u
>>sb_storage uhci_hcd usbcore intel_agp agpgart nls_iso8859_1 nls_cp437
>>vfat fat sd_mod st aic7xxx scsi_transport_spi scsi
>>_mod rtc
>>Jan  1 18:12:05 conquest3 kernel: CPU:    0
>>Jan  1 18:12:05 conquest3 kernel: EIP:
>>0060:[phys_startup_32+10993675/-1073741824]    Not tainted VLI
>>Jan  1 18:12:05 conquest3 kernel: EFLAGS: 00210296   (2.6.14.5)
>>Jan  1 18:12:05 conquest3 kernel: EIP is at 0xb7c00b
>>Jan  1 18:12:05 conquest3 kernel: eax: c20738e8   ebx: 00000001   ecx:
>>00000000   edx: cfd24ce8
>>Jan  1 18:12:05 conquest3 kernel: esi: ce1f8000   edi: 00000000   ebp:
>>cece3000   esp: ce1f9d70
>>Jan  1 18:12:05 conquest3 kernel: ds: 007b   es: 007b   ss: 0068
>>Jan  1 18:12:05 conquest3 kernel: Process find (pid: 4230,
>>threadinfo=ce1f8000 task=cdcf1a50)
>>Jan  1 18:12:05 conquest3 kernel: Stack: c01744af cece3000 cece3000
>>cee3b1e4 ce1f8000 00000000 00b7c00b cece3000
>>Jan  1 18:12:05 conquest3 kernel:        c0174adc cece3000 c126a9e0
>>00b7c00b c126a9e0 00b7c00b c5d04910 cece3000
>>Jan  1 18:12:05 conquest3 kernel:        ce1f9e4c c019e42b cece3000
>>00b7c00b c938f084 fffffff4 c5d04910 c7b79e80
>>Jan  1 18:12:05 conquest3 kernel: Call Trace:
>>Jan  1 18:12:05 conquest3 kernel:  [get_new_inode_fast+31/304]
>>get_new_inode_fast+0x1f/0x130
>>Jan  1 18:12:05 conquest3 kernel:  [iget_locked+172/240]
>>iget_locked+0xac/0xf0
>>Jan  1 18:12:05 conquest3 kernel:  [ext3_lookup+107/208]
>>ext3_lookup+0x6b/0xd0
>>Jan  1 18:12:05 conquest3 kernel:  [real_lookup+193/240]
>>real_lookup+0xc1/0xf0
>>Jan  1 18:12:05 conquest3 kernel:  [do_lookup+157/176] do_lookup+0x9d/0xb0
>>Jan  1 18:12:05 conquest3 kernel:  [__link_path_walk+1876/3728]
>>__link_path_walk+0x754/0xe90
>>Jan  1 18:12:05 conquest3 kernel:  [__find_get_block+115/240]
>>__find_get_block+0x73/0xf0
>>Jan  1 18:12:05 conquest3 kernel:  [link_path_walk+71/224]
>>link_path_walk+0x47/0xe0
>>Jan  1 18:12:05 conquest3 kernel:  [path_lookup+127/320]
>>path_lookup+0x7f/0x140
>>Jan  1 18:12:05 conquest3 kernel:  [__user_walk+51/96] __user_walk+0x33/0x60
>>Jan  1 18:12:05 conquest3 kernel:  [vfs_lstat+28/96] vfs_lstat+0x1c/0x60
>>Jan  1 18:12:05 conquest3 kernel:  [sys_lstat64+27/64] sys_lstat64+0x1b/0x40
>>Jan  1 18:12:05 conquest3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Jan  1 18:12:05 conquest3 kernel: Code:  Bad EIP value.
>>...
> 
> 
> This looks strange.
> 
> Is it reproducible, and if yes, is it still present in 2.6.15?

I have only seen two instances under 2.6.14.5, and none so far under
2.6.15. I do not know how to reproduce the problem. I suppose that it is
a rare race condition showing up?

In case you are wondering, this has been, and I believe still is, rock
solid hardware: that is, not over clocked or marginal in any way. It
normally runs the latest even series released kernel. So it has run
under 2.2.*, 2.4.* and now 2.6.* kernels reliably.

I append the other case logged under 2.6.14.5 in case it throws any
extra light (which I doubt)

-----------------------------------------------------------------------------
Jan  2 17:51:03 conquest3 kernel: 00090157
Jan  2 17:51:03 conquest3 kernel: PREEMPT
Jan  2 17:51:03 conquest3 kernel: Modules linked in: loop snd_sbawe
snd_opl3_lib
 snd_sb16_dsp snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc
snd_sb1
6_csp snd_sb_common snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device
snd sou
ndcore capability commoncap ipv6 nfsd exportfs lockd sunrpc lp eeprom
w83781d hw
mon_vid hwmon i2c_isa mga drm ide_cd cdrom analog ns558 gameport
parport_pc parp
ort floppy 8250_pnp 8250 serial_core tulip crc32 i2c_piix4 i2c_core
usb_storage
uhci_hcd usbcore intel_agp agpgart nls_iso8859_1 nls_cp437 vfat fat
sd_mod st ai
c7xxx scsi_transport_spi scsi_mod rtc
Jan  2 17:51:03 conquest3 kernel: CPU:    0
Jan  2 17:51:03 conquest3 kernel: EIP:    0060:[<00090157>]    Not
tainted VLI
Jan  2 17:51:03 conquest3 kernel: EFLAGS: 00210296   (2.6.14.5)
Jan  2 17:51:03 conquest3 kernel: EIP is at 0x90157
Jan  2 17:51:03 conquest3 kernel: eax: c16738e8   ebx: 00000001   ecx:
00000000 edx: cfd24ce8
Jan  2 17:51:03 conquest3 kernel: esi: c621c000   edi: 00000000   ebp:
cecbb000  esp: c621dd70
Jan  2 17:51:03 conquest3 kernel: ds: 007b   es: 007b   ss: 0068
Jan  2 17:51:03 conquest3 kernel: Process find (pid: 19103,
threadinfo=c621c000task=c2396a50)
Jan  2 17:51:03 conquest3 kernel: Stack: c01744af cecbb000 cecbb000
c99f3844 c62
1c000 00000000 00090157 cecbb000
Jan  2 17:51:03 conquest3 kernel:        c0174adc cecbb000 c1263244
00090157 c12
63244 00090157 c62b1d50 cecbb000
Jan  2 17:51:03 conquest3 kernel:        c621de4c c019e42b cecbb000
00090157 c94
4d06c fffffff4 c62b1d50 c0fc59f0
Jan  2 17:51:03 conquest3 kernel: Call Trace:
Jan  2 17:51:03 conquest3 kernel:  [get_new_inode_fast+31/304]
get_new_inode_fas
t+0x1f/0x130
Jan  2 17:51:03 conquest3 kernel:  [iget_locked+172/240]
iget_locked+0xac/0xf0
Jan  2 17:51:03 conquest3 kernel:  [ext3_lookup+107/208]
ext3_lookup+0x6b/0xd0
Jan  2 17:51:03 conquest3 kernel:  [real_lookup+193/240]
real_lookup+0xc1/0xf0
Jan  2 17:51:03 conquest3 kernel:  [do_lookup+157/176] do_lookup+0x9d/0xb0
Jan  2 17:51:03 conquest3 kernel:  [__link_path_walk+1876/3728]
__link_path_walk
+0x754/0xe90
Jan  2 17:51:03 conquest3 kernel:  [__find_get_block+115/240]
__find_get_block+0
x73/0xf0
Jan  2 17:51:03 conquest3 kernel:  [link_path_walk+71/224]
link_path_walk+0x47/0
xe0
Jan  2 17:51:03 conquest3 kernel:  [path_lookup+127/320]
path_lookup+0x7f/0x140
Jan  2 17:51:03 conquest3 kernel:  [__user_walk+51/96] __user_walk+0x33/0x60
Jan  2 17:51:03 conquest3 kernel:  [vfs_lstat+28/96] vfs_lstat+0x1c/0x60
Jan  2 17:51:03 conquest3 kernel:  [sys_lstat64+27/64] sys_lstat64+0x1b/0x40
Jan  2 17:51:03 conquest3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan  2 17:51:03 conquest3 kernel: Code:  Bad EIP value.
Jan  2 17:51:10 conquest3 kernel:  <7>w83781d-isa 9191-0290: Starting
device upd
ate
Jan  2 18:14:45 conquest3 -- MARK --

------------------------------------------------------------------------------------------


