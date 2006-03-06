Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWCFPe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWCFPe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWCFPe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:34:28 -0500
Received: from cernmx07.cern.ch ([137.138.166.171]:56685 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1750707AbWCFPe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:34:27 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=dS/h2qRKOIRKIREgRaJt9Biez6rO8sX0o/yxyNefN1dzjklZlx2On/iMBkDrLYzXHN3Pvm/RcVaxn5Qmshpw2+AhE9JHons4r1Q1rOMzFnLN0NieNyt7vg2q5pbz9/Op;
Message-ID: <440C5672.7000009@cern.ch>
Date: Mon, 06 Mar 2006 16:34:10 +0100
From: Jiri Tyr <jiri.tyr@cern.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060128)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mchehab@brturbo.com.br, video4linux-list@redhat.com
Subject: PROBLEM: four bttv tuners in one PC crashed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2006 15:34:00.0909 (UTC) FILETIME=[645557D0:01C64133]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I will follow the 
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html to 
describe the bug:

### [1.] One line summary of the problem:
Four PCI TV tuners based on bt878 chip in one PC crashed.

### [2.] Full description of the problem/report:
I'm runnig four XAWTVs on one screen. Screen is splited by XAWTV to two 
columns and two rows [6.]. If I'm clicking randomly everywhere on all 
XAWTVs with right and left mouse button, the picture (PC) freeze. 
Sometimes it frozen hard (doesn't works Alt+SysRq), sometimes soft (does 
works Alt-SysRq).

### [3.] Keywords (i.e., modules, networking, kernel):
kernel, modules

### [4.] Kernel version (from /proc/version):
Linux version 2.6.16-rc5 (root@livecd) (gcc version 3.4.4 (Gentoo 
3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #2 Mon Mar 6 15:59:18 CET 2006

### [5.] Output of Oops.. message (if applicable) with symbolic 
information resolved:
Mar  6 16:03:11 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv2: OCERR @ 1ef89014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv2: OCERR @ 1ef89014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv2: OCERR @ 1ef89000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv2: OCERR @ 1ef89000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:11 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:12 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:12 watch4tv bttv2: OCERR @ 1ef89000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:12 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:12 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:12 watch4tv bttv2: OCERR @ 1ef89014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:12 watch4tv bttv3: timeout: drop=0 irq=228/1180, 
risc=18ad4fdc, bits: HSYNC OFLOW
Mar  6 16:03:12 watch4tv bttv3: reset, reinitialize
Mar  6 16:03:12 watch4tv bttv3: PLL: 28636363 => 35468950 . ok
Mar  6 16:03:12 watch4tv bttv2: timeout: drop=0 irq=292/292, 
risc=18b9d860, bits: HSYNC OFLOW
Mar  6 16:03:12 watch4tv bttv2: reset, reinitialize
Mar  6 16:03:12 watch4tv bttv2: PLL: 28636363 => 35468950 . ok
Mar  6 16:03:12 watch4tv bttv3: OCERR @ 1efbf01c,bits: VSYNC HSYNC OFLOW 
OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf014,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf014,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf014,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf000,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf014,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf014,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf014,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf000,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf000,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf014,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf014,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: OCERR @ 1efbf014,bits: VSYNC HSYNC OFLOW 
FDSR OCERR*
Mar  6 16:03:13 watch4tv bttv3: timeout: drop=0 irq=244/1207, 
risc=18ba701c, bits: VSYNC HSYNC OFLOW
Mar  6 16:03:13 watch4tv bttv3: reset, reinitialize
Mar  6 16:03:13 watch4tv bttv3: PLL: 28636363 => 35468950 . ok
Mar  6 16:03:23 watch4tv Unable to handle kernel paging request at 
virtual address 200001d4
Mar  6 16:03:23 watch4tv printing eip:
Mar  6 16:03:23 watch4tv c0156ac7
Mar  6 16:03:23 watch4tv *pde = 00000000
Mar  6 16:03:23 watch4tv Oops: 0000 [#1]
Mar  6 16:03:23 watch4tv Modules linked in: i915 drm ohci_hcd tuner 
tvaudio bttv video_buf compat_ioctl32 i2c_algo_bit v4l2_common btcx_risc 
ir_common tveeprom i2c_core videodev ehci_hcd usb_storage uhci_hcd 
snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq 
snd_seq_device snd_bt87x snd_hda_intel snd_hda_codec snd_pcm snd_timer 
snd soundcore snd_page_alloc usbcore
Mar  6 16:03:23 watch4tv CPU:    0
Mar  6 16:03:23 watch4tv EIP:    0060:[<c0156ac7>]    Not tainted VLI
Mar  6 16:03:23 watch4tv EFLAGS: 00013212   (2.6.16-rc5 #2)
Mar  6 16:03:23 watch4tv EIP is at poll_freewait+0x16/0x3c
Mar  6 16:03:23 watch4tv eax: de25fefc   ebx: 200001bc   ecx: ffffffff   
edx: 200001c0
Mar  6 16:03:23 watch4tv esi: da061000   edi: 00008000   ebp: 00000000   
esp: de25fea8
Mar  6 16:03:23 watch4tv ds: 007b   es: 007b   ss: 0068
Mar  6 16:03:23 watch4tv Process X (pid: 8946, threadinfo=de25e000 
task=dea45070)
Mar  6 16:03:23 watch4tv Stack: <0>de25ff98 00000000 c0156f1c de25fefc 
00000000 00000000 0000783a 00000000
Mar  6 16:03:23 watch4tv 00000000 00000000 0000000f 0000783a de53c104 
de53c0e4 de53c0c4 de53c164
Mar  6 16:03:23 watch4tv de53c144 de53c124 0000000f 00000000 0000000f 
c0156aed da061000 00000000
Mar  6 16:03:23 watch4tv Call Trace:
Mar  6 16:03:23 watch4tv [<c0156f1c>] do_select+0x2cc/0x2d7
Mar  6 16:03:23 watch4tv [<c0156aed>] __pollwait+0x0/0x9a
Mar  6 16:03:23 watch4tv [<c0157141>] core_sys_select+0x202/0x2b7
Mar  6 16:03:23 watch4tv [<c0157293>] sys_select+0x9d/0x161
Mar  6 16:03:23 watch4tv [<c0149137>] sys_writev+0x3b/0x96
Mar  6 16:03:23 watch4tv [<c010292b>] sysenter_past_esp+0x54/0x75
Mar  6 16:03:23 watch4tv Code: c7 00 ed 6a 15 c0 c7 40 08 00 00 00 00 c7 
40 04 00 00 00 00 c3 56 53 8b 44 24 0c 8b 70 04 85 f6 74 2c 8b 5e 04 83 
eb 1c 8d 53 04 <8b> 43 18 e8 24 e7 fc ff 8b 03 e8 d0 2a ff ff 8d 46 08 
39 c3 77
Mar  6 16:03:23 watch4tv <6>bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:23 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:23 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:23 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:23 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:23 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:23 watch4tv bttv3: OCERR @ 1efbf000,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:23 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:24 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:24 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:24 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:24 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:24 watch4tv bttv3: OCERR @ 1efbf014,bits: HSYNC OFLOW OCERR*
Mar  6 16:03:24 watch4tv bttv3: timeout: drop=0 irq=357/1364, 
risc=1efbf01c, bits: HSYNC OFLOW
Mar  6 16:03:27 watch4tv bttv3: reset, reinitialize
Mar  6 16:03:27 watch4tv bttv3: PLL: 28636363 => 35468950 . ok
Mar  6 16:03:54 watch4tv SysRq : Emergency Remount R/O

### [6.] A small shell script or example program which triggers the problem:
#!/bin/bash
export LC_ALL="en_US.ISO-8859-1"
export DISPLAY=:0
X -bpp 16 -auth /var/run/xauth/A:0-DieZbc vt7 &
xhost +
sleep 2
v4l-conf -c /dev/video0 -d :0 &
v4l-conf -c /dev/video1 -d :0 &
v4l-conf -c /dev/video2 -d :0 &
v4l-conf -c /dev/video3 -d :0 &
xawtv -c /dev/video0 -geometry 639x511+0+0 -display :0 "CERN site SE17" &
xawtv -c /dev/video1 -geometry 639x511+640+0 -display :0 "CERN site SE18" &
xawtv -c /dev/video2 -geometry 639x511+0+512 -display :0 "CERN site SE19" &
xawtv -c /dev/video3 -geometry 639x511+640+512 -display :0 "CERN site 
SE20" &
xset -display :0 -dpms &
xset -display :0 s noblank &
xset -display :0 s noexpose &
xset -display :0 s off &
xset -display :0 s 0 0 &

### [7.] Environment:
### [7.1.] Software (add the output of the ver_linux script here):
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux watch4tv 2.6.16-rc5 #2 Mon Mar 6 15:59:18 CET 2006 i686 Intel(R) 
Celeron(R) CPU 2.80GHz GenuineIntel GNU/Linux

Gnu C                  3.4.4
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           line
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   079
Modules Loaded         nls_cp850 i915 drm ohci_hcd tuner tvaudio bttv 
video_buf compat_ioctl32 i2c_algo_bit v4l2_common btcx_risc ir_common 
tveeprom i2c_core videodev ehci_hcd usb_storage uhci_hcd snd_pcm_oss 
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 
snd_bt87x snd_hda_intel snd_hda_codec snd_pcm snd_timer snd soundcore 
snd_page_alloc usbcore

### [7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Celeron(R) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2800.604
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx 
constant_tsc pni monitor ds_cpl tm2 cid xtpr
bogomips        : 5611.80

### [7.3.] Module information (from /proc/modules):
nls_cp850 4736 1 - Live 0xe0505000
i915 15744 1 - Live 0xe04d9000
drm 53652 2 i915, Live 0xe04e5000
ohci_hcd 16132 0 - Live 0xe048a000
tuner 44460 0 - Live 0xe048f000
tvaudio 19996 0 - Live 0xe0475000
bttv 150900 4 - Live 0xe04a4000
video_buf 15364 1 bttv, Live 0xe047b000
compat_ioctl32 1152 1 bttv, Live 0xe043c000
i2c_algo_bit 7432 1 bttv, Live 0xe0472000
v4l2_common 6528 2 tuner,bttv, Live 0xe0447000
btcx_risc 3720 1 bttv, Live 0xe0078000
ir_common 7812 1 bttv, Live 0xe041e000
tveeprom 12176 1 bttv, Live 0xe046e000
i2c_core 15248 5 tuner,tvaudio,bttv,i2c_algo_bit,tveeprom, Live 0xe0442000
videodev 6656 5 bttv, Live 0xe0421000
ehci_hcd 23560 0 - Live 0xe0467000
usb_storage 29316 1 - Live 0xe045e000
uhci_hcd 25872 0 - Live 0xe0456000
snd_pcm_oss 40992 0 - Live 0xe044a000
snd_mixer_oss 14080 1 snd_pcm_oss, Live 0xe0424000
snd_seq_oss 26112 0 - Live 0xe0434000
snd_seq_midi_event 5504 1 snd_seq_oss, Live 0xe041b000
snd_seq 40016 4 snd_seq_oss,snd_seq_midi_event, Live 0xe0429000
snd_seq_device 6284 2 snd_seq_oss,snd_seq, Live 0xe00fb000
snd_bt87x 10824 0 - Live 0xe004d000
snd_hda_intel 12688 0 - Live 0xe006f000
snd_hda_codec 111616 1 snd_hda_intel, Live 0xe0317000
snd_pcm 66952 4 snd_pcm_oss,snd_bt87x,snd_hda_intel,snd_hda_codec, Live 
0xe0305000
snd_timer 17540 2 snd_seq,snd_pcm, Live 0xe005e000
snd 39140 10 
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_bt87x,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer, 
Live 0xe0064000
soundcore 6624 1 snd, Live 0xe0054000
snd_page_alloc 7688 3 snd_bt87x,snd_hda_intel,snd_pcm, Live 0xe0051000
usbcore 97668 5 ohci_hcd,ehci_hcd,usb_storage,uhci_hcd, Live 0xe00c1000

### [7.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem):
## /proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-0403 : PM1a_EVT_BLK
0404-0405 : PM1a_CNT_BLK
0408-040b : PM_TMR
0410-0415 : ACPI CPU throttle
0420-0420 : PM2_CNT_BLK
0428-042f : GPE0_BLK
0500-053f : pnp 00:0c
0680-06ff : pnp 00:0c
c400-c41f : 0000:00:1f.3
c800-c81f : 0000:00:1d.0
  c800-c81f : uhci_hcd
cc00-cc1f : 0000:00:1d.1
  cc00-cc1f : uhci_hcd
d000-d01f : 0000:00:1d.2
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:1d.3
  d400-d41f : uhci_hcd
d800-d80f : 0000:00:1f.2
  d800-d80f : libata
dc00-dc03 : 0000:00:1f.2
  dc00-dc03 : libata
e000-e007 : 0000:00:1f.2
  e000-e007 : libata
e400-e403 : 0000:00:1f.2
  e400-e403 : libata
e800-e807 : 0000:00:1f.2
  e800-e807 : libata
ec00-ec07 : 0000:00:02.0
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

## /proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1f72fbff : System RAM
  00100000-002cb992 : Kernel code
  002cb993-00380453 : Kernel data
1f72fc00-1f72ffff : ACPI Non-volatile Storage
1f730000-1f73ffff : ACPI Tables
1f740000-1f7effff : ACPI Non-volatile Storage
1f7f0000-1f7fffff : reserved
c0000000-cfffffff : 0000:00:02.0
d0000000-d00fffff : PCI Bus #01
d0100000-d01fffff : PCI Bus #02
d0200000-d02fffff : PCI Bus #03
d0300000-d03fffff : PCI Bus #04
d0400000-d04fffff : PCI Bus #05
d0500000-d05fffff : PCI Bus #06
  d0500000-d0500fff : 0000:06:00.1
    d0500000-d0500fff : Bt87x audio
  d0501000-d0501fff : 0000:06:00.0
    d0501000-d0501fff : bttv0
  d0502000-d0502fff : 0000:06:01.1
    d0502000-d0502fff : Bt87x audio
  d0503000-d0503fff : 0000:06:01.0
    d0503000-d0503fff : bttv1
  d0504000-d0504fff : 0000:06:02.1
    d0504000-d0504fff : Bt87x audio
  d0505000-d0505fff : 0000:06:02.0
    d0505000-d0505fff : bttv2
  d0506000-d0506fff : 0000:06:03.1
    d0506000-d0506fff : Bt87x audio
  d0507000-d0507fff : 0000:06:03.0
    d0507000-d0507fff : bttv3
e0000000-efffffff : reserved
fed13000-fed19fff : reserved
fed1c000-fed9ffff : reserved
ff400000-ff4fffff : PCI Bus #01
ff500000-ff5fffff : PCI Bus #02
ff600000-ff6fffff : PCI Bus #03
ff700000-ff7fffff : PCI Bus #04
ff800000-ff8fffff : PCI Bus #05
ff900000-ff9fffff : PCI Bus #06
ffa00000-ffa7ffff : 0000:00:02.0
ffa80000-ffabffff : 0000:00:02.0
ffac0000-ffac3fff : 0000:00:1b.0
  ffac0000-ffac3fff : ICH HD audio
ffac4000-ffac43ff : 0000:00:1d.7
  ffac4000-ffac43ff : ehci_hcd

[7.5.] PCI information ('lspci -vvv' as root):
00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor 
to I/O Controller (rev 04)
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express 
Root Port (rev 04) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ff400000-ff4fffff
        Prefetchable memory behind bridge: d0000000-d00fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [a0] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s, Port 2
                Link: Latency L0s <256ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x16
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- 
Surpise-
                Slot: Number 0, PowerLimit 75.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [140] Unknown (5)

00:02.0 VGA compatible controller: Intel Corporation 82915G/GV/910GL 
Express Chipset Family Graphics Controller (rev 04) (prog-if 00 [VGA])
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at ffa00000 (32-bit, non-prefetchable) [size=512K]
        Region 1: I/O ports at ec00 [size=8]
        Region 2: Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Region 3: Memory at ffa80000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) High Definition Audio Controller (rev 03)
        Subsystem: Intel Corporation Unknown device e203
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at ffac0000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, 
Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ff800000-ff8fffff
        Prefetchable memory behind bridge: 00000000d0400000-00000000d0400000
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag+
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
                Link: Latency L0s <1us, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ 
Surpise+
                Slot: Number 1, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ff700000-ff7fffff
        Prefetchable memory behind bridge: 00000000d0300000-00000000d0300000
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag+
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
                Link: Latency L0s <1us, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ 
Surpise+
                Slot: Number 2, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ff600000-ff6fffff
        Prefetchable memory behind bridge: 00000000d0200000-00000000d0200000
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag+
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
                Link: Latency L0s <1us, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ 
Surpise+
                Slot: Number 3, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.3 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) PCI Express Port 4 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ff500000-ff5fffff
        Prefetchable memory behind bridge: 00000000d0100000-00000000d0100000
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag+
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
                Link: Latency L0s <1us, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ 
Surpise+
                Slot: Number 4, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 22
        Region 4: I/O ports at c800 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at cc00 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at d000 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 16
        Region 4: I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at ffac4000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3) (prog-if 
01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=128
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ff900000-ff9fffff
        Prefetchable memory behind bridge: 00000000d0500000-00000000d0500000
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC 
Interface Bridge (rev 03)
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA 
Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at e800 [size=8]
        Region 1: I/O ports at e400 [size=4]
        Region 2: I/O ports at e000 [size=8]
        Region 3: I/O ports at dc00 [size=4]
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
SMBus Controller (rev 03)
        Subsystem: Intel Corporation Unknown device 4156
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at c400 [size=32]

06:00.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at d0501000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:00.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at d0500000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:01.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at d0503000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:01.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at d0502000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at d0505000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at d0504000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:03.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at d0507000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:03.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at d0506000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

### [7.6.] SCSI information (from /proc/scsi/scsi):
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD800JD-22LS Rev: 06.0
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: USB Flash Disk   Rev: 0.00
  Type:   Direct-Access                    ANSI SCSI revision: 02

### [7.7.] Other information that might be relevant to the problem 
(please look in /proc and include all information that you think to be 
relevant):
## modprobe.conf:
alias char-major-81 videodev
alias char-major-8-0 bttv
alias char-major-8-1 bttv
alias char-major-8-2 bttv
alias char-major-8-3 bttv
options bttv card=10 tuner=41

### [8] Other notes, patches, fixes, workarounds:
* Mainboard: Intel D945GNT (945 chipset) - I have tryed it also with 
Intel D915GAV. All four PCI slots are used for TV tuners. AGP slot is 
unused (graphics card is on the board).
# Power supply: Chieftec 400W
# Memory: Kingston 512MB
# HDD: Western Digital SATA 80GB
# TV Tuner: 4x Hauppauge WinTV Express (chip bt878)
* I have tryed vanilla kernel 2.6.15.1 and 2.6.16-rc5 (with / without 
PREEMPT, acpi=on / acpi=off).
* I have tryed insmod options from 
Documents/video4linux/bttv/Insmod-options.
* I have tryed Xorg 6.9 and Xorg 6.8.2 (with / without DRI support - 
Xorg driver i810).
* I have tryed XAWTV 3.94 and XAWTV 3.95.
* I have tryed Gentoo Linux distribution and Scientific Linux CERN 4 
(based on RHEL4).
* I have tryed change BIOS options: Plug&Play Enabled/Disabled, PCI IRQ 
Auto/Manual.

*** always the same.

If somebody know how to solve it, I will be very appreciative. I have 
tryed everything what I know, nothing helps.

Best Regards,
Jiri Tyr

