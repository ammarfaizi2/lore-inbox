Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbTIKHOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 03:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbTIKHOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 03:14:39 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:14721
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S266222AbTIKHOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 03:14:37 -0400
Message-Id: <200309110714.h8B7EaeA007118@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5 build problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Sep 2003 01:14:36 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I config and build -test5, I have two problems
  [everything seems to compile OK, the problems are during the install ]


(1) during the modules_install I see the following error lines:

---

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test5; fi
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/os
s/snd-mixer-oss.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/os
s/snd-pcm-oss.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/se
q/oss/snd-seq-oss.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/se
q/snd-seq-device.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/se
q/snd-seq-midi-emul.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/se
q/snd-seq-midi-event.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/se
q/snd-seq-midi.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/se
q/snd-seq-virmidi.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/se
q/snd-seq.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/sn
d-hwdep.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/sn
d-pcm.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/sn
d-rawmidi.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/sn
d-rtctimer.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/sn
d-timer.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/core/sn
d.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/pci/ac9
7/snd-ac97-codec.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/pci/emu
10k1/snd-emu10k1-synth.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/pci/emu
10k1/snd-emu10k1.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/synth/e
mux/snd-emux-synth.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test5/kernel/sound/synth/s
nd-util-mem.ko

---

Does the sound system still have serious problems, or have I mis-configured 
something
 (I really made a few choices as possible)

===========================

(2) during the make install I see the same errors, and in addition I see:

No module aic7xxx found for kernel 2.6.0-test5, aborting.

Under SCSI low-level driver I have  chosen


    Adaptec AIC7xxx Fast ->U160 support (New Driver)
        Probe for EISA
        Compile in Debugging
        Decode registers
all with a (check) to build them into the kernel, so what is this 'module' 
complaint???

***EVEN when I go back and turn off ALL drivers, I STILL get this silly
message.  What gives???

                                Reg.Clemens
                                reg@dwf.com



