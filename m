Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUAaBFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 20:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUAaBFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 20:05:44 -0500
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:57098 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S264488AbUAaBFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 20:05:35 -0500
Subject: ide-cdrom / atapi burning bug - 2.6.1
From: Mans Matulewicz <cybermans@xs4all.nl>
Reply-To: cybermans@xs4all.nl
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1075511134.5412.59.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 31 Jan 2004 02:05:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
After replacing my 2.4.22  with a 2.6.1 kernel I tried ATAPI cd burning.
This totally fails. Most of the CD's are corrupt and my system totally
locks up when erasing an cdrw (reset button was the option I needed to
reboot my system) . k3b reports cd is completely burned but fails are
not identical or totally unreadable. I tried it both with an tainted
(nvidia) and an untainted (nv) kernel: same results. With ide-scsi
burning in 2.4.x I had no problems. 

Software:
Distro: gentoo
Kernel: 2.6.1 stock 
cdrtools: 2.01_alpha25
cdrdao: 1.1.7-r3
k3b: 0.10.3

Hardware
Cpu: Athlon XP 1700+ (palomino)
Mobo: ASUS A7V333 (kt333) 
Ide interface: VIA Technologies, In VT82C586/B/686A/B PI (rev 6).
	/dev/hda 40 gig ibm harddisc
	/dev/hdb liteon LTR16102B (the troublemaker)
	/dev/hdc 120 gig hitachi harddisc
	/dev/hdd toshiba dvd player
Dma is on

(ver linux script:
Linux meanmachine 2.6.1 #1 SMP Fri Jan 30 21:54:39 CET 2004 i686 AMD
Athlon(TM) XP 1700+ AuthenticAMD GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         w83781d i2c_sensor i2c_viapro i2c_core
iptable_mangle ipt_state iptable_filter ipt_MASQUERADE iptable_nat
ip_conntrack ip_tables hci_usb bluetooth pwc videodev uhci_hcd ehci_hcd
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi
snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1 snd_rawmidi
snd_seq_device snd_ac97_codec snd_util_mem snd_hwdep snd_pcm_oss snd_pcm
snd_page_alloc snd_timer snd_mixer_oss snd soundcore sd_mod scsi_mod
)

