Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUE2MfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUE2MfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 08:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUE2MfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 08:35:17 -0400
Received: from lucidpixels.com ([66.45.37.187]:12464 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S264388AbUE2Me4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 08:34:56 -0400
Date: Sat, 29 May 2004 08:34:52 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
cc: rivatv-help@lists.sourceforge.net, riva-devel@lists.sourceforge.net
Subject: RivaTV not working for GeForce4 Ti 4800SE (fwd)
Message-ID: <Pine.LNX.4.60.0405290830430.19483@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To LKML: What does that call trace mean, why did it do that? Because 
video/rivatv does NOT work right with SMP?

It worked after I loaded the right driver for the decoder =P

Kernel is tainted obviously, I do not believe the [nv] driver supports two 
monitors (at least I couldn't get it to work with that).

Therefore I use the nvidia binary driver.
Even though 3D crashes X as of driver 5536, oh well.

Another problem though, with dma=1 w/SMP it freezes.

Just modprobe rivatv though, it works ok.

Also, how do you get AUDIO+VIDEO to sync?
I have AUDIO -> LINE-INPUT -> SOUND CARD.
I have VIDEO -> NVIDIA GEFORCE4 TI4800SE CARD.

Also, why do I get this not implemented error?
(it says my card is fully supported on the page?)

rivatv: starting video capture
rivatv: stopping video capture
rivatv: V4L: Requested IOCTL (0x80685600) not implemented
rivatv: VIDIOCGCAP
rivatv: VIDIOCGCHAN
rivatv: VIDIOCGCHAN
rivatv: VIDIOCGMBUF
rivatv: MMAP buffer available in user space (6480 kb)
rivatv: VIDIOCSCHAN: 0
rivatv: VIDIOCGCHAN
rivatv: VIDIOCSCHAN: 0
rivatv: VIDIOCGCAP
rivatv: VIDIOCGPICT

Got a nasty error when playing w/mplayer:

rivatv: stopping video capture
Badness in pci_find_subsys at drivers/pci/search.c:167
Call Trace:
  [<c0225ae6>] pci_find_subsys+0x102/0x11b
  [<c0225b2e>] pci_find_device+0x2f/0x33
  [<c0225b59>] pci_find_slot+0x27/0x4d
  [<f8e36339>] os_pci_init_handle+0x33/0x5c [nvidia]
  [<f8cca85f>] _nv001243rm+0x1f/0x24 [nvidia]
  [<f8e11115>] _nv000816rm+0x2f5/0x384 [nvidia]
  [<f8d7992c>] _nv003801rm+0xd8/0x100 [nvidia]
  [<f8e10c4f>] _nv000809rm+0x2f/0x34 [nvidia]
  [<f8d7a750>] _nv003816rm+0xf0/0x104 [nvidia]
  [<f8d7b4c7>] _nv000013rm+0x77/0x84 [nvidia]
  [<f8d7ae6b>] _nv003780rm+0x1df/0x2c8 [nvidia]
  [<f8d7ac77>] _nv000012rm+0x43/0x58 [nvidia]
  [<f8d7ac34>] _nv000012rm+0x0/0x58 [nvidia]
  [<f8cbe69c>] _nv001219rm+0xa8/0x124 [nvidia]
  [<f8cceeb6>] rm_run_rc_callback+0x36/0x4c [nvidia]
  [<f8e3395f>] nv_kern_rc_timer+0x0/0x31 [nvidia]
  [<f8e3396f>] nv_kern_rc_timer+0x10/0x31 [nvidia]
  [<c01298e6>] run_timer_softirq+0xdb/0x1b7
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0116a77>] smp_apic_timer_interrupt+0x16a/0x16f
  [<c010713a>] apic_timer_interrupt+0x1a/0x20
  [<c0111d46>] get_offset_tsc+0x2/0x17
  [<c010caba>] do_gettimeofday+0x1e/0xb6
  [<c0124bac>] sys_gettimeofday+0x27/0xb6
  [<c010674b>] syscall_call+0x7/0xb

Badness in pci_find_subsys at drivers/pci/search.c:167
Call Trace:
  [<c0225ae6>] pci_find_subsys+0x102/0x11b
  [<c0225b2e>] pci_find_device+0x2f/0x33
  [<c0225b59>] pci_find_slot+0x27/0x4d
  [<f8e36339>] os_pci_init_handle+0x33/0x5c [nvidia]
  [<f8cca85f>] _nv001243rm+0x1f/0x24 [nvidia]
  [<f8d7ba5d>] _nv003797rm+0xa9/0x128 [nvidia]
  [<f8de84a1>] _nv001490rm+0x55/0xe4 [nvidia]
  [<f8e11154>] _nv000816rm+0x334/0x384 [nvidia]
  [<f8d7992c>] _nv003801rm+0xd8/0x100 [nvidia]
  [<f8e10c4f>] _nv000809rm+0x2f/0x34 [nvidia]
  [<f8d7a750>] _nv003816rm+0xf0/0x104 [nvidia]
  [<f8d7b4c7>] _nv000013rm+0x77/0x84 [nvidia]
  [<f8d7ae6b>] _nv003780rm+0x1df/0x2c8 [nvidia]
  [<f8d7ac77>] _nv000012rm+0x43/0x58 [nvidia]
  [<f8d7ac34>] _nv000012rm+0x0/0x58 [nvidia]
  [<f8cbe69c>] _nv001219rm+0xa8/0x124 [nvidia]
  [<f8cceeb6>] rm_run_rc_callback+0x36/0x4c [nvidia]
  [<f8e3395f>] nv_kern_rc_timer+0x0/0x31 [nvidia]
  [<f8e3396f>] nv_kern_rc_timer+0x10/0x31 [nvidia]
  [<c01298e6>] run_timer_softirq+0xdb/0x1b7
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0116a77>] smp_apic_timer_interrupt+0x16a/0x16f
  [<c010713a>] apic_timer_interrupt+0x1a/0x20
  [<c0111d46>] get_offset_tsc+0x2/0x17
  [<c010caba>] do_gettimeofday+0x1e/0xb6
  [<c0124bac>] sys_gettimeofday+0x27/0xb6
  [<c010674b>] syscall_call+0x7/0xb



---------- Forwarded message ----------
Date: Sat, 29 May 2004 05:13:44 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
To: rivatv-help@lists.sourceforge.net
Cc: rivatv@lists.sourceforge.net
Subject: RivaTV not working for GeForce4 Ti 4800SE

When sending a bug report or support request
We always need information to be able to help you. Here's a list of what we may 
need. If unsure, include it!

     * problem/bug description
     * linux kernel version + UP or SMP
     * RivaTV version (release or CVS + date)
     * graphics card used (name, nVidia chip, decoder chip)
     * some global system information (CPU, chipset, memory)
     * video standard (NTSC/PAL/SECAM)
     * X driver + version
     * client software (xawtv/ffmpeg/mplayer/etc), if relevant
     * relevant parts of your syslog (usually /var/log/messages or 
/var/log/syslog)
     * output of cat /proc/drivers/rivatv? if available

1] Problem, no /dev/video*
2] Kernel 2.6.5 (SMP) (P4 w/HT)
3] RivaTV version: rivatv-0.8.5
4] Graphics Card:
01:00.0 VGA compatible controller: nVidia Corporation NV28 [GeForce4 Ti 4800 
SE] (rev a1)
5] System: 2.6GHZ HT, Intel Chipset (ICH5), 2GB MEMORY
6] Video standard: NTSDC
7] X driver (NVIDIA) - Version, 5536, X Version 4.4.0
8] mplayer-1.0pre4, xawtv-3.91
9] dmesg

rivatv: Video4Linux driver for NVIDIA cards
rivatv: Version 0.8.5
rivatv: MMX processor extension enabled
rivatv: nVidia card found - rivatv0
rivatv: Identified your board as Gainward Ultra/750-8X GeForce4 Ti4800SE
rivatv: MTRR successfully enabled
rivatv: PCI nVidia NV20 card detected (GeForce4 Ti4800 SE [0x282], 128MB @ 
0xF0000000)
rivatv: I2C adapter driver for NVIDIA cards
i2c_adapter i2c-6: warning: client_register seems to have failed for client 50
i2c_adapter i2c-7: warning: client_register seems to have failed for client 50
rivatv: procfs file registered for rivatv0
rivatv: allocated YUV capture buffer (812 kb)
rivatv: AGPGART: version 0.100
rivatv: AGPGART: aperture is 128MB @ 0xE8000000, AGP 1x 2x supported
rivatv: AGP: disabled
rivatv: Hash table layout: 16kB (11 bits) @ 0xF8710000
rivatv: NVdriver (nvidia) detected, DMA not supported
rivatv: successfully requested IRQ 16
rivatv: Video4Linux device driver registered
rivatv: no video decoder device registered
rivatv: no video decoder device registered
rivatv: no video decoder device registered
rivatv: successfully freed IRQ 16
rivatv: freeing YUV capture buffer (812 kb)
rivatv: procfs file unregistered for rivatv0
rivatv: Video4Linux driver for NVIDIA cards
rivatv: Version 0.8.5
rivatv: MMX processor extension enabled
rivatv: nVidia card found - rivatv0
rivatv: Identified your board as Gainward Ultra/750-8X GeForce4 Ti4800SE
rivatv: MTRR successfully enabled
rivatv: PCI nVidia NV20 card detected (GeForce4 Ti4800 SE [0x282], 128MB @ 
0xF0000000)
rivatv: I2C adapter driver for NVIDIA cards
rivatv: chip registration requested: 1005 (eeprom)
i2c_adapter i2c-9: warning: client_register seems to have failed for client 50
rivatv: chip registration requested: 1005 (eeprom)
i2c_adapter i2c-10: warning: client_register seems to have failed for client 50
rivatv: procfs file registered for rivatv0
rivatv: allocated YUV capture buffer (812 kb)
rivatv: AGPGART: version 0.100
rivatv: AGPGART: aperture is 128MB @ 0xE8000000, AGP 1x 2x supported
rivatv: AGP: disabled
rivatv: Hash table layout: 16kB (11 bits) @ 0xF8710000
rivatv: NVdriver (nvidia) detected, DMA not supported
rivatv: RAMHT: 0xF8710000, RAMFC: 0xF8714000, RAMRO: 0xF8714A00
rivatv: successfully requested IRQ 16
rivatv: Video4Linux device driver registered
rivatv: no video decoder device registered
rivatv: no video decoder device registered
rivatv: no video decoder device registered

10] Output from /proc/drivers/rivatv:

$ cat rivatv0
nVidia Chip:    GeForce4 Ti4800 SE
Model:          Gainward Ultra/750-8X GeForce4 Ti4800SE
Architecture:   NV20 (NV28)
Access:         Control [0xf8000000-0xf8ffffff]
                 FB      [0xf0000000-0xf7ffffff]
Interrupts:     0 out of 44156 (DMA: 0, Overlay: 0, Missing: 44156)
Device:         available
VideoDecoder:   unavailable
Tuner:          unavailable
AudioDecoder:   unavailable
AudioProcessor: unavailable
IR chip:        unavailable


