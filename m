Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVK0O3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVK0O3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVK0O3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:29:09 -0500
Received: from web.dragon.cz ([213.168.176.4]:43484 "EHLO web.dragon.cz")
	by vger.kernel.org with ESMTP id S1751075AbVK0O3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:29:08 -0500
Message-ID: <4389C2B1.5020001@inv.cz>
Date: Sun, 27 Nov 2005 15:29:05 +0100
From: Martin Volf <mv@inv.cz>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: e1000, 2.6.1[34] - WOL not working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with 2.6.13 and 2.6.14, after I shutdown the computer I can't wake it up with 
the "MagicPacket" over the network. With 2.6.12 and 2.6.12.x it is working.

Steps to reproduce:
Boot 2.6.14, "ethtool -s eth0 wol g", press the power button, acpid runs 
"/sbin/init 0", the computer poweroffs, the link LED on the switch goes off 
and WOL is not working. With 2.6.12 the link remains on and WOL is working.

More mystery:
When I pull out the power cord for a while after the shutdown from 2.6.14, the 
link LED on the switch goes on and WOL is working. So it looks like 2.6.13 and 
.14 is in fact disabling the WOL.

Distribution: Gentoo

Hardware Environment:
CPU P4 with HT, MB Asus P4C800-E Deluxe (Intel 875P chipset) with onboard 
e1000 (Intel 82547EI) connected to a 10/100 switch

Software Environment:
latest BIOS
SMP kernel, more info: http://columbia.dragon.cz/~volf/wol_problem/
ver_linux says:
Gnu C                  3.3.6
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.0
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   070
Modules Loaded         radeon intel_agp drm agpgart nfsd exportfs lockd sunrpc 
microcode w83627hf i2c_sensor i2c_isa i2c_i801 e1000 snd_pcm_oss snd_mixer_oss 
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_bt87x 
snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc 
usblp sata_promise libata scsi_mod uhci_hcd ehci_hcd usbcore loop tuner 
tvaudio bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc 
tveeprom i2c_core videodev ide_cd cdrom


Contents of some /proc files, output of lspci -vvvx and the .config are here:
http://columbia.dragon.cz/~volf/wol_problem/

-- 
Martin Volf

