Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVHOKct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVHOKct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 06:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVHOKcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 06:32:48 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:48513 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932588AbVHOKcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 06:32:48 -0400
Message-ID: <43006EFD.6040906@gmail.com>
Date: Mon, 15 Aug 2005 12:31:25 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Gabriel Devenyi <ace@staticwave.ca>
CC: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] sound/ buildcheck fixes
References: <200508142023.14439.ace@staticwave.ca>
In-Reply-To: <200508142023.14439.ace@staticwave.ca>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Devenyi napsal(a):

>This applies to linus' current git tree and fixes the following "make buildcheck" errors.
>Sorry about the compression, its too large otherwise.
>
>Error: ./sound/core/hwdep.o .eh_frame refers to 00000000000002c8 R_X86_64_64       .init.text
>Error: ./sound/core/info.o .eh_frame refers to 0000000000000400 R_X86_64_64       .init.text
>Error: ./sound/core/init.o .eh_frame refers to 0000000000000210 R_X86_64_64       .init.text
>Error: ./sound/core/memalloc.o .eh_frame refers to 00000000000002b0 R_X86_64_64       .init.text
>Error: ./sound/core/memory.o .eh_frame refers to 00000000000001a8 R_X86_64_64       .init.text
>Error: ./sound/core/oss/mixer_oss.o .eh_frame refers to 0000000000000628 R_X86_64_64       .init.text
>Error: ./sound/core/oss/pcm_oss.o .eh_frame refers to 00000000000008d0 R_X86_64_64       .init.text
>Error: ./sound/core/oss/snd-mixer-oss.o .eh_frame refers to 0000000000000628 R_X86_64_64       .init.text
>Error: ./sound/core/pcm.o .eh_frame refers to 0000000000000438 R_X86_64_64       .init.text
>Error: ./sound/core/rawmidi.o .eh_frame refers to 0000000000000860 R_X86_64_64       .init.text
>Error: ./sound/core/rtctimer.o .eh_frame refers to 00000000000000c8 R_X86_64_64       .init.text
>Error: ./sound/core/seq/instr/ainstr_fm.o .eh_frame refers to 00000000000000a8 R_X86_64_64       .init.text
>Error: ./sound/core/seq/instr/ainstr_simple.o .eh_frame refers to 0000000000000138 R_X86_64_64       .init.text
>Error: ./sound/core/seq/instr/snd-ainstr-fm.o .eh_frame refers to 00000000000000a8 R_X86_64_64       .init.text
>Error: ./sound/core/seq/instr/snd-ainstr-simple.o .eh_frame refers to 0000000000000138 R_X86_64_64       .init.text
>Error: ./sound/core/seq/oss/seq_oss.o .eh_frame refers to 0000000000000190 R_X86_64_64       .init.text
>Error: ./sound/core/seq/oss/seq_oss_init.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/core/seq/oss/seq_oss_midi.o .eh_frame refers to 00000000000000a0 R_X86_64_64       .init.text
>Error: ./sound/core/seq/oss/seq_oss_synth.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_clientmgr.o .eh_frame refers to 0000000000000088 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_clientmgr.o .eh_frame refers to 0000000000000c80 R_X86_64_64       .init.text+0x000000000000002b
>Error: ./sound/core/seq/seq_device.o .eh_frame refers to 0000000000000360 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_dummy.o .eh_frame refers to 0000000000000088 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_dummy.o .eh_frame refers to 00000000000000d0 R_X86_64_64       .init.text+0x0000000000000150
>Error: ./sound/core/seq/seq_info.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_info.o .eh_frame refers to 0000000000000048 R_X86_64_64       .init.text+0x0000000000000056
>Error: ./sound/core/seq/seq_instr.o .eh_frame refers to 0000000000000238 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_memory.o .eh_frame refers to 0000000000000270 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_midi.o .eh_frame refers to 0000000000000258 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_midi_emul.o .eh_frame refers to 00000000000001c0 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_midi_event.o .eh_frame refers to 00000000000002f8 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_queue.o .eh_frame refers to 0000000000000090 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_system.o .eh_frame refers to 0000000000000070 R_X86_64_64       .init.text
>Error: ./sound/core/seq/seq_virmidi.o .eh_frame refers to 00000000000002c8 R_X86_64_64       .init.text
>Error: ./sound/core/seq/snd-seq-device.o .eh_frame refers to 0000000000000360 R_X86_64_64       .init.text
>Error: ./sound/core/seq/snd-seq-dummy.o .eh_frame refers to 0000000000000088 R_X86_64_64       .init.text
>Error: ./sound/core/seq/snd-seq-dummy.o .eh_frame refers to 00000000000000d0 R_X86_64_64       .init.text+0x0000000000000150
>Error: ./sound/core/seq/snd-seq-instr.o .eh_frame refers to 0000000000000238 R_X86_64_64       .init.text
>Error: ./sound/core/seq/snd-seq-midi-emul.o .eh_frame refers to 00000000000001c0 R_X86_64_64       .init.text
>Error: ./sound/core/seq/snd-seq-midi-event.o .eh_frame refers to 00000000000002f8 R_X86_64_64       .init.text
>Error: ./sound/core/seq/snd-seq-midi.o .eh_frame refers to 0000000000000258 R_X86_64_64       .init.text
>Error: ./sound/core/seq/snd-seq-virmidi.o .eh_frame refers to 00000000000002c8 R_X86_64_64       .init.text
>Error: ./sound/core/snd-hwdep.o .eh_frame refers to 00000000000002c8 R_X86_64_64       .init.text
>Error: ./sound/core/snd-rawmidi.o .eh_frame refers to 0000000000000860 R_X86_64_64       .init.text
>Error: ./sound/core/snd-rtctimer.o .eh_frame refers to 00000000000000c8 R_X86_64_64       .init.text
>Error: ./sound/core/snd-timer.o .eh_frame refers to 00000000000007b8 R_X86_64_64       .init.text
>Error: ./sound/core/sound.o .eh_frame refers to 0000000000000180 R_X86_64_64       .init.text
>Error: ./sound/core/sound.o .eh_frame refers to 00000000000001c8 R_X86_64_64       .init.text+0x000000000000004a
>Error: ./sound/core/sound_oss.o .eh_frame refers to 0000000000000118 R_X86_64_64       .init.text
>Error: ./sound/core/sound_oss.o .eh_frame refers to 0000000000000160 R_X86_64_64       .init.text+0x000000000000004f
>Error: ./sound/core/timer.o .eh_frame refers to 00000000000007b8 R_X86_64_64       .init.text
>Error: ./sound/drivers/dummy.o .eh_frame refers to 0000000000000358 R_X86_64_64       .init.text
>Error: ./sound/drivers/mpu401/mpu401.o .eh_frame refers to 00000000000000c0 R_X86_64_64       .init.text
>Error: ./sound/drivers/mpu401/mpu401_uart.o .eh_frame refers to 0000000000000390 R_X86_64_64       .init.text
>Error: ./sound/drivers/mpu401/snd-mpu401-uart.o .eh_frame refers to 0000000000000390 R_X86_64_64       .init.text
>Error: ./sound/drivers/mpu401/snd-mpu401.o .eh_frame refers to 00000000000000c0 R_X86_64_64       .init.text
>Error: ./sound/drivers/mtpav.o .eh_frame refers to 00000000000002e0 R_X86_64_64       .init.text
>Error: ./sound/drivers/opl3/opl3_lib.o .eh_frame refers to 00000000000002d0 R_X86_64_64       .init.text
>Error: ./sound/drivers/opl3/opl3_seq.o .eh_frame refers to 00000000000001c0 R_X86_64_64       .init.text
>Error: ./sound/drivers/serial-u16550.o .eh_frame refers to 0000000000000298 R_X86_64_64       .init.text
>Error: ./sound/drivers/serial-u16550.o .eh_frame refers to 00000000000002c8 R_X86_64_64       .init.text+0x000000000000003b
>Error: ./sound/drivers/snd-dummy.o .eh_frame refers to 0000000000000358 R_X86_64_64       .init.text
>Error: ./sound/drivers/snd-mtpav.o .eh_frame refers to 00000000000002e0 R_X86_64_64       .init.text
>Error: ./sound/drivers/snd-serial-u16550.o .eh_frame refers to 0000000000000298 R_X86_64_64       .init.text
>Error: ./sound/drivers/snd-serial-u16550.o .eh_frame refers to 00000000000002c8 R_X86_64_64       .init.text+0x000000000000003b
>Error: ./sound/drivers/snd-virmidi.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/drivers/virmidi.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/drivers/vx/vx_core.o .eh_frame refers to 0000000000000390 R_X86_64_64       .init.text
>Error: ./sound/i2c/cs8427.o .eh_frame refers to 00000000000003b0 R_X86_64_64       .init.text
>Error: ./sound/i2c/i2c.o .eh_frame refers to 00000000000002c0 R_X86_64_64       .init.text
>Error: ./sound/i2c/other/ak4xxx-adda.o .eh_frame refers to 0000000000000228 R_X86_64_64       .init.text
>Error: ./sound/i2c/other/snd-ak4xxx-adda.o .eh_frame refers to 0000000000000228 R_X86_64_64       .init.text
>Error: ./sound/i2c/other/snd-tea575x-tuner.o .eh_frame refers to 00000000000000d8 R_X86_64_64       .init.text
>Error: ./sound/i2c/other/tea575x-tuner.o .eh_frame refers to 00000000000000d8 R_X86_64_64       .init.text
>Error: ./sound/i2c/snd-cs8427.o .eh_frame refers to 00000000000003b0 R_X86_64_64       .init.text
>Error: ./sound/i2c/snd-i2c.o .eh_frame refers to 00000000000002c0 R_X86_64_64       .init.text
>Error: ./sound/isa/sb/sb_common.o .eh_frame refers to 0000000000000110 R_X86_64_64       .init.text
>Error: ./sound/last.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/oss/aci.o .eh_frame refers to 0000000000000168 R_X86_64_64       .init.text
>Error: ./sound/oss/ad1816.o .eh_frame refers to 0000000000000418 R_X86_64_64       .init.text
>Error: ./sound/oss/ad1816.o .eh_frame refers to 00000000000004a8 R_X86_64_64       .init.text+0x00000000000005fd
>Error: ./sound/oss/ad1848.o .eh_frame refers to 00000000000007b0 R_X86_64_64       .init.text
>Error: ./sound/oss/ad1848.o .eh_frame refers to 00000000000007f8 R_X86_64_64       .init.text+0x000000000000023c
>Error: ./sound/oss/ad1889.o .eh_frame refers to 00000000000002f8 R_X86_64_64       .init.text
>Error: ./sound/oss/adlib_card.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/oss/adlib_card.o .eh_frame refers to 0000000000000060 R_X86_64_64       .init.text+0x000000000000005c
>Error: ./sound/oss/aedsp16.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/oss/aedsp16.o .eh_frame refers to 0000000000000038 R_X86_64_64       .init.text+0x000000000000001f
>Error: ./sound/oss/aedsp16.o .eh_frame refers to 0000000000000058 R_X86_64_64       .init.text+0x0000000000000039
>Error: ./sound/oss/aedsp16.o .eh_frame refers to 0000000000000078 R_X86_64_64       .init.text+0x0000000000000067
>Error: ./sound/oss/aedsp16.o .eh_frame refers to 0000000000000098 R_X86_64_64       .init.text+0x00000000000000f9
>Error: ./sound/oss/aedsp16.o .eh_frame refers to 00000000000000b8 R_X86_64_64       .init.text+0x0000000000000161
>Error: ./sound/oss/aedsp16.o .eh_frame refers to 0000000000000178 R_X86_64_64       .init.text+0x00000000000001b1
>Error: ./sound/oss/aedsp16.o .eh_frame refers to 00000000000001d0 R_X86_64_64       .init.text+0x0000000000000b66
>Error: ./sound/oss/ali5455.o .eh_frame refers to 0000000000000838 R_X86_64_64       .init.text
>Error: ./sound/oss/awe_wave.o .eh_frame refers to 0000000000001448 R_X86_64_64       .init.text
>Error: ./sound/oss/awe_wave.o .eh_frame refers to 0000000000001490 R_X86_64_64       .init.text+0x00000000000000e5
>Error: ./sound/oss/cmpci.o .eh_frame refers to 0000000000000860 R_X86_64_64       .init.text
>Error: ./sound/oss/cs4232.o .text refers to 0000000000000122 R_X86_64_PC32     .init.text+0xfffffffffffffffc
>Error: ./sound/oss/cs4232.o .eh_frame refers to 0000000000000050 R_X86_64_64       .init.text
>Error: ./sound/oss/cs4232.o .eh_frame refers to 0000000000000110 R_X86_64_64       .init.text+0x00000000000004a8
>Error: ./sound/oss/cs4232.o .eh_frame refers to 0000000000000160 R_X86_64_64       .init.text+0x00000000000005b1
>Error: ./sound/oss/cs4281/cs4281.o .eh_frame refers to 00000000000008c8 R_X86_64_64       .init.text
>Error: ./sound/oss/cs4281/cs4281m.o .eh_frame refers to 00000000000008c8 R_X86_64_64       .init.text
>Error: ./sound/oss/cs46xx.o .eh_frame refers to 0000000000000b60 R_X86_64_64       .init.text
>Error: ./sound/oss/emu10k1/main.o .eh_frame refers to 0000000000000530 R_X86_64_64       .init.text
>Error: ./sound/oss/es1370.o .eh_frame refers to 0000000000000770 R_X86_64_64       .init.text
>Error: ./sound/oss/es1370.o .eh_frame refers to 00000000000007c0 R_X86_64_64       .init.text+0x000000000000001c
>Error: ./sound/oss/es1371.o .eh_frame refers to 00000000000008f0 R_X86_64_64       .init.text
>Error: ./sound/oss/es1371.o .eh_frame refers to 0000000000000940 R_X86_64_64       .init.text+0x000000000000001c
>Error: ./sound/oss/esssolo1.o .eh_frame refers to 0000000000000748 R_X86_64_64       .init.text
>Error: ./sound/oss/forte.o .data refers to 0000000000000028 R_X86_64_64       .init.text
>Error: ./sound/oss/forte.o .eh_frame refers to 00000000000004a0 R_X86_64_64       .init.text
>Error: ./sound/oss/forte.o .eh_frame refers to 0000000000000510 R_X86_64_64       .init.text+0x0000000000000438
>Error: ./sound/oss/gus_card.o .eh_frame refers to 0000000000000088 R_X86_64_64       .init.text
>Error: ./sound/oss/gus_card.o .eh_frame refers to 00000000000000e8 R_X86_64_64       .init.text+0x00000000000002a5
>Error: ./sound/oss/gus_midi.o .eh_frame refers to 0000000000000140 R_X86_64_64       .init.text
>Error: ./sound/oss/gus_wave.o .eh_frame refers to 0000000000000310 R_X86_64_64       .init.text
>Error: ./sound/oss/gus_wave.o .eh_frame refers to 00000000000009b0 R_X86_64_64       .init.text+0x000000000000062c
>Error: ./sound/oss/i810_audio.o .eh_frame refers to 0000000000000830 R_X86_64_64       .init.text
>Error: ./sound/oss/ics2101.o .eh_frame refers to 00000000000000a0 R_X86_64_64       .init.text
>Error: ./sound/oss/kahlua.o .eh_frame refers to 00000000000000b8 R_X86_64_64       .init.text
>Error: ./sound/oss/mad16.o .text refers to 000000000000015c R_X86_64_PC32     .init.data+0x0000000000000018
>Error: ./sound/oss/mad16.o .text refers to 0000000000000182 R_X86_64_PC32     .init.data+0x0000000000000010
>Error: ./sound/oss/mad16.o .text refers to 00000000000001b6 R_X86_64_PC32     .init.data+0x000000000000000b
>Error: ./sound/oss/mad16.o .text refers to 00000000000001bf R_X86_64_PC32     .init.data+0x0000000000000008
>Error: ./sound/oss/mad16.o .text refers to 00000000000001e4 R_X86_64_PC32     .init.data+0x000000000000000b
>Error: ./sound/oss/mad16.o .text refers to 00000000000001ed R_X86_64_PC32     .init.data+0x0000000000000008
>Error: ./sound/oss/mad16.o .text refers to 0000000000000213 R_X86_64_PC32     .init.data+0x0000000000000004
>Error: ./sound/oss/mad16.o .text refers to 0000000000000219 R_X86_64_PC32     .init.data+0x0000000000000018
>Error: ./sound/oss/mad16.o .text refers to 0000000000000229 R_X86_64_PC32     .init.data+0x0000000000000007
>Error: ./sound/oss/mad16.o .text refers to 000000000000024c R_X86_64_PC32     .init.data+0x000000000000000c
>Error: ./sound/oss/mad16.o .text refers to 0000000000000262 R_X86_64_32S      .init.data+0x0000000000000080
>Error: ./sound/oss/mad16.o .text refers to 00000000000002a7 R_X86_64_PC32     .init.data+0x0000000000000014
>Error: ./sound/oss/mad16.o .text refers to 00000000000002ca R_X86_64_32S      .init.data+0x0000000000000040
>Error: ./sound/oss/mad16.o .text refers to 00000000000002e1 R_X86_64_PC32     .init.data+0x0000000000000010
>Error: ./sound/oss/mad16.o .text refers to 00000000000002fc R_X86_64_PC32     .init.data+0x000000000000000c
>Error: ./sound/oss/mad16.o .text refers to 0000000000000307 R_X86_64_32S      .init.data+0x0000000000000080
>Error: ./sound/oss/mad16.o .text refers to 0000000000000313 R_X86_64_PC32     .init.data+0x0000000000000017
>Error: ./sound/oss/mad16.o .text refers to 0000000000000322 R_X86_64_PC32     .init.data+0x0000000000000010
>Error: ./sound/oss/mad16.o .text refers to 0000000000000372 R_X86_64_PC32     .init.data+0x0000000000000014
>Error: ./sound/oss/mad16.o .text refers to 0000000000000379 R_X86_64_32S      .init.data+0x0000000000000040
>Error: ./sound/oss/mad16.o .text refers to 0000000000000393 R_X86_64_PC32     .init.data+0x0000000000000028
>Error: ./sound/oss/mad16.o .text refers to 0000000000000399 R_X86_64_PC32     .init.data+0x000000000000001c
>Error: ./sound/oss/mad16.o .text refers to 000000000000039f R_X86_64_PC32     .init.data+0x0000000000000024
>Error: ./sound/oss/mad16.o .text refers to 00000000000003a5 R_X86_64_PC32     .init.data+0x0000000000000020
>Error: ./sound/oss/mad16.o .text refers to 0000000000000502 R_X86_64_PC32     .init.text+0xfffffffffffffffc
>Error: ./sound/oss/mad16.o .text refers to 000000000000052e R_X86_64_PC32     .init.text+0xfffffffffffffffc
>Error: ./sound/oss/mad16.o .text refers to 00000000000005b2 R_X86_64_PC32     .init.text+0xfffffffffffffffc
>Error: ./sound/oss/mad16.o .text refers to 0000000000000641 R_X86_64_PC32     .init.text+0xfffffffffffffffc
>Error: ./sound/oss/mad16.o .text refers to 000000000000068b R_X86_64_PC32     .init.text+0xfffffffffffffffc
>Error: ./sound/oss/mad16.o .text refers to 00000000000006b9 R_X86_64_PC32     .init.text+0xfffffffffffffffc
>Error: ./sound/oss/mad16.o .text refers to 0000000000000c54 R_X86_64_PC32     .init.data+0x0000000000000030
>Error: ./sound/oss/mad16.o .text refers to 0000000000000c67 R_X86_64_PC32     .init.data+0x000000000000002c
>Error: ./sound/oss/mad16.o .text refers to 0000000000000e64 R_X86_64_PC32     .init.data+0x0000000000000003
>Error: ./sound/oss/mad16.o .eh_frame refers to 0000000000000070 R_X86_64_64       .init.text
>Error: ./sound/oss/mad16.o .eh_frame refers to 0000000000000168 R_X86_64_64       .init.text+0x00000000000002ee
>Error: ./sound/oss/maestro.o .data refers to 00000000000000c8 R_X86_64_64       .init.text+0x0000000000000071
>Error: ./sound/oss/maestro.o .eh_frame refers to 0000000000000260 R_X86_64_64       .init.text
>Error: ./sound/oss/maestro.o .eh_frame refers to 00000000000008a0 R_X86_64_64       .init.text+0x0000000000000071
>Error: ./sound/oss/maestro3.o .eh_frame refers to 00000000000001d0 R_X86_64_64       .init.text
>Error: ./sound/oss/maui.o .eh_frame refers to 0000000000000110 R_X86_64_64       .init.text
>Error: ./sound/oss/maui.o .eh_frame refers to 0000000000000180 R_X86_64_64       .init.text+0x00000000000005eb
>Error: ./sound/oss/mpu401.o .eh_frame refers to 0000000000000630 R_X86_64_64       .init.text
>Error: ./sound/oss/mpu401.o .eh_frame refers to 0000000000000670 R_X86_64_64       .init.text+0x0000000000000094
>Error: ./sound/oss/nm256_audio.o .eh_frame refers to 0000000000000678 R_X86_64_64       .init.text
>Error: ./sound/oss/opl3.o .eh_frame refers to 00000000000003d8 R_X86_64_64       .init.text
>Error: ./sound/oss/opl3.o .eh_frame refers to 0000000000000428 R_X86_64_64       .init.text+0x0000000000000046
>Error: ./sound/oss/opl3sa.o .eh_frame refers to 00000000000000b8 R_X86_64_64       .init.text
>Error: ./sound/oss/opl3sa.o .eh_frame refers to 0000000000000118 R_X86_64_64       .init.text+0x0000000000000355
>Error: ./sound/oss/opl3sa2.o .eh_frame refers to 00000000000001a0 R_X86_64_64       .init.text
>Error: ./sound/oss/opl3sa2.o .eh_frame refers to 0000000000000210 R_X86_64_64       .init.text+0x00000000000007f8
>Error: ./sound/oss/pas2_card.o .eh_frame refers to 00000000000000b0 R_X86_64_64       .init.text
>Error: ./sound/oss/pas2_card.o .eh_frame refers to 00000000000000f8 R_X86_64_64       .init.text+0x000000000000008d
>Error: ./sound/oss/pas2_card.o .eh_frame refers to 0000000000000138 R_X86_64_64       .init.text+0x00000000000004c0
>Error: ./sound/oss/pas2_midi.o .eh_frame refers to 0000000000000138 R_X86_64_64       .init.text
>Error: ./sound/oss/pas2_mixer.o .eh_frame refers to 00000000000000f0 R_X86_64_64       .init.text
>Error: ./sound/oss/pas2_pcm.o .eh_frame refers to 0000000000000200 R_X86_64_64       .init.text
>Error: ./sound/oss/pss.o .eh_frame refers to 0000000000000048 R_X86_64_64       .init.text
>Error: ./sound/oss/pss.o .eh_frame refers to 00000000000003d0 R_X86_64_64       .init.text+0x0000000000000124
>Error: ./sound/oss/pss.o .eh_frame refers to 0000000000000428 R_X86_64_64       .init.text+0x00000000000007a4
>Error: ./sound/oss/rme96xx.o .eh_frame refers to 00000000000001e0 R_X86_64_64       .init.text
>Error: ./sound/oss/sb.o .eh_frame refers to 00000000000000c0 R_X86_64_64       .init.text
>Error: ./sound/oss/sb_card.o .eh_frame refers to 00000000000000c0 R_X86_64_64       .init.text
>Error: ./sound/oss/sgalaxy.o .eh_frame refers to 0000000000000020 R_X86_64_64       .init.text
>Error: ./sound/oss/sgalaxy.o .eh_frame refers to 0000000000000058 R_X86_64_64       .init.text+0x0000000000000019
>Error: ./sound/oss/sgalaxy.o .eh_frame refers to 0000000000000090 R_X86_64_64       .init.text+0x00000000000002a5
>Error: ./sound/oss/sonicvibes.o .eh_frame refers to 0000000000000848 R_X86_64_64       .init.text
>Error: ./sound/oss/sonicvibes.o .eh_frame refers to 0000000000000898 R_X86_64_64       .init.text+0x000000000000001c
>Error: ./sound/oss/soundcard.o .eh_frame refers to 00000000000001d0 R_X86_64_64       .init.text
>Error: ./sound/oss/sscape.o .eh_frame refers to 0000000000000340 R_X86_64_64       .init.text
>Error: ./sound/oss/sscape.o .eh_frame refers to 00000000000003c0 R_X86_64_64       .init.text+0x0000000000001130
>Error: ./sound/oss/trident.o .eh_frame refers to 0000000000000b28 R_X86_64_64       .init.text
>Error: ./sound/oss/trix.o .eh_frame refers to 00000000000000b0 R_X86_64_64       .init.text
>Error: ./sound/oss/trix.o .eh_frame refers to 0000000000000128 R_X86_64_64       .init.text+0x0000000000000791
>Error: ./sound/oss/uart401.o .eh_frame refers to 00000000000002a0 R_X86_64_64       .init.text
>Error: ./sound/oss/uart401.o .eh_frame refers to 00000000000002e0 R_X86_64_64       .init.text+0x000000000000004c
>Error: ./sound/oss/uart6850.o .eh_frame refers to 00000000000001f0 R_X86_64_64       .init.text
>Error: ./sound/oss/uart6850.o .eh_frame refers to 0000000000000240 R_X86_64_64       .init.text+0x0000000000000160
>Error: ./sound/oss/v_midi.o .eh_frame refers to 0000000000000130 R_X86_64_64       .init.text
>Error: ./sound/oss/via82cxxx_audio.o .eh_frame refers to 0000000000000818 R_X86_64_64       .init.text
>Error: ./sound/oss/wf_midi.o .eh_frame refers to 0000000000000258 R_X86_64_64       .init.text
>Error: ./sound/oss/wf_midi.o .eh_frame refers to 0000000000000288 R_X86_64_64       .init.text+0x000000000000006f
>Error: ./sound/oss/ymfpci.o .eh_frame refers to 0000000000000748 R_X86_64_64       .init.text
>Error: ./sound/pci/ac97/ac97_codec.o .eh_frame refers to 0000000000000c38 R_X86_64_64       .init.text
>Error: ./sound/pci/ac97/ak4531_codec.o .eh_frame refers to 00000000000002b8 R_X86_64_64       .init.text
>Error: ./sound/pci/ac97/snd-ak4531-codec.o .eh_frame refers to 00000000000002b8 R_X86_64_64       .init.text
>Error: ./sound/pci/ali5451/ali5451.o .eh_frame refers to 0000000000000908 R_X86_64_64       .init.text
>Error: ./sound/pci/ali5451/snd-ali5451.o .eh_frame refers to 0000000000000908 R_X86_64_64       .init.text
>Error: ./sound/pci/als4000.o .eh_frame refers to 00000000000003a8 R_X86_64_64       .init.text
>Error: ./sound/pci/atiixp.o .eh_frame refers to 00000000000006b8 R_X86_64_64       .init.text
>Error: ./sound/pci/atiixp_modem.o .eh_frame refers to 00000000000005a8 R_X86_64_64       .init.text
>Error: ./sound/pci/au88x0/au8810.o .eh_frame refers to 0000000000000f48 R_X86_64_64       .init.text
>Error: ./sound/pci/au88x0/au8820.o .eh_frame refers to 0000000000000a18 R_X86_64_64       .init.text
>Error: ./sound/pci/au88x0/au8830.o .eh_frame refers to 0000000000001090 R_X86_64_64       .init.text
>Error: ./sound/pci/au88x0/snd-au8810.o .eh_frame refers to 0000000000000f48 R_X86_64_64       .init.text
>Error: ./sound/pci/au88x0/snd-au8820.o .eh_frame refers to 0000000000000a18 R_X86_64_64       .init.text
>Error: ./sound/pci/au88x0/snd-au8830.o .eh_frame refers to 0000000000001090 R_X86_64_64       .init.text
>Error: ./sound/pci/azt3328.o .eh_frame refers to 0000000000000468 R_X86_64_64       .init.text
>Error: ./sound/pci/bt87x.o .eh_frame refers to 0000000000000398 R_X86_64_64       .init.text
>Error: ./sound/pci/ca0106/ca0106_main.o .eh_frame refers to 0000000000000598 R_X86_64_64       .init.text
>Error: ./sound/pci/cmipci.o .eh_frame refers to 0000000000000c40 R_X86_64_64       .init.text
>Error: ./sound/pci/cs4281.o .eh_frame refers to 0000000000000690 R_X86_64_64       .init.text
>Error: ./sound/pci/cs46xx/cs46xx.o .eh_frame refers to 0000000000000080 R_X86_64_64       .init.text
>Error: ./sound/pci/emu10k1/emu10k1.o .eh_frame refers to 00000000000000a8 R_X86_64_64       .init.text
>Error: ./sound/pci/emu10k1/emu10k1_synth.o .eh_frame refers to 0000000000000088 R_X86_64_64       .init.text
>Error: ./sound/pci/emu10k1/emu10k1x.o .eh_frame refers to 0000000000000810 R_X86_64_64       .init.text
>Error: ./sound/pci/emu10k1/snd-emu10k1x.o .eh_frame refers to 0000000000000810 R_X86_64_64       .init.text
>Error: ./sound/pci/ens1370.o .eh_frame refers to 00000000000005b8 R_X86_64_64       .init.text
>Error: ./sound/pci/ens1371.o .eh_frame refers to 00000000000008c0 R_X86_64_64       .init.text
>Error: ./sound/pci/es1938.o .eh_frame refers to 0000000000000810 R_X86_64_64       .init.text
>Error: ./sound/pci/es1968.o .eh_frame refers to 00000000000008c0 R_X86_64_64       .init.text
>Error: ./sound/pci/fm801.o .eh_frame refers to 0000000000000688 R_X86_64_64       .init.text
>Error: ./sound/pci/hda/hda_codec.o .eh_frame refers to 0000000000000ba0 R_X86_64_64       .init.text
>Error: ./sound/pci/hda/hda_intel.o .eh_frame refers to 00000000000003a8 R_X86_64_64       .init.text
>Error: ./sound/pci/hda/snd-hda-intel.o .eh_frame refers to 00000000000003a8 R_X86_64_64       .init.text
>Error: ./sound/pci/ice1712/ak4xxx.o .eh_frame refers to 0000000000000158 R_X86_64_64       .init.text
>Error: ./sound/pci/ice1712/ice1712.o .eh_frame refers to 0000000000000e50 R_X86_64_64       .init.text
>Error: ./sound/pci/ice1712/ice1724.o .eh_frame refers to 0000000000000a28 R_X86_64_64       .init.text
>Error: ./sound/pci/ice1712/snd-ice17xx-ak4xxx.o .eh_frame refers to 0000000000000158 R_X86_64_64       .init.text
>Error: ./sound/pci/intel8x0.o .eh_frame refers to 00000000000007e8 R_X86_64_64       .init.text
>Error: ./sound/pci/intel8x0m.o .eh_frame refers to 00000000000004b8 R_X86_64_64       .init.text
>Error: ./sound/pci/korg1212/korg1212.o .eh_frame refers to 0000000000000880 R_X86_64_64       .init.text
>Error: ./sound/pci/korg1212/snd-korg1212.o .eh_frame refers to 0000000000000880 R_X86_64_64       .init.text
>Error: ./sound/pci/maestro3.o .eh_frame refers to 0000000000000600 R_X86_64_64       .init.text
>Error: ./sound/pci/mixart/mixart.o .eh_frame refers to 00000000000004a8 R_X86_64_64       .init.text
>Error: ./sound/pci/nm256/nm256.o .eh_frame refers to 0000000000000558 R_X86_64_64       .init.text
>Error: ./sound/pci/nm256/snd-nm256.o .eh_frame refers to 0000000000000558 R_X86_64_64       .init.text
>Error: ./sound/pci/rme32.o .eh_frame refers to 00000000000008d8 R_X86_64_64       .init.text
>Error: ./sound/pci/rme96.o .eh_frame refers to 00000000000009b8 R_X86_64_64       .init.text
>Error: ./sound/pci/rme9652/hdsp.o .eh_frame refers to 0000000000001690 R_X86_64_64       .init.text
>Error: ./sound/pci/rme9652/hdspm.o .eh_frame refers to 0000000000000d28 R_X86_64_64       .init.text
>Error: ./sound/pci/rme9652/rme9652.o .eh_frame refers to 0000000000000b58 R_X86_64_64       .init.text
>Error: ./sound/pci/rme9652/snd-hdsp.o .eh_frame refers to 0000000000001690 R_X86_64_64       .init.text
>Error: ./sound/pci/rme9652/snd-hdspm.o .eh_frame refers to 0000000000000d28 R_X86_64_64       .init.text
>Error: ./sound/pci/rme9652/snd-rme9652.o .eh_frame refers to 0000000000000b58 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-als4000.o .eh_frame refers to 00000000000003a8 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-atiixp-modem.o .eh_frame refers to 00000000000005a8 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-atiixp.o .eh_frame refers to 00000000000006b8 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-azt3328.o .eh_frame refers to 0000000000000468 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-bt87x.o .eh_frame refers to 0000000000000398 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-cmipci.o .eh_frame refers to 0000000000000c40 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-cs4281.o .eh_frame refers to 0000000000000690 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-ens1370.o .eh_frame refers to 00000000000005b8 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-ens1371.o .eh_frame refers to 00000000000008c0 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-es1938.o .eh_frame refers to 0000000000000810 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-es1968.o .eh_frame refers to 00000000000008c0 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-fm801.o .eh_frame refers to 0000000000000688 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-intel8x0.o .eh_frame refers to 00000000000007e8 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-intel8x0m.o .eh_frame refers to 00000000000004b8 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-maestro3.o .eh_frame refers to 0000000000000600 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-rme32.o .eh_frame refers to 00000000000008d8 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-rme96.o .eh_frame refers to 00000000000009b8 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-sonicvibes.o .eh_frame refers to 0000000000000690 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-via82xx-modem.o .eh_frame refers to 0000000000000458 R_X86_64_64       .init.text
>Error: ./sound/pci/snd-via82xx.o .eh_frame refers to 00000000000007a8 R_X86_64_64       .init.text
>Error: ./sound/pci/sonicvibes.o .eh_frame refers to 0000000000000690 R_X86_64_64       .init.text
>Error: ./sound/pci/trident/snd-trident-synth.o .eh_frame refers to 00000000000004f8 R_X86_64_64       .init.text
>Error: ./sound/pci/trident/trident.o .eh_frame refers to 0000000000000090 R_X86_64_64       .init.text
>Error: ./sound/pci/trident/trident_synth.o .eh_frame refers to 00000000000004f8 R_X86_64_64       .init.text
>Error: ./sound/pci/via82xx.o .eh_frame refers to 00000000000007a8 R_X86_64_64       .init.text
>Error: ./sound/pci/via82xx_modem.o .eh_frame refers to 0000000000000458 R_X86_64_64       .init.text
>Error: ./sound/pci/vx222/vx222.o .eh_frame refers to 00000000000000c8 R_X86_64_64       .init.text
>Error: ./sound/pci/ymfpci/ymfpci.o .eh_frame refers to 00000000000000c0 R_X86_64_64       .init.text
>Error: ./sound/sound_core.o .eh_frame refers to 00000000000002a8 R_X86_64_64       .init.text
>Error: ./sound/synth/emux/emux.o .eh_frame refers to 00000000000000a8 R_X86_64_64       .init.text
>Error: ./sound/synth/snd-util-mem.o .eh_frame refers to 0000000000000158 R_X86_64_64       .init.text
>Error: ./sound/synth/util_mem.o .eh_frame refers to 0000000000000158 R_X86_64_64       .init.text
>Error: ./sound/usb/usbaudio.o .eh_frame refers to 0000000000000c98 R_X86_64_64       .init.text
>Error: ./sound/usb/usx2y/usbusx2y.o .eh_frame refers to 0000000000000180 R_X86_64_64       .init.text
>  
>
Changing every occurence of __init to __devinit is very bad idea, kernel 
won't free these functions after loading the driver, if hotplug is 
defined. For example, I don't know, why did you move module_init() 
functions to __devinit section. It is needed only once. __devinit is 
used, where the functions are needed on the fly to initialize device (if 
hotplug is defined, all over the run of the kernel, otherwise only at 
module loading time).
Next, do not alter changelogs.
Maybe rewriting of oss drivers is wasting of time.

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

