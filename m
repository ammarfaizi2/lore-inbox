Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbUAGSCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUAGSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:00:50 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:697 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S266288AbUAGSAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:00:03 -0500
Date: Wed, 07 Jan 2004 09:59:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: rjwysocki@sisk.pl
Subject: [Bug 1804] New: IRQ/DMA related problem with ALSA	drivers on ADM64 
Message-ID: <3960000.1073498396@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1804

           Summary: IRQ/DMA related problem with ALSA drivers on ADM64
    Kernel Version: 2.6.1-rc2
            Status: NEW
          Severity: high
             Owner: ak@suse.de
         Submitter: rjwysocki@sisk.pl


Distribution: SuSE 9.0 64-bit (x86_64) 
Hardware Environment: 2 x AMD Opteron 240, Tyan Thunder K8W, 1 GB RAM (4 x 256, two 
nodes, dual-channel), Adaptec AH19160 + 2 x SCSI HDD + SCSI CD-RW (Toshiba), 
NEC-based USB 2.0 adapter (Manhattan), GeForce FX5200 (LeadTek), SATA HDD (Seagate), 
IDE DVD (Liteon) 
Software Environment: Out-of-the box SuSE 9.0 (downloadable version) + Linux 2.6.1-rc2 
Problem Description: There is a hardware problem with the ALSA driver.  It produces no sound 
whatsoever, but there's more (from dmesg): 
 
ACPI: No IRQ known for interrupt pin B of device 0000:00:07.5 
request_module: failed /sbin/modprobe -- net-pf-10. error = 256 
ALSA sound/pci/ac97/ac97_codec.c:1739: AC'97 0:0 analog subsections not ready 
intel8x0: clocking to 48000 
ALSA sound/pci/intel8x0.c:2730: joystick(s) found 
Trying to register duplicated ioctl32 handler 5420 
Trying to register duplicated ioctl32 handler 5421 
Trying to register duplicated ioctl32 handler 5422 
Device not ready.  Make sure there is a disc in the drive. 
Device not ready.  Make sure there is a disc in the drive. 
Device not ready.  Make sure there is a disc in the drive. 
Device not ready.  Make sure there is a disc in the drive. 
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x1000000 
Device not ready.  Make sure there is a disc in the drive. 
Device not ready.  Make sure there is a disc in the drive. 
request_module: failed /sbin/modprobe -- sound-slot-1. error = 256 
request_module: failed /sbin/modprobe -- sound-slot-1. error = 256 
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x1000000 
ALSA sound/core/pcm_native.c:1267: playback drain error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -7, max 
jitter = 5120): wrong interrupt acknowledge? 
request_module: failed /sbin/modprobe -- snd-card-1. error = 256 
request_module: failed /sbin/modprobe -- snd-card-1. error = 256 
ALSA sound/core/pcm_lib.c:2155: playback write error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -63, max 
jitter = 5513): wrong interrupt acknowledge? 
ALSA sound/core/pcm_lib.c:2155: playback write error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -15, max 
jitter = 5513): wrong interrupt acknowledge? 
request_module: failed /sbin/modprobe -- net-pf-10. error = 256 
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x1000000 
request_module: failed /sbin/modprobe -- snd-card-0. error = 256 
ACPI: No IRQ known for interrupt pin B of device 0000:00:07.5 
intel8x0: clocking to 48000 
ALSA sound/pci/intel8x0.c:2730: joystick(s) found 
Trying to register duplicated ioctl32 handler 5420 
Trying to register duplicated ioctl32 handler 5421 
Trying to register duplicated ioctl32 handler 5422 
request_module: failed /sbin/modprobe -- snd-card-1. error = 256 
request_module: failed /sbin/modprobe -- sound-slot-1. error = 256 
request_module: failed /sbin/modprobe -- snd-card-1. error = 256 
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x1000000 
ALSA sound/core/pcm_native.c:1267: playback drain error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -7, max 
jitter = 5120): wrong interrupt acknowledge? 
ALSA sound/core/pcm_lib.c:2155: playback write error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -7, max 
jitter = 5513): wrong interrupt acknowledge? 
ALSA sound/core/pcm_lib.c:2155: playback write error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -79, max 
jitter = 8192): wrong interrupt acknowledge? 
ALSA sound/core/pcm_lib.c:2155: playback write error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -79, max 
jitter = 8192): wrong interrupt acknowledge? 
ALSA sound/core/pcm_lib.c:2155: playback write error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -79, max 
jitter = 8192): wrong interrupt acknowledge? 
ALSA sound/core/pcm_lib.c:2155: playback write error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -175, max 
jitter = 8192): wrong interrupt acknowledge? 
ALSA sound/core/pcm_lib.c:2155: playback write error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_native.c:1267: playback drain error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -175, max 
jitter = 8192): wrong interrupt acknowledge? 
ALSA sound/core/pcm_lib.c:2155: playback write error (DMA or IRQ trouble?) 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -79, max 
jitter = 8192): wrong interrupt acknowledge? 
ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0, delta: -79, max 
jitter = 8192): wrong interrupt acknowledge? 
request_module: failed /sbin/modprobe -- sound-slot-1. error = 256 
 
(The "Device not ready" stuff is probably related to SuSE-something that wants to mount the 
device.  Anyway it's present for 2.6.0 as well). 
 
Hint 1: seemingly, it is not present in rc1, and 2.6.0 works no-glitch ;-) 
Hint 2: it's not related to IOMMU.  It's still present after I had turned the IOMMU off in the 
kernel config. 
 
Steps to reproduce: Compile the kernel, install and run it.  Then try to load ALSA modules and 
play something.



