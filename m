Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992909AbWJUKAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992909AbWJUKAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 06:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992910AbWJUKAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 06:00:16 -0400
Received: from main.gmane.org ([80.91.229.2]:64964 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S2992909AbWJUKAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 06:00:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: ALSA CA0106 regression: no sound with SB Audigy LS and kernel 2.6.18
Followup-To: gmane.linux.alsa.user
Date: Sat, 21 Oct 2006 12:01:40 +0200
Message-ID: <ehcqs0$cip$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.117.84.42
User-Agent: KNode/0.10.4
Cc: alsa-user@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With all previous kernels I used (up to 2.6.17.11) this card worked fine.
With 2.6.18 it stops working, it's still correctly recognized but doesn't
output any sound, no matter what mixer settings I choose. BTW, the mixer
settings / available channels differ significantly between these two kernel
revisions.

Is this aknown problem? I could not find anything on the ALSA or kernel
mailing lists.

I guess, one of the CA0106 changes introduced in in
ftp://ftp.de.kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.18-rc1
might have caused this regression.

That's what /proc/asound/card1/ contains in 2.6.17.11 (working) and 2.6.18.1
(non-working).

*****************************************************************************
*****************************************************************************
** Kernel 2.6.17.11
*****************************************************************************
*****************************************************************************

CA0106_2.6.17.11/ca0106_i2c:

CA0106_2.6.17.11/ca0106_reg16:
Registers:

Register 00: 0000
Register 02: 0076
Register 04: 0000
Register 06: 0000
Register 08: 0000
Register 0A: 0000
Register 0C: 0105
Register 0E: 0000
Register 10: 0000
Register 12: 0000
Register 14: 0009
Register 16: 0000
Register 18: 53F3
Register 1A: 0000
Register 1C: 0000
Register 1E: 0000

CA0106_2.6.17.11/ca0106_reg32:
Registers:

Register 00: 00760000
Register 04: 00000000
Register 08: 00000000
Register 0C: 00000105
Register 10: 00000000
Register 14: 00000009
Register 18: 005F53F3
Register 1C: 00000000

CA0106_2.6.17.11/ca0106_reg8:
Registers:

Register 00: 00
Register 01: 00
Register 02: 76
Register 03: 00
Register 04: 00
Register 05: 00
Register 06: 00
Register 07: 00
Register 08: 00
Register 09: 00
Register 0A: 00
Register 0B: 00
Register 0C: 05
Register 0D: 01
Register 0E: 00
Register 0F: 00
Register 10: 00
Register 11: 00
Register 12: 00
Register 13: 00
Register 14: 09
Register 15: 00
Register 16: 00
Register 17: 00
Register 18: F3
Register 19: 53
Register 1A: 00
Register 1B: 00
Register 1C: 00
Register 1D: 00
Register 1E: 00
Register 1F: 00

CA0106_2.6.17.11/ca0106_regs1:
Registers
00: 7FF8D000 00000000 00000000 00000000
01: 00380000 00000000 00000000 00000000
02: 00000020 00000000 00000000 00000000
03: 00000000 00000000 00000000 00000000
04: 0C668000 00000000 00000000 00000000
05: 20000000 00000000 00000000 00000000
06: 00000CE0 00000000 00000000 00000000
07: 00000000 00000000 00000000 00000000
08: 003E003A 00000000 00000000 00000000
09: 00000000 00000000 00000000 00000000
0A: 00000000 00000000 00000000 00000000
0B: 00000000 00000000 00000000 00000000
0C: 00000000 00000000 00000000 00000000
0D: 00000000 00000000 00000000 00000000
0E: 00000000 00000000 00000000 00000000
0F: 00000000 00000000 00000000 00000000
10: 00000000 00000000 00000000 00000000
11: 00000000 00000000 00000000 00000000
12: 00000000 00000000 00000000 00000000
13: 00000000 00000000 00000000 00000000
14: 00000000 00000000 00000000 00000000
15: 00000000 00000000 00000000 00000000
16: 00000000 00000000 00000000 00000000
17: 00000000 00000000 00000000 00000000
18: 00000000 00000000 00000000 00000000
19: 00000000 00000000 00000000 00000000
1A: 00000000 00000000 00000000 00000000
1B: 00000000 00000000 00000000 00000000
1C: 00000000 00000000 00000000 00000000
1D: 00000000 00000000 00000000 00000000
1E: 00000000 00000000 00000000 00000000
1F: 00000000 00000000 00000000 00000000
20: 0002F600 0002F600 0002AE00 0002AE00
21: 00000000 00000000 00000000 00000000
22: 00000000 00000000 00000000 00000000
23: 00000000 00000000 00000000 00000000
24: 00000000 00000000 00000000 00000000
25: 00000000 00000000 00000000 00000000
26: 00000000 00000000 00000000 00000000
27: 00000000 00000000 00000000 00000000
28: 00000000 00000000 00000000 00000000
29: 00000000 00000000 00000000 00000000
2A: 00000000 00000000 00000000 00000000
2B: 00000000 00000000 00000000 00000000
2C: 00000000 00000000 00000000 00000000
2D: 00000000 00000000 00000000 00000000
2E: 00000000 00000000 00000000 00000000
2F: 00000000 00000000 00000000 00000000
30: 00000000 00000000 00000000 00000000
31: 00000000 00000000 00000000 00000000
32: 00000000 00000000 00000000 00000000
33: 00000000 00000000 00000000 00000000
34: 00000000 00000000 00000000 00000000
35: 00000000 00000000 00000000 00000000
36: 00000000 00000000 00000000 00000000
37: 00000000 00000000 00000000 00000000
38: 00000000 00000000 00000000 00000000
39: 00000000 00000000 00000000 00000000
3A: 00000000 00000000 00000000 00000000
3B: 00000000 00000000 00000000 00000000
3C: 00000000 00000000 00000000 00000000
3D: 00000000 00000000 00000000 00000000
3E: 00000000 00000000 00000000 00000000
3F: 00000000 00000000 00000000 00000000

CA0106_2.6.17.11/ca0106_regs2:
Registers
40: 00000001 00000001 00000001 00000001
41: 02109204 00000000 00000000 00400000
42: 02109204 00000000 00400000 00400000
43: 02109204 00000000 00400000 00400000
44: 02109204 00000000 00440000 00440000
45: 0000000F 00000000 00000000 00440001
46: 00000000 00000000 00000000 00000000
47: 05440000 05440000 00440000 00440000
48: 05400000 05400000 00480000 00400000
49: FFFFFFFF FFFFFFFF 00000000 00400001
4A: 05400000 05480000 00480000 00480000
4B: 05400000 05400001 00400000 00400000
4C: 05400000 05440001 00440000 00440000
4D: 05440000 05440000 00440000 00440000
4E: 05440000 05440000 00440000 00440000
4F: 05440000 05440000 00400000 00440000
50: 00000000 00000000 00000000 00000000
51: 00000000 00000000 00000000 00000000
52: 00000000 00000000 00000000 00000000
53: 00000000 00000000 00000000 00000000
54: 00000000 00000000 00000000 00000000
55: 00000000 00000000 00000000 00000000
56: 00000000 00000000 00000000 00000000
57: 00000000 00000000 00000000 00000000
58: 00000000 00000000 00000000 00000000
59: 00000000 00000000 00000000 00000000
5A: 00000000 00000000 00000000 00000000
5B: 00000000 00000000 00000000 00000000
5C: 00000000 00000000 00000000 00000000
5D: 00000000 00000000 00000000 00000000
5E: 00000000 00000000 00000000 00000000
5F: 00000000 00000000 00000000 00000000
60: 444400E4 444400E4 444400E4 444400E4
61: 30303030 30303030 30303030 30303030
62: 30303030 30303030 30303030 30303030
63: 32765410 32765410 32765410 32765410
64: 76767676 76767676 76767676 76767676
65: 00000000 00000000 00000000 00000000
66: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
67: 32765410 32765410 32765410 32765410
68: 76767676 76767676 76767676 76767676
69: 00FC0000 00FC0000 00FC0000 00FC0000
6A: 88888888 FFFFFFFF FFFFFFFF FFFFFFFF
6B: 00400000 00400001 00400000 00480000
6C: 00000000 00000000 00000000 00000000
6D: 00000080 00000080 00000080 00000080
6E: 00000000 00000000 00000000 00000000
6F: 00000080 00000080 00000080 00000080
70: 00000000 00108000 00500000 00500000
71: 40C81000 FFFFFFFF 30300000 00700000
72: 000F0000 000F0000 000F0000 000F0000
73: 00000000 00000000 00000000 00000000
74: 00000071 00000071 00000071 00000071
75: 00000010 00000010 00000010 00000010
76: 00000000 00000000 00000000 00000000
77: 000092A1 000092A1 000092A1 000092A2
78: 00123FC5 00123FC5 00123FC5 00123FC5
79: 00000000 00000000 00000000 00000000
7A: 00000000 00000000 00400000 00400000
7B: 00000434 00000434 00000434 00000434
7C: 00000000 00000000 00440000 00440000
7D: 2A040000 2A040000 2A040000 2A040000
7E: 00000000 00000000 00000000 00000000
7F: 00000000 00000000 00000000 00000000

CA0106_2.6.17.11/id:
CA0106

CA0106_2.6.17.11/iec958:
Status: Not Rate Locked, No SPDIF Lock, No valid audio
Estimated sample rate: 0


CA0106_2.6.17.11/midi0:
CA0106 MPU-401 (UART)

Output 0
  Tx bytes     : 0
Input 0
  Rx bytes     : 0

CA0106_2.6.17.11/oss_mixer:
VOLUME "" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "" 0
SPEAKER "" 0
LINE "" 0
MIC "" 0
CD "" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "" 0
OGAIN "" 0
LINE1 "" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "" 0
PHONEOUT "" 0
VIDEO "" 0
RADIO "" 0
MONITOR "" 0

CA0106_2.6.17.11/pcm0c/oss:

CA0106_2.6.17.11/pcm0c/sub0/prealloc:
64

CA0106_2.6.17.11/pcm0c/sub0/status:
closed

CA0106_2.6.17.11/pcm0c/sub0/sw_params:
closed

CA0106_2.6.17.11/pcm0c/sub0/hw_params:
closed

CA0106_2.6.17.11/pcm0c/sub0/info:
card: 1
device: 0
subdevice: 0
stream: CAPTURE
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm0c/info:
card: 1
device: 0
subdevice: 0
stream: CAPTURE
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm0p/oss:

CA0106_2.6.17.11/pcm0p/sub0/prealloc:
64

CA0106_2.6.17.11/pcm0p/sub0/status:
state: RUNNING
trigger_time: 1161423508.145139000
tstamp      : 1161423680.993168000
delay       : -8300168
avail       : 8316552
avail_max   : 8316552
-----
hw_ptr      : 8300168
appl_ptr    : 0

CA0106_2.6.17.11/pcm0p/sub0/sw_params:
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 2048
xfer_align: 2048
start_threshold: 1
stop_threshold: 4611686018427387904
silence_threshold: 0
silence_size: 4611686018427387904
boundary: 4611686018427387904

CA0106_2.6.17.11/pcm0p/sub0/hw_params:
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 2048
buffer_size: 16384
tick_time: 4000

CA0106_2.6.17.11/pcm0p/sub0/info:
card: 1
device: 0
subdevice: 0
stream: PLAYBACK
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0

CA0106_2.6.17.11/pcm0p/info:
card: 1
device: 0
subdevice: 0
stream: PLAYBACK
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0

CA0106_2.6.17.11/pcm1c/oss:

CA0106_2.6.17.11/pcm1c/sub0/prealloc:
64

CA0106_2.6.17.11/pcm1c/sub0/status:
closed

CA0106_2.6.17.11/pcm1c/sub0/sw_params:
closed

CA0106_2.6.17.11/pcm1c/sub0/hw_params:
closed

CA0106_2.6.17.11/pcm1c/sub0/info:
card: 1
device: 1
subdevice: 0
stream: CAPTURE
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm1c/info:
card: 1
device: 1
subdevice: 0
stream: CAPTURE
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm1p/oss:

CA0106_2.6.17.11/pcm1p/sub0/prealloc:
64

CA0106_2.6.17.11/pcm1p/sub0/status:
closed

CA0106_2.6.17.11/pcm1p/sub0/sw_params:
closed

CA0106_2.6.17.11/pcm1p/sub0/hw_params:
closed

CA0106_2.6.17.11/pcm1p/sub0/info:
card: 1
device: 1
subdevice: 0
stream: PLAYBACK
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm1p/info:
card: 1
device: 1
subdevice: 0
stream: PLAYBACK
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm2c/sub0/prealloc:
64

CA0106_2.6.17.11/pcm2c/sub0/status:
closed

CA0106_2.6.17.11/pcm2c/sub0/sw_params:
closed

CA0106_2.6.17.11/pcm2c/sub0/hw_params:
closed

CA0106_2.6.17.11/pcm2c/sub0/info:
card: 1
device: 2
subdevice: 0
stream: CAPTURE
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm2c/info:
card: 1
device: 2
subdevice: 0
stream: CAPTURE
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm2p/sub0/prealloc:
64

CA0106_2.6.17.11/pcm2p/sub0/status:
closed

CA0106_2.6.17.11/pcm2p/sub0/sw_params:
closed

CA0106_2.6.17.11/pcm2p/sub0/hw_params:
closed

CA0106_2.6.17.11/pcm2p/sub0/info:
card: 1
device: 2
subdevice: 0
stream: PLAYBACK
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm2p/info:
card: 1
device: 2
subdevice: 0
stream: PLAYBACK
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm3c/sub0/prealloc:
64

CA0106_2.6.17.11/pcm3c/sub0/status:
closed

CA0106_2.6.17.11/pcm3c/sub0/sw_params:
closed

CA0106_2.6.17.11/pcm3c/sub0/hw_params:
closed

CA0106_2.6.17.11/pcm3c/sub0/info:
card: 1
device: 3
subdevice: 0
stream: CAPTURE
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm3c/info:
card: 1
device: 3
subdevice: 0
stream: CAPTURE
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm3p/sub0/prealloc:
64

CA0106_2.6.17.11/pcm3p/sub0/status:
closed

CA0106_2.6.17.11/pcm3p/sub0/sw_params:
closed

CA0106_2.6.17.11/pcm3p/sub0/hw_params:
closed

CA0106_2.6.17.11/pcm3p/sub0/info:
card: 1
device: 3
subdevice: 0
stream: PLAYBACK
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.17.11/pcm3p/info:
card: 1
device: 3
subdevice: 0
stream: PLAYBACK
id: ca0106
name: CA0106
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1



*****************************************************************************
*****************************************************************************
** Kernel 2.6.18.1
*****************************************************************************
*****************************************************************************

CA0106_2.6.18.1/codec97#0/ac97#0-0+regs:
0:00 = 0000
0:02 = 1f1f
0:04 = 0000
0:06 = 0017
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 0000
0:16 = 1f1f
0:18 = 9717
0:1a = 0000
0:1c = 8000
0:1e = 0000
0:20 = 0400
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 09c6
0:2a = 05c4
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 9f9f
0:38 = 9f9f
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0a0a
0:6a = 8801
0:6c = 0000
0:6e = 0017
0:70 = c5a0
0:72 = 00c0
0:74 = 8388
0:76 = 8a90
0:78 = 108e
0:7a = 20d2
0:7c = 414c
0:7e = 4790

CA0106_2.6.18.1/codec97#0/ac97#0-0:
0-0/0: Realtek ALC850 rev 0

PCI Subsys Vendor: 0x1043
PCI Subsys Device: 0x812a

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 7/8
Extended ID      : codec=0 rev=2 LDAC SDAC CDAC DSA=0 SPDIF DRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

CA0106_2.6.18.1/id:
CK804

CA0106_2.6.18.1/intel8x0:
Intel8x0

Global control        : 0x00000002
Global status         : 0x00700100
AC'97 codecs ready    : primary

CA0106_2.6.18.1/oss_mixer:
VOLUME "Master" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "PCM" 0
SPEAKER "PC Speaker" 0
LINE "Line" 0
MIC "Mic" 0
CD "CD" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "Capture" 0
OGAIN "" 0
LINE1 "Aux" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "Phone" 0
PHONEOUT "Master Mono" 0
VIDEO "Video" 0
RADIO "" 0
MONITOR "" 0

CA0106_2.6.18.1/pcm0c/oss:

CA0106_2.6.18.1/pcm0c/sub0/prealloc:
64

CA0106_2.6.18.1/pcm0c/sub0/status:
closed

CA0106_2.6.18.1/pcm0c/sub0/sw_params:
closed

CA0106_2.6.18.1/pcm0c/sub0/hw_params:
closed

CA0106_2.6.18.1/pcm0c/sub0/info:
card: 1
device: 0
subdevice: 0
stream: CAPTURE
id: Intel ICH
name: NVidia CK804
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.18.1/pcm0c/info:
card: 1
device: 0
subdevice: 0
stream: CAPTURE
id: Intel ICH
name: NVidia CK804
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.18.1/pcm0p/oss:

CA0106_2.6.18.1/pcm0p/sub0/prealloc:
64

CA0106_2.6.18.1/pcm0p/sub0/status:
closed

CA0106_2.6.18.1/pcm0p/sub0/sw_params:
closed

CA0106_2.6.18.1/pcm0p/sub0/hw_params:
closed

CA0106_2.6.18.1/pcm0p/sub0/info:
card: 1
device: 0
subdevice: 0
stream: PLAYBACK
id: Intel ICH
name: NVidia CK804
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.18.1/pcm0p/info:
card: 1
device: 0
subdevice: 0
stream: PLAYBACK
id: Intel ICH
name: NVidia CK804
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.18.1/pcm1c/oss:

CA0106_2.6.18.1/pcm1c/sub0/prealloc:
0

CA0106_2.6.18.1/pcm1c/sub0/status:
closed

CA0106_2.6.18.1/pcm1c/sub0/sw_params:
closed

CA0106_2.6.18.1/pcm1c/sub0/hw_params:
closed

CA0106_2.6.18.1/pcm1c/sub0/info:
card: 1
device: 1
subdevice: 0
stream: CAPTURE
id: Intel ICH - MIC ADC
name: NVidia CK804 - MIC ADC
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.18.1/pcm1c/info:
card: 1
device: 1
subdevice: 0
stream: CAPTURE
id: Intel ICH - MIC ADC
name: NVidia CK804 - MIC ADC
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.18.1/pcm2p/sub0/prealloc:
64

CA0106_2.6.18.1/pcm2p/sub0/status:
closed

CA0106_2.6.18.1/pcm2p/sub0/sw_params:
closed

CA0106_2.6.18.1/pcm2p/sub0/hw_params:
closed

CA0106_2.6.18.1/pcm2p/sub0/info:
card: 1
device: 2
subdevice: 0
stream: PLAYBACK
id: Intel ICH - IEC958
name: NVidia CK804 - IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

CA0106_2.6.18.1/pcm2p/info:
card: 1
device: 2
subdevice: 0
stream: PLAYBACK
id: Intel ICH - IEC958
name: NVidia CK804 - IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1



Greetings,

  Gunter

-- 
"Bonsai!"
        -- (Terry Pratchett, Reaper Man)
*** PGP-Verschlüsselung bei eMails erwünscht :-) *** PGP: 0x1128F25F ***

