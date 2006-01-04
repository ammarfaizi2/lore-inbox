Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWADTvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWADTvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbWADTvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:51:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21002 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965272AbWADTvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:51:39 -0500
Date: Wed, 4 Jan 2006 20:51:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ael <law_ence.dev@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, phil@netroedge.com, mdsxyz123@yahoo.com
Subject: Re: Oops in kernel 2.6.14.5
Message-ID: <20060104195137.GS3831@stusta.de>
References: <43B8410A.10609@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B8410A.10609@ntlworld.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 08:52:26PM +0000, ael wrote:
> Jan  1 18:12:05 conquest3 kernel: 00b7c00b
> Jan  1 18:12:05 conquest3 kernel: PREEMPT
> Jan  1 18:12:05 conquest3 kernel: Modules linked in: nls_cp850 isofs
> snd_sbawe snd_opl3_lib snd_sb16_dsp snd_pcm_oss snd
> _mixer_oss snd_pcm snd_timer snd_page_alloc snd_sb16_csp snd_sb_common
> snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_dev
> ice snd soundcore capability commoncap ipv6 nfsd exportfs lockd sunrpc
> lp eeprom w83781d hwmon_vid hwmon i2c_isa mga drm
>  ide_cd cdrom analog ns558 gameport parport_pc parport floppy 8250_pnp
> 8250 serial_core tulip crc32 i2c_piix4 i2c_core u
> sb_storage uhci_hcd usbcore intel_agp agpgart nls_iso8859_1 nls_cp437
> vfat fat sd_mod st aic7xxx scsi_transport_spi scsi
> _mod rtc
> Jan  1 18:12:05 conquest3 kernel: CPU:    0
> Jan  1 18:12:05 conquest3 kernel: EIP:
> 0060:[phys_startup_32+10993675/-1073741824]    Not tainted VLI
> Jan  1 18:12:05 conquest3 kernel: EFLAGS: 00210296   (2.6.14.5)
> Jan  1 18:12:05 conquest3 kernel: EIP is at 0xb7c00b
> Jan  1 18:12:05 conquest3 kernel: eax: c20738e8   ebx: 00000001   ecx:
> 00000000   edx: cfd24ce8
> Jan  1 18:12:05 conquest3 kernel: esi: ce1f8000   edi: 00000000   ebp:
> cece3000   esp: ce1f9d70
> Jan  1 18:12:05 conquest3 kernel: ds: 007b   es: 007b   ss: 0068
> Jan  1 18:12:05 conquest3 kernel: Process find (pid: 4230,
> threadinfo=ce1f8000 task=cdcf1a50)
> Jan  1 18:12:05 conquest3 kernel: Stack: c01744af cece3000 cece3000
> cee3b1e4 ce1f8000 00000000 00b7c00b cece3000
> Jan  1 18:12:05 conquest3 kernel:        c0174adc cece3000 c126a9e0
> 00b7c00b c126a9e0 00b7c00b c5d04910 cece3000
> Jan  1 18:12:05 conquest3 kernel:        ce1f9e4c c019e42b cece3000
> 00b7c00b c938f084 fffffff4 c5d04910 c7b79e80
> Jan  1 18:12:05 conquest3 kernel: Call Trace:
> Jan  1 18:12:05 conquest3 kernel:  [get_new_inode_fast+31/304]
> get_new_inode_fast+0x1f/0x130
> Jan  1 18:12:05 conquest3 kernel:  [iget_locked+172/240]
> iget_locked+0xac/0xf0
> Jan  1 18:12:05 conquest3 kernel:  [ext3_lookup+107/208]
> ext3_lookup+0x6b/0xd0
> Jan  1 18:12:05 conquest3 kernel:  [real_lookup+193/240]
> real_lookup+0xc1/0xf0
> Jan  1 18:12:05 conquest3 kernel:  [do_lookup+157/176] do_lookup+0x9d/0xb0
> Jan  1 18:12:05 conquest3 kernel:  [__link_path_walk+1876/3728]
> __link_path_walk+0x754/0xe90
> Jan  1 18:12:05 conquest3 kernel:  [__find_get_block+115/240]
> __find_get_block+0x73/0xf0
> Jan  1 18:12:05 conquest3 kernel:  [link_path_walk+71/224]
> link_path_walk+0x47/0xe0
> Jan  1 18:12:05 conquest3 kernel:  [path_lookup+127/320]
> path_lookup+0x7f/0x140
> Jan  1 18:12:05 conquest3 kernel:  [__user_walk+51/96] __user_walk+0x33/0x60
> Jan  1 18:12:05 conquest3 kernel:  [vfs_lstat+28/96] vfs_lstat+0x1c/0x60
> Jan  1 18:12:05 conquest3 kernel:  [sys_lstat64+27/64] sys_lstat64+0x1b/0x40
> Jan  1 18:12:05 conquest3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Jan  1 18:12:05 conquest3 kernel: Code:  Bad EIP value.
>...

This looks strange.

Is it reproducible, and if yes, is it still present in 2.6.15?

> ael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

