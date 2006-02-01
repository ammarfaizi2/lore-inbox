Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWBACNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWBACNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWBACNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:13:40 -0500
Received: from viefep12-int.chello.at ([213.46.255.25]:54830 "EHLO
	viefep20-int.chello.at") by vger.kernel.org with ESMTP
	id S964880AbWBACNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:13:39 -0500
Date: Wed, 1 Feb 2006 03:13:31 +0100
To: linux-kernel@vger.kernel.org
Subject: kernel panic 2.6.15
Message-ID: <20060201021331.GA500@lazy.shacknet.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: lkml@lazy.shacknet.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

good morning,

when rendering a video with cinelerra (heavy disk io/cpu), even in
single user mode (recent debian unstable), the kernel running on this
computer haunts me with panic reactions.

Call Trace:

update_process_times
timer_interrupt
handle_IRQ_event
__do_IRQ
do_IRQ
common_interrupt
__copy_from_user
genuine_file_buffered_write
lin_vfs_get_block
xfs_write
ide_build_sglist
linvfs_aio_write
do_sync_write
autoremove_wake_function
vfs_write
sys_write
syscall_call

if that says anything to you - please tell me. I hope its enough to tell
whats going on. if not, please ask, I want that to work :)

yours,
peter

PS: the render goes thru with an old 2.4.sth kernel, but not with
2.6.14. the system is a via kt400 based, list of modules loaded:

Module                  Size  Used by
nls_iso8859_15          4104  - 
nls_cp850               4360  - 
vfat                   11112  - 
fat                    46052  - 
w83627hf               24760  - 
hwmon_vid               2024  - 
eeprom                  5432  - 
i2c_isa                 3016  - 
i2c_viapro              6488  - 
snd_seq_oss            31808  - 
snd_seq_midi            6752  - 
snd_seq_midi_event      5704  - 
snd_seq                47440  - 
tuner                  37840  - 
snd_via82xx            23168  - 
snd_ens1371            18436  - 
snd_ac97_codec         93436  - 
snd_pcm_oss            49184  - 
snd_mixer_oss          16904  - 
snd_pcm                80264  - 
snd_mpu401_uart         5544  - 
bttv                  155376  - 
video_buf              17004  - 
i2c_algo_bit            8400  - 
snd_timer              20076  - 
snd_rawmidi            19776  - 
snd_seq_device          6772  - 
v4l2_common             4520  - 
btcx_risc               3792  - 
snd                    43652  - 
tveeprom               11800  - 
i2c_core               17112  - 
videodev                6688  - 
ehci_hcd               29392  - 
snd_page_alloc          8208  - 
ohci1394               31740  - 
via_rhine              19596  - 
ide_cd                 38276  - 
cdrom                  37696  - 
8139too                21896  - 
uhci_hcd               29912  - 
snd_ac97_bus            1576  - 
soundcore               6848  - 
ieee1394               87860  - 
usbcore               108448  - 
