Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbTCZQ2d>; Wed, 26 Mar 2003 11:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261772AbTCZQ2d>; Wed, 26 Mar 2003 11:28:33 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6817 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261771AbTCZQ2b>; Wed, 26 Mar 2003 11:28:31 -0500
Date: Wed, 26 Mar 2003 08:39:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 506] New: clean-up: unneeded version.h in sound drivers 
Message-ID: <232710000.1048696780@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=506

           Summary: clean-up: unneeded version.h in sound drivers
    Kernel Version: 2.5.66-bk2
            Status: NEW
          Severity: low
             Owner: bugme-janitors@lists.osdl.org
         Submitter: bwindle-kbt@fint.org


Problem Description:
There appear to be quite a few files in the 2.5.66-bk2 tree, in the sound 
driver area, that #include <linux/version.h>, but do not use any of the
three  things defined in it.

linux/sound/oss/cs46xx.c
linux/sound/oss/emu10k1/audio.c
linux/sound/oss/emu10k1/passthrough.c
linux/sound/oss/emu10k1/mixer.c
linux/sound/oss/emu10k1/main.c
linux/sound/oss/emu10k1/midi.c
linux/sound/oss/cs4281/cs4281m.c
linux/sound/oss/esssolo1.c
linux/sound/oss/ac97_codec.c
linux/sound/oss/ite8172.c
linux/sound/oss/btaudio.c
linux/sound/oss/sonicvibes.c
linux/sound/oss/cmpci.c
linux/sound/oss/msnd_pinnacle.c
linux/sound/oss/nec_vrc5477.c
linux/sound/oss/es1371.c
linux/sound/oss/i810_audio.c
linux/sound/oss/trident.c
linux/sound/oss/maestro.c
linux/sound/oss/es1370.c
linux/sound/core/wrappers.c
linux/sound/core/memory_wrapper.c
linux/sound/core/sgbuf.c

Because of this, if the kernel version changes, but nothing else is
modified,  these file would be forced needless to recompile due to
version.h changing.

Would a patch to remove these unnessary includes be accepted?


