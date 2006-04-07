Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWDGC5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWDGC5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 22:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWDGC5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 22:57:40 -0400
Received: from stark.xeocode.com ([216.58.44.227]:58050 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S932299AbWDGC5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 22:57:39 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: pchdtv 3000 cx88 audio very very low level
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Date: 06 Apr 2006 22:57:34 -0400
Message-ID: <8764lmnlcx.fsf@stark.xeocode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this video4linux list still active? I see very little traffic on it. Is
there a better place for questions about v4l drivers for the pchdtv 3000 cx88
NTSC tuner?

I have it working fine but the audio is extremely low level. Even if I boost
the line-in level and the master output level to max on my sound card it's
barely audible over the background static.

Is there something wrong with my card? Or with my drivers?

bash-3.1$ lsmod | grep cx
cx88_alsa              13408  0 
cx8800                 32268  1 
compat_ioctl32          1792  1 cx8800
cx88xx                 63524  2 cx88_alsa,cx8800
i2c_algo_bit            9480  1 cx88xx
video_buf              21764  3 cx88_alsa,cx8800,cx88xx
ir_common               9988  1 cx88xx
btcx_risc               5384  3 cx88_alsa,cx8800,cx88xx
v4l2_common             8064  3 cx8800,msp3400,tuner
v4l1_compat            13956  2 cx8800,ivtv
tveeprom               14992  2 cx88xx,ivtv
videodev               10368  6 cx8800,cx88xx,ivtv
snd_pcm                84484  4 cx88_alsa,snd_pcm_oss,snd_intel8x0,snd_ac97_codec
i2c_core               22400  13 cx88xx,i2c_algo_bit,msp3400,saa7127,saa7115,tda9887,tuner,ivtv,tveeprom,w83627hf,eeprom,i2c_isa,i2c_i801
snd                    52576  11 cx88_alsa,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device


[ 5020.495242] cx2388x v4l2 driver version 0.0.5 loaded
[ 5020.499005] ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 22
[ 5020.499140] CORE cx88[0]: subsystem: 7063:3000, board: pcHDTV HD3000 HDTV [card=22,autodetected]
[ 5020.499194] TV tuner 52 at 0x1fe, Radio tuner -1 at 0x1fe
[ 5020.676748] tuner 2-0061: chip found @ 0xc2 (cx88[0])
[ 5020.679548] tuner 2-0061: type set to 52 (Thomson DTT 7610 (ATSC/NTSC))
[ 5020.720003] tda9887 2-0043: chip found @ 0x86 (cx88[0])
[ 5020.846947] cx88[0]/0: found at 0000:02:0d.0, rev: 5, irq: 22, latency: 64, mmio: 0xf2000000
[ 5020.854107] cx88[0]/0: registered device video1 [v4l2]
[ 5020.863507] cx88[0]/0: registered device vbi1
[ 5020.868332] cx88[0]/0: registered device radio1
[ 5020.873685] set_control id=0x980900 reg=0x310110 val=0x00 (mask 0xff)
[ 5020.873777] set_control id=0x980901 reg=0x310110 val=0x3f00 (mask 0xff00)
[ 5020.873822] set_control id=0x980903 reg=0x310118 val=0x00 (mask 0xff)
[ 5020.873856] set_control id=0x980902 reg=0x310114 val=0x5a7f (mask 0xffff)
[ 5020.873891] set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
[ 5020.873933] set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
[ 5020.874000] set_control id=0x980906 reg=0x320598 val=0x40 (mask 0x7f) [shadowed]
[ 5046.024833] get_control id=0x980900 reg=0x310110 val=0x80 (mask 0xff)
[ 5046.024860] get_control id=0x980901 reg=0x310110 val=0x3f (mask 0xff00)
[ 5046.024873] get_control id=0x980902 reg=0x310114 val=0x7f (mask 0xff)
[ 5046.024885] get_control id=0x980903 reg=0x310118 val=0x80 (mask 0xff)
[ 5046.024897] get_control id=0x980906 reg=0x320598 val=0x00 (mask 0x7f) [shadowed]
[ 5046.024911] set_control id=0x980909 reg=0x320594 val=0x00 (mask 0x40) [shadowed]
[ 5046.024920] get_control id=0x980905 reg=0x320594 val=0x1f (mask 0x3f) [shadowed]
[ 5046.024929] get_control id=0x980909 reg=0x320594 val=0x00 (mask 0x40) [shadowed]
[ 5046.124609] set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
[ 5046.124619] set_control id=0x980902 reg=0x310114 val=0x577c (mask 0xffff)
[ 5046.124638] set_control id=0x980900 reg=0x310110 val=0xff (mask 0xff)
[ 5046.124652] set_control id=0x980903 reg=0x310118 val=0x00 (mask 0xff)
[ 5046.124665] set_control id=0x980901 reg=0x310110 val=0x3800 (mask 0xff00)
[ 5046.166913] set_control id=0x980909 reg=0x320594 val=0x00 (mask 0x40) [shadowed]
[ 5200.569119] set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
[ 5200.569129] set_control id=0x980902 reg=0x310114 val=0x577c (mask 0xffff)
[ 5200.569147] set_control id=0x980900 reg=0x310110 val=0xff (mask 0xff)
[ 5200.569161] set_control id=0x980903 reg=0x310118 val=0x00 (mask 0xff)
[ 5200.569174] set_control id=0x980901 reg=0x310110 val=0x3800 (mask 0xff00)
[ 5200.613786] set_control id=0x980909 reg=0x320594 val=0x00 (mask 0x40) [shadowed]
[ 5389.899723] set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
[ 5389.899733] set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
[ 5390.931524] set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
[ 5390.931534] set_control id=0x980909 reg=0x320594 val=0x00 (mask 0x40) [shadowed]
[ 6560.963631] set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
[ 6560.963641] set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
[ 6563.560136] set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
[ 6563.560147] set_control id=0x980909 reg=0x320594 val=0x00 (mask 0x40) [shadowed]
[ 6564.125801] set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
[ 6564.125811] set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
[ 6750.293689] set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
[ 6750.293699] set_control id=0x980909 reg=0x320594 val=0x00 (mask 0x40) [shadowed]
[ 6824.893884] cx2388x alsa driver version 0.0.5 loaded



-- 
greg

