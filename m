Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTKWOws (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 09:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTKWOws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 09:52:48 -0500
Received: from bill.lut.ac.uk ([158.125.1.193]:3034 "EHLO bill.lut.ac.uk")
	by vger.kernel.org with ESMTP id S261762AbTKWOwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 09:52:43 -0500
Message-ID: <3FC0C9DF.2030700@lboro.ac.uk>
Date: Sun, 23 Nov 2003 14:53:19 +0000
From: A E Lawrence <A.E.Lawrence@lboro.ac.uk>
Organization: Not much
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030716
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 oss sound missing symbols
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scan-Signature: be845101b4e4921a9980b4ec8a202ba6
X-Spam-Score: -0.1 (/)
X-Lboro-Filtered: bill.lut.ac.uk, Sun, 23 Nov 2003 14:52:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 82C930 based sound card. Under 2.4.22 and earlier kernels, I use
the old OSS driver. Having failed to identify any support for this chip
under ALSA, I have configured 2.6.0-test9 with a similar OSS configuration.

The relevant parts of the .config files are:-

2.4.22                  2.6.0-test9
------                  -----------
# Sound                 # CONFIG_SND is not set
#                       CONFIG_SOUND_PRIME=m
CONFIG_SOUND=m          CONFIG_SOUND_OSS=y
                          CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_MPU401=m   CONFIG_SOUND_MPU401=m
CONFIG_SOUND_MAD16=m    CONFIG_SOUND_MAD16=m
CONFIG_SOUND_YM3812=m   CONFIG_SOUND_YM3812=m

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Under 2.6.0-test9, there are unresolved symbols:-


Building modules, stage 2.
    MODPOST
*** Warning: "sound_unload_mididev" [sound/oss/uart401.ko] undefined!
*** Warning: "sequencer_init" [sound/oss/uart401.ko] undefined!
*** Warning: "conf_printf" [sound/oss/uart401.ko] undefined!
*** Warning: "sound_alloc_mididev" [sound/oss/uart401.ko] undefined!
*** Warning: "midi_synth_send_sysex" [sound/oss/uart401.ko] undefined!
*** Warning: "midi_synth_setup_voice" [sound/oss/uart401.ko] undefined!
*** Warning: "midi_synth_bender" [sound/oss/uart401.ko] undefined!
*** Warning: "midi_synth_panning" [sound/oss/uart401.ko] undefined!
[.. snip ..]
*** Warning: "midi_synth_kill_note" [sound/oss/sb_lib.ko] undefined!
*** Warning: "sound_unload_mixerdev" [sound/oss/sb_lib.ko] undefined!
*** Warning: "midi_synth_setup_voice" [sound/oss/sb_lib.ko] undefined!
*** Warning: "midi_synth_aftertouch" [sound/oss/sb_lib.ko] undefined!
[..snip..]
*** Warning: "load_mixer_volumes" [sound/oss/sb_lib.ko] undefined!
*** Warning: "midi_synth_ioctl" [sound/oss/sb_lib.ko] undefined!
*** Warning: "sound_alloc_dma" [sound/oss/sb_lib.ko] undefined!
*** Warning: "sound_alloc_mixerdev" [sound/oss/sb_lib.ko] undefined!
*** Warning: "DMAbuf_outputintr" [sound/oss/sb_lib.ko] undefined!
*** Warning: "sound_alloc_mididev" [sound/oss/sb_lib.ko] undefined!
*** Warning: "conf_printf" [sound/oss/sb_lib.ko] undefined!
*** Warning: "sound_free_dma" [sound/oss/sb_lib.ko] undefined!
*** Warning: "midi_devs" [sound/oss/sb_lib.ko] undefined!
*** Warning: "midi_synth_set_instr" [sound/oss/sb_lib.ko] undefined!
*** Warning: "midi_synth_controller" [sound/oss/sb_lib.ko] undefined!
*** Warning: "DMAbuf_inputintr" [sound/oss/sb_lib.ko] undefined!
*** Warning: "midi_synth_reset" [sound/oss/sb_lib.ko] undefined!
*** Warning: "sound_unload_audiodev" [sound/oss/sb_lib.ko] undefined!
*** Warning: "audio_devs" [sound/oss/sb_lib.ko] undefined!
*** Warning: "sound_unload_synthdev" [sound/oss/opl3.ko] undefined!
*** Warning: "conf_printf2" [sound/oss/opl3.ko] undefined!
*** Warning: "sequencer_init" [sound/oss/opl3.ko] undefined!
*** Warning: "sound_alloc_synthdev" [sound/oss/opl3.ko] undefined!
*** Warning: "synth_devs" [sound/oss/opl3.ko] undefined!
*** Warning: "compute_finetune" [sound/oss/opl3.ko] undefined!
*** Warning: "note_to_freq" [sound/oss/opl3.ko] undefined!
*** Warning: "sound_alloc_timerdev" [sound/oss/mpu401.ko] undefined!
*** Warning: "seq_input_event" [sound/oss/mpu401.ko] undefined!
*** Warning: "sequencer_timer" [sound/oss/mpu401.ko] undefined!
*** Warning: "seq_copy_to_input" [sound/oss/mpu401.ko] undefined!
*** Warning: "sound_timer_devs" [sound/oss/mpu401.ko] undefined!
*** Warning: "sound_unload_timerdev" [sound/oss/mpu401.ko] undefined!
*** Warning: "sound_unload_mididev" [sound/oss/mpu401.ko] undefined!
*** Warning: "sequencer_init" [sound/oss/mpu401.ko] undefined!
*** Warning: "conf_printf" [sound/oss/mpu401.ko] undefined!
*** Warning: "sound_alloc_mididev" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_send_sysex" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_setup_voice" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_bender" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_panning" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_controller" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_aftertouch" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_load_patch" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_hw_control" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_reset" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_set_instr" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_start_note" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_kill_note" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_ioctl" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_close" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_synth_open" [sound/oss/mpu401.ko] undefined!
*** Warning: "synth_devs" [sound/oss/mpu401.ko] undefined!
*** Warning: "midi_devs" [sound/oss/mpu401.ko] undefined!
*** Warning: "num_midis" [sound/oss/mpu401.ko] undefined!
*** Warning: "do_midi_msg" [sound/oss/mpu401.ko] undefined!
*** Warning: "sound_unload_audiodev" [sound/oss/mad16.ko] undefined!
*** Warning: "sound_timer_init" [sound/oss/ad1848.ko] undefined!
*** Warning: "sound_timer_syncinterval" [sound/oss/ad1848.ko] undefined!
*** Warning: "sound_unload_audiodev" [sound/oss/ad1848.ko] undefined!
*** Warning: "DMAbuf_inputintr" [sound/oss/ad1848.ko] undefined!
*** Warning: "DMAbuf_outputintr" [sound/oss/ad1848.ko] undefined!
*** Warning: "sound_timer_interrupt" [sound/oss/ad1848.ko] undefined!
*** Warning: "sound_unload_mixerdev" [sound/oss/ad1848.ko] undefined!
*** Warning: "sound_free_dma" [sound/oss/ad1848.ko] undefined!
*** Warning: "sound_alloc_dma" [sound/oss/ad1848.ko] undefined!
*** Warning: "sound_install_mixer" [sound/oss/ad1848.ko] undefined!
*** Warning: "sound_install_audiodrv" [sound/oss/ad1848.ko] undefined!
*** Warning: "conf_printf2" [sound/oss/ad1848.ko] undefined!
*** Warning: "num_audiodevs" [sound/oss/ad1848.ko] undefined!
*** Warning: "audio_devs" [sound/oss/ad1848.ko] undefined!
*** Warning: "mixer_devs" [sound/oss/ad1848.ko] undefined!
*** Warning: "load_mixer_volumes" [sound/oss/ad1848.ko] undefined!

Greping for one of these gives:-

2.6.0-test9
===========
sound]$ grep -ir midi_synth_set_instr *
oss/wf_midi.c:  .set_instr      = midi_synth_set_instr,
oss/midi_syms.c:EXPORT_SYMBOL(midi_synth_set_instr);
oss/midi_synth.h:int midi_synth_set_instr (int dev, int channel, int instr_no);
oss/midi_synth.h:       .set_instr      = midi_synth_set_instr,
oss/wavfront.c: .set_instr      = midi_synth_set_instr,
oss/midi_synth.c:midi_synth_set_instr(int dev, int channel, int instr_no)
oss/mpu401.c:   .set_instr      = midi_synth_set_instr,
Binary file oss/midi_syms.o matches
Binary file oss/midi_synth.o matches
Binary file oss/sound.o matches
Binary file oss/built-in.o matches
Binary file oss/sb_midi.o matches
Binary file oss/sb_lib.o matches
Binary file oss/uart401.o matches
Binary file oss/mpu401.o matches
Binary file oss/mpu401.ko matches
Binary file oss/sb_lib.ko matches
Binary file oss/uart401.ko matches


A similar grep in 2.4.22:-
==========================
sound]$ grep -ir midi_synth_set_instr *
midi_syms.c:EXPORT_SYMBOL(midi_synth_set_instr);
Binary file midi_syms.o matches
midi_synth.c:midi_synth_set_instr(int dev, int channel, int instr_no)
midi_synth.h:int midi_synth_set_instr (int dev, int channel, int instr_no);
midi_synth.h:   set_instr:      midi_synth_set_instr,
Binary file midi_synth.o matches
mpu401.c:       set_instr:      midi_synth_set_instr,
Binary file mpu401.o matches
Binary file sb_lib.o matches
Binary file sb_midi.o matches
Binary file sound.o matches
Binary file uart401.o matches
wavfront.c:     set_instr:      midi_synth_set_instr,
wf_midi.c:      set_instr:      midi_synth_set_instr,

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Have I misconfigured 2.6.0-test9?

ael



