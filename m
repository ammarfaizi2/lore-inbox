Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293341AbSCJWLU>; Sun, 10 Mar 2002 17:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293342AbSCJWLK>; Sun, 10 Mar 2002 17:11:10 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:9785 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S293341AbSCJWK4>; Sun, 10 Mar 2002 17:10:56 -0500
Date: Sun, 10 Mar 2002 23:10:33 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.6 failed to compile
Message-ID: <Pine.LNX.4.44.0203102304350.6677-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

lt:/usr/src/linux# gcc --version
2.96
lt:/usr/src/linux# rpm -q gcc
gcc-2.96-98


ld -m elf_i386 -T /usr/src/linux-2.5.6/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
        /usr/src/linux-2.5.6/arch/i386/lib/lib.a 
/usr/src/linux-2.5.6/lib/lib.a
/usr/src/linux-2.5.6/arch/i386/lib/lib.a \
         drivers/parport/driver.o drivers/base/base.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/media/media.o drivers/char/agp/agp.o drivers/net/wan/wan.o 
drivers/ide/idedriver.o drivers/cdrom/driver.o sound/sound.o 
drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o \
        net/network.o \
        --end-group \
        -o vmlinux
drivers/net/net.o: In function `z_comp_delayedfree':
drivers/net/net.o(.text+0x72b2): undefined reference to `local_bh_enable'
drivers/net/net.o(.text+0x72cc): undefined reference to `local_bh_disable'
drivers/net/net.o(.text+0x72df): undefined reference to `local_bh_enable'
drivers/net/net.o: In function `z_comp_free':
drivers/net/net.o(.text+0x7304): undefined reference to `local_bh_disable'
drivers/net/net.o(.text+0x7324): undefined reference to `local_bh_enable'
sound/sound.o: In function `sound_alloc_dmap':
sound/sound.o(.text+0x36e7): undefined reference to `virt_to_bus_not_defined_use_pci_map'
sound/sound.o: In function `snd_pcm_oss_period_size':
sound/sound.o(.text+0x164f0): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o(.text+0x16508): undefined reference to `snd_pcm_hw_param_value_max'
sound/sound.o(.text+0x165d0): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o(.text+0x16646): undefined reference to `snd_pcm_hw_param_value_min'
sound/sound.o(.text+0x166b5): undefined reference to `snd_pcm_hw_param_value_max'
sound/sound.o(.text+0x1673e): undefined reference to `snd_pcm_hw_param_value_max'
sound/sound.o(.text+0x16767): undefined reference to `snd_pcm_hw_param_value_min'
sound/sound.o: In function `snd_pcm_oss_change_params':
sound/sound.o(.text+0x16800): undefined reference to `_snd_pcm_hw_params_any'
sound/sound.o(.text+0x16808): undefined reference to `_snd_pcm_hw_param_setinteger'
sound/sound.o(.text+0x16814): undefined reference to `_snd_pcm_hw_param_min'
sound/sound.o(.text+0x1685e): undefined reference to `snd_pcm_hw_param_mask'
sound/sound.o(.text+0x16887): undefined reference to `snd_pcm_hw_param_near'
sound/sound.o(.text+0x1689e): undefined reference to `snd_pcm_hw_param_near'
sound/sound.o(.text+0x16920): undefined reference to `_snd_pcm_hw_param_set'
sound/sound.o(.text+0x16949): undefined reference to `_snd_pcm_hw_params_any'
sound/sound.o(.text+0x16955): undefined reference to `_snd_pcm_hw_param_set'
sound/sound.o(.text+0x1696d): undefined reference to `_snd_pcm_hw_param_set'
sound/sound.o(.text+0x16980): undefined reference to `_snd_pcm_hw_param_set'
sound/sound.o(.text+0x16990): undefined reference to `_snd_pcm_hw_param_set'
sound/sound.o(.text+0x169a8): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o(.text+0x16ad7): undefined reference to `snd_pcm_hw_param_near'
sound/sound.o(.text+0x16aee): undefined reference to `snd_pcm_hw_param_near'
sound/sound.o(.text+0x16b04): undefined reference to `snd_pcm_kernel_ioctl'
sound/sound.o(.text+0x16b16): undefined reference to `snd_pcm_kernel_ioctl'
sound/sound.o(.text+0x16bb3): undefined reference to `snd_pcm_kernel_ioctl'
sound/sound.o(.text+0x16ce3): undefined reference to `snd_pcm_format_set_silence'
sound/sound.o: In function `snd_pcm_oss_prepare':
sound/sound.o(.text+0x16d71): undefined reference to `snd_pcm_kernel_ioctl'
sound/sound.o: In function `snd_pcm_oss_write3':
sound/sound.o(.text+0x16e26): undefined reference to `snd_pcm_lib_write'
sound/sound.o(.text+0x16e4a): undefined reference to `snd_pcm_lib_write'
sound/sound.o: In function `snd_pcm_oss_read3':
sound/sound.o(.text+0x16ee0): undefined reference to `snd_pcm_kernel_ioctl'
sound/sound.o(.text+0x16f04): undefined reference to `snd_pcm_lib_read'
sound/sound.o(.text+0x16f24): undefined reference to `snd_pcm_lib_read'
sound/sound.o(.text+0x16f37): undefined reference to `snd_pcm_lib_read'
sound/sound.o: In function `snd_pcm_oss_writev3':
sound/sound.o(.text+0x16fa3): undefined reference to `snd_pcm_lib_writev'
sound/sound.o(.text+0x16fb9): undefined reference to `snd_pcm_lib_writev'
sound/sound.o: In function `snd_pcm_oss_readv3':
sound/sound.o(.text+0x1703d): undefined reference to `snd_pcm_kernel_ioctl'
sound/sound.o(.text+0x17076): undefined reference to `snd_pcm_lib_readv'
sound/sound.o(.text+0x1708c): undefined reference to `snd_pcm_lib_readv'
sound/sound.o: In function `snd_pcm_oss_reset':
sound/sound.o(.text+0x17506): undefined reference to `snd_pcm_kernel_playback_ioctl'
sound/sound.o(.text+0x17527): undefined reference to `snd_pcm_kernel_capture_ioctl'
sound/sound.o: In function `snd_pcm_oss_sync':
sound/sound.o(.text+0x175c8): undefined reference to `snd_pcm_format_set_silence'
sound/sound.o(.text+0x17670): undefined reference to `snd_pcm_kernel_playback_ioctl'
sound/sound.o(.text+0x176b0): undefined reference to `snd_pcm_kernel_capture_ioctl'
sound/sound.o: In function `snd_pcm_oss_get_formats':
sound/sound.o(.text+0x178a4): undefined reference to `_snd_pcm_hw_params_any'
sound/sound.o(.text+0x178b3): undefined reference to `snd_pcm_hw_refine'
sound/sound.o: In function `snd_pcm_oss_set_trigger':
sound/sound.o(.text+0x17c6a): undefined reference to `snd_pcm_kernel_playback_ioctl'
sound/sound.o(.text+0x17ccf): undefined reference to `snd_pcm_kernel_capture_ioctl'
sound/sound.o: In function `snd_pcm_oss_get_odelay':
sound/sound.o(.text+0x17d79): undefined reference to `snd_pcm_kernel_playback_ioctl'
sound/sound.o: In function `snd_pcm_oss_get_ptr':
sound/sound.o(.text+0x17e7a): undefined reference to `snd_pcm_kernel_ioctl'
sound/sound.o: In function `snd_pcm_oss_get_space':
sound/sound.o(.text+0x18088): undefined reference to `snd_pcm_kernel_ioctl'
sound/sound.o: In function `snd_pcm_oss_release_file':
sound/sound.o(.text+0x18338): undefined reference to `snd_pcm_stop'
sound/sound.o(.text+0x18363): undefined reference to `snd_pcm_release_substream'
sound/sound.o: In function `snd_pcm_oss_open_file':
sound/sound.o(.text+0x18410): undefined reference to `snd_pcm_open_substream'
sound/sound.o(.text+0x18446): undefined reference to `snd_pcm_open_substream'
sound/sound.o(.text+0x1848c): undefined reference to `snd_pcm_hw_constraints_init'
sound/sound.o(.text+0x184ad): undefined reference to `snd_pcm_hw_constraints_complete'
sound/sound.o(.text+0x184e9): undefined reference to `snd_pcm_hw_constraints_init'
sound/sound.o(.text+0x18524): undefined reference to `snd_pcm_hw_constraints_complete'
sound/sound.o: In function `snd_pcm_oss_open':
sound/sound.o(.text+0x185d2): undefined reference to `snd_pcm_devices'
sound/sound.o: In function `snd_pcm_oss_mmap':
sound/sound.o(.text+0x192d3): undefined reference to `snd_pcm_mmap_data'
sound/sound.o: In function `snd_pcm_oss_playback_ready':
sound/sound.o(.text+0x19125): undefined reference to `snd_pcm_playback_ready'
sound/sound.o: In function `snd_pcm_oss_capture_ready':
sound/sound.o(.text+0x19165): undefined reference to `snd_pcm_capture_ready'
sound/sound.o: In function `snd_pcm_plugin_alloc':
sound/sound.o(.text+0x19b67): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o: In function `snd_pcm_plugin_build':
sound/sound.o(.text+0x19dbf): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o(.text+0x19dda): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o: In function `snd_pcm_plug_slave_format':
sound/sound.o(.text+0x1a074): undefined reference to `snd_pcm_format_linear'
sound/sound.o(.text+0x1a083): undefined reference to `snd_pcm_format_width'
sound/sound.o(.text+0x1a08d): undefined reference to `snd_pcm_format_unsigned'
sound/sound.o(.text+0x1a097): undefined reference to `snd_pcm_format_big_endian'
sound/sound.o(.text+0x1a0e4): undefined reference to `snd_pcm_build_linear_format'
sound/sound.o: In function `snd_pcm_plug_format_plugins':
sound/sound.o(.text+0x1a2a4): undefined reference to `snd_pcm_format_linear'
sound/sound.o(.text+0x1a2b6): undefined reference to `snd_pcm_format_linear'
sound/sound.o(.text+0x1a3c8): undefined reference to `snd_pcm_format_linear'
sound/sound.o(.text+0x1a471): undefined reference to `snd_pcm_format_linear'
sound/sound.o(.text+0x1a55d): undefined reference to `snd_pcm_format_linear'
sound/sound.o(.text+0x1a612): more undefined references to `snd_pcm_format_linear' follow
sound/sound.o: In function `snd_pcm_plug_client_channels_buf':
sound/sound.o(.text+0x1a739): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o: In function `snd_pcm_area_silence':
sound/sound.o(.text+0x1ad79): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o(.text+0x1ad83): undefined reference to `snd_pcm_format_silence_64'
sound/sound.o: In function `snd_pcm_areas_silence':
sound/sound.o(.text+0x1af44): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o: In function `snd_pcm_area_copy':
sound/sound.o(.text+0x1b0a6): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o: In function `snd_pcm_areas_copy':
sound/sound.o(.text+0x1b2f4): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o: In function `snd_pcm_plugin_build_copy':
sound/sound.o(.text+0x1b77f): undefined reference to `snd_pcm_format_physical_width'
sound/sound.o: In function `conv_index':
sound/sound.o(.text+0x1bf1f): undefined reference to `snd_pcm_format_signed'
sound/sound.o(.text+0x1bf27): undefined reference to `snd_pcm_format_signed'
sound/sound.o(.text+0x1bf3c): undefined reference to `snd_pcm_format_big_endian'
sound/sound.o(.text+0x1bf44): undefined reference to `snd_pcm_format_big_endian'
sound/sound.o(.text+0x1bf5e): undefined reference to `snd_pcm_format_width'
sound/sound.o(.text+0x1bf71): undefined reference to `snd_pcm_format_width'
sound/sound.o: In function `getput_index':
sound/sound.o(.text+0x1d6be): undefined reference to `snd_pcm_format_signed'
sound/sound.o(.text+0x1d6cf): undefined reference to `snd_pcm_format_width'
sound/sound.o(.text+0x1d6e2): undefined reference to `snd_pcm_format_big_endian'
sound/sound.o: In function `snd_pcm_plugin_build_route':
sound/sound.o(.text+0x1d76e): undefined reference to `snd_pcm_format_width'
sound/sound.o(.text+0x1d787): undefined reference to `snd_pcm_format_width'
sound/sound.o: In function `alsa_pcm_oss_init':
sound/sound.o(.text.init+0x9b4): undefined reference to `snd_pcm_notify'
make: *** [vmlinux] Error 1


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

