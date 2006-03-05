Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752267AbWCEMW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbWCEMW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 07:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbWCEMW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 07:22:26 -0500
Received: from gecko.sbs.de ([194.138.37.40]:2643 "EHLO gecko.sbs.de")
	by vger.kernel.org with ESMTP id S1752267AbWCEMWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 07:22:25 -0500
Message-ID: <440AD8FE.3000900@sbs.de>
Date: Sun, 05 Mar 2006 13:26:38 +0100
From: Norbert Wegener <nw@sbs.de>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: BUG: soft lockup detected on CPU#0!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure, whether this bug has to do with netfilter. Therefore I 
also  send it to  the suggested address from REPORTING-BUGS.
I hope, this information is sufficient. I don't know, which process has 
been 12848.
Mar  5 12:48:15 nobbi kernel: ip_conntrack version 2.4 (3583 buckets, 
28664 max) - 232 bytes per conntrack
Mar  5 12:48:44 nobbi kernel: BUG: soft lockup detected on CPU#0!
Mar  5 12:48:44 nobbi kernel:
Mar  5 12:48:44 nobbi kernel: Pid: 12848, comm:                rmmod
Mar  5 12:48:44 nobbi kernel: EIP: 0060:[<c011b230>] CPU: 0
Mar  5 12:48:44 nobbi kernel: EIP is at local_bh_enable+0x1/0x5c
Mar  5 12:48:44 nobbi kernel:  EFLAGS: 00000202    Not tainted  
(2.6.15.1-default)
Mar  5 12:48:44 nobbi kernel: EAX: 00000000 EBX: cdcabb10 ECX: c35dbf4c 
EDX: cdcabb10
Mar  5 12:48:44 nobbi kernel: ESI: c35dbf4c EDI: 00000000 EBP: dd243db0 
DS: 007b ES: 007b
Mar  5 12:48:44 nobbi kernel: CR0: 8005003b CR2: 0805e30c CR3: 059d5000 
CR4: 000006d0
Mar  5 12:48:44 nobbi kernel:  [<dd243c54>] get_next_corpse+0xc7/0xce 
[ip_conntrack]
Mar  5 12:48:44 nobbi kernel:  [<dd243db0>] kill_all+0x0/0x6 [ip_conntrack]
Mar  5 12:48:44 nobbi kernel:  [<dd243cb5>] 
ip_ct_iterate_cleanup+0x5a/0x66 [ip_conntrack]
Mar  5 12:48:44 nobbi kernel:  [<dd243dea>] 
ip_conntrack_cleanup+0x14/0x65 [ip_conntrack]
Mar  5 12:48:45 nobbi kernel:  [<dd2427e9>] init_or_cleanup+0x24b/0x24f 
[ip_conntrack]
Mar  5 12:48:45 nobbi kernel:  [<c0129642>] sys_delete_module+0x11f/0x14f
Mar  5 12:48:45 nobbi kernel:  [<c0140905>] do_munmap+0xd2/0xe8
Mar  5 12:48:45 nobbi kernel:  [<c01029db>] sysenter_past_esp+0x54/0x79


Output from sh scripts/ver_linux:




If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux nobbi 2.6.15.1-default #1 Sun Jan 29 12:53:41 CET 2006 i686 athlon 
i386 GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.91.0.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre8
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.6.36
PPP                    2.4.3
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      6.0.6
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   068
Modules Loaded         iptable_nat ip_nat ip_conntrack xfrm_user 
xfrm4_tunnel af_key ohci_hcd usblp nls_cp850 nls_utf8 smbfs ppp_synctty 
iptable_filter ip_tables n_hdlc ppp_generic slhc deflate zlib_deflate 
twofish serpent blowfish sha256 crypto_null aes_i586 sha1 ipcomp esp4 
ah4 speedstep_lib freq_table ipv6 snd_pcm_oss snd_mixer_oss snd_seq 
snd_seq_device button battery ac usbhid edd snd_intel8x0 3c59x 
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore 
snd_page_alloc i2c_sis96x i2c_core sis900 mii sis_agp agpgart ehci_hcd 
usbcore generic shpchp pci_hotplug parport_pc lp parport dm_mod reiserfs 
fan ide_cd cdrom thermal processor sis5513 ide_disk ide_core


Norbert Wegener




