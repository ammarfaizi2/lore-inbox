Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTBFM6g>; Thu, 6 Feb 2003 07:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbTBFM6g>; Thu, 6 Feb 2003 07:58:36 -0500
Received: from exzh001.alcatel.ch ([212.243.156.171]:57092 "HELO
	exzh001.alcatel.ch") by vger.kernel.org with SMTP
	id <S267106AbTBFM6f> convert rfc822-to-8bit; Thu, 6 Feb 2003 07:58:35 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jaroslav Kysela <perex@suse.cz>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [ALSA] unresolved symbols...makefile problems
Date: Thu, 6 Feb 2003 14:08:05 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302061408.05999.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

current 2.5 gives these, the problem are the makefiles...those modules are
compiled even if the sound drivers themself aren't...

from depmod:
WARNING: /lib/modules/2.5.59/kernel/sound/synth/emux/snd-emux-synth.ko needs unknown symbol snd_util_mem_avail
WARNING: /lib/modules/2.5.59/kernel/sound/pci/trident/snd-trident-synth.ko needs unknown symbol snd_trident_alloc_voice
WARNING: /lib/modules/2.5.59/kernel/sound/pci/trident/snd-trident-synth.ko needs unknown symbol snd_trident_synth_free
WARNING: /lib/modules/2.5.59/kernel/sound/pci/trident/snd-trident-synth.ko needs unknown symbol snd_trident_start_voice
WARNING: /lib/modules/2.5.59/kernel/sound/pci/trident/snd-trident-synth.ko needs unknown symbol snd_trident_write_voice_regs
WARNING: /lib/modules/2.5.59/kernel/sound/pci/trident/snd-trident-synth.ko needs unknown symbol snd_trident_synth_alloc
WARNING: /lib/modules/2.5.59/kernel/sound/pci/trident/snd-trident-synth.ko needs unknown symbol snd_trident_stop_voice
WARNING: /lib/modules/2.5.59/kernel/sound/pci/trident/snd-trident-synth.ko needs unknown symbol snd_trident_synth_copy_from_user
WARNING: /lib/modules/2.5.59/kernel/sound/pci/trident/snd-trident-synth.ko needs unknown symbol snd_trident_free_voice
WARNING: /lib/modules/2.5.59/kernel/sound/pci/emu10k1/snd-emu10k1-synth.ko needs unknown symbol snd_emu10k1_ptr_read
WARNING: /lib/modules/2.5.59/kernel/sound/pci/emu10k1/snd-emu10k1-synth.ko needs unknown symbol snd_emu10k1_synth_copy_from_user
WARNING: /lib/modules/2.5.59/kernel/sound/pci/emu10k1/snd-emu10k1-synth.ko needs unknown symbol snd_emu10k1_voice_free
WARNING: /lib/modules/2.5.59/kernel/sound/pci/emu10k1/snd-emu10k1-synth.ko needs unknown symbol snd_emu10k1_synth_free
WARNING: /lib/modules/2.5.59/kernel/sound/pci/emu10k1/snd-emu10k1-synth.ko needs unknown symbol snd_emu10k1_ptr_write
WARNING: /lib/modules/2.5.59/kernel/sound/pci/emu10k1/snd-emu10k1-synth.ko needs unknown symbol snd_emu10k1_synth_bzero
WARNING: /lib/modules/2.5.59/kernel/sound/pci/emu10k1/snd-emu10k1-synth.ko needs unknown symbol snd_emu10k1_voice_alloc
WARNING: /lib/modules/2.5.59/kernel/sound/pci/emu10k1/snd-emu10k1-synth.ko needs unknown symbol snd_emu10k1_memblk_map
WARNING: /lib/modules/2.5.59/kernel/sound/pci/emu10k1/snd-emu10k1-synth.ko needs unknown symbol snd_emu10k1_synth_alloc
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_update_equalizer
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_init_fm
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_peek_dw
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_poke_dw
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_util_mem_alloc
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_update_reverb_mode
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_poke
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_util_memhdr_new
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_update_chorus_mode
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_dma_chan
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_load_reverb_fx
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_util_mem_free
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_util_memhdr_free
WARNING: /lib/modules/2.5.59/kernel/sound/isa/sb/snd-emu8000-synth.ko needs unknown symbol snd_emu8000_load_chorus_fx
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_mem_free
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_ctrl_stop
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_write_addr
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_mem_lock
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_write16
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gus_dram_write
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_translate_freq
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_lvol_to_gvol_raw
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gus_use_inc
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_mem_xfree
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_free_voice
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gus_dram_read
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_look8
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_write8
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_alloc_voice
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_delay
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_atten_table
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_look16
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gus_use_dec
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_stop_voice
WARNING: /lib/modules/2.5.59/kernel/sound/isa/gus/snd-gus-synth.ko needs unknown symbol snd_gf1_mem_alloc



