Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934544AbWKXKSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934544AbWKXKSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 05:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934546AbWKXKSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 05:18:13 -0500
Received: from holoclan.de ([62.75.158.126]:7400 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S934544AbWKXKSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 05:18:11 -0500
Date: Fri, 24 Nov 2006 09:47:34 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc6: oops on resume when plugged to AC on suspend
Message-ID: <20061124084734.GB621@gimli>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Got it the second time now, so it's time to report: When
	I suspen while plugged to AC and resume unplugged I get the following
	OOPS: [152108.954000] BUG: unable to handle kernel paging request at
	virtual address 7c880000 [152108.954000] printing eip: [152108.954000]
	c0182b3a [152108.954000] *pde = 00000000 [152108.954000] Oops: 0000 [#1]
	[152108.954000] SMP [152108.954000] Modules linked in: tun ppp_deflate
	zlib_deflate zlib_inflate bsd_comp ppp_async ppp_generic slhc ip_gre
	nls_iso8859_1 nls_cp437 vfat fat usb_storage usbhid snd_hda_intel
	snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
	snd_page_alloc vmnet(P) vmmon(P) i915 binfmt_misc nfs nfsd exportfs
	lockd nfs_acl sunrpc cpufreq_ondemand container video thermal i2c_ec fan
	dock button battery ac mmc_block speedstep_centrino freq_table processor
	ibm_acpi sbp2 nvram eth1394 irtty_sir sir_dev pcmcia sdhci mmc_core
	generic nsc_ircc psmouse irda ohci1394 ieee1394 ehci_hcd ide_core
	yenta_socket rsrc_nonstatic pcmcia_core firmware_class uhci_hcd
	serio_raw usbcore evdev pcspkr crc_ccitt [152108.954000] CPU: 1
	[152108.954000] EIP: 0060:[<c0182b3a>] Tainted: P VLI [152108.954000]
	EFLAGS: 00010212
	(2.6.19-rc6+ieee80211-ipw3945-ch-46.6+1004-g8cdd79c8-dirty #1)
	[152108.955000] EIP is at inotify_inode_queue_event+0x4f/0xd0
	[152108.955000] eax: cffd21ec ebx: cffd20d0 ecx: 00000000 edx: 0000000a
	[152108.955000] esi: 7c87fff8 edi: e212e090 ebp: f7f19a00 esp: ef941d9c
	[152108.955000] ds: 007b es: 007b ss: 0068 [152108.955000] Process mount
	(pid: 10404, ti=ef940000 task=f1360030 task.ti=ef940000) [152108.955000]
	Stack: 00000000 d7d9d090 f7f19a00 00000000 00000000 00000000 00000400
	cffd21ec [152108.955000] c01037f3 cffd21e4 e212e090 cffd20d0 e212e090
	f7f19a00 c016e96a 00000000 [152108.955000] 00000000 e212e090 e212e1c0
	c016f585 e212e0b8 e212e1c0 c016f8e0 fffffff3 [152108.955000] Call Trace:
	[152108.955000] [<c016e96a>] dentry_iput+0x57/0x8f [152108.955000]
	[<c016f585>] prune_one_dentry+0x53/0x74 [152108.955000] [<c016f8e0>]
	shrink_dcache_sb+0x8f/0xb3 [152108.955000] [<c0161fbb>]
	do_remount_sb+0x40/0x120 [152108.955000] [<c0173549>]
	do_mount+0x1b0/0x66c [152108.955000] [<c0173a7c>] [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got it the second time now, so it's time to report:

When I suspen while plugged to AC and resume unplugged I get the following
OOPS:

[152108.954000] BUG: unable to handle kernel paging request at virtual
address 7c880000
[152108.954000]  printing eip:
[152108.954000] c0182b3a
[152108.954000] *pde = 00000000
[152108.954000] Oops: 0000 [#1]
[152108.954000] SMP
[152108.954000] Modules linked in: tun ppp_deflate zlib_deflate zlib_inflate
bsd_comp ppp_async ppp_generic slhc ip_gre nls_iso8859_1 nls_cp437 vfat fat
usb_storage usbhid snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd soundcore snd_page_alloc vmnet(P) vmmon(P) i915
binfmt_misc nfs nfsd exportfs lockd nfs_acl sunrpc cpufreq_ondemand
container video thermal i2c_ec fan dock button battery ac mmc_block
speedstep_centrino freq_table processor ibm_acpi sbp2 nvram eth1394
irtty_sir sir_dev pcmcia sdhci mmc_core generic nsc_ircc psmouse irda
ohci1394 ieee1394 ehci_hcd ide_core yenta_socket rsrc_nonstatic pcmcia_core
firmware_class uhci_hcd serio_raw usbcore evdev pcspkr crc_ccitt
[152108.954000] CPU:    1
[152108.954000] EIP:    0060:[<c0182b3a>]    Tainted: P      VLI
[152108.954000] EFLAGS: 00010212
(2.6.19-rc6+ieee80211-ipw3945-ch-46.6+1004-g8cdd79c8-dirty #1)
[152108.955000] EIP is at inotify_inode_queue_event+0x4f/0xd0
[152108.955000] eax: cffd21ec   ebx: cffd20d0   ecx: 00000000   edx:
0000000a
[152108.955000] esi: 7c87fff8   edi: e212e090   ebp: f7f19a00   esp:
ef941d9c
[152108.955000] ds: 007b   es: 007b   ss: 0068
[152108.955000] Process mount (pid: 10404, ti=ef940000 task=f1360030
task.ti=ef940000)
[152108.955000] Stack: 00000000 d7d9d090 f7f19a00 00000000 00000000 00000000
00000400 cffd21ec
[152108.955000]        c01037f3 cffd21e4 e212e090 cffd20d0 e212e090 f7f19a00
c016e96a 00000000
[152108.955000]        00000000 e212e090 e212e1c0 c016f585 e212e0b8 e212e1c0
c016f8e0 fffffff3
[152108.955000] Call Trace:
[152108.955000]  [<c016e96a>] dentry_iput+0x57/0x8f
[152108.955000]  [<c016f585>] prune_one_dentry+0x53/0x74
[152108.955000]  [<c016f8e0>] shrink_dcache_sb+0x8f/0xb3
[152108.955000]  [<c0161fbb>] do_remount_sb+0x40/0x120
[152108.955000]  [<c0173549>] do_mount+0x1b0/0x66c
[152108.955000]  [<c0173a7c>] sys_mount+0x77/0xb3
[152108.955000]  [<c0102ddb>] syscall_call+0x7/0xb
[152108.955000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[152108.955000]
[152108.955000] Leftover inexact backtrace:
[152108.955000]
[152108.955000]  =======================
[152108.955000] Code: 01 00 00 89 44 24 24 39 83 14 01 00 00 0f 84 91 00 00
00 8d 83 1c 01 00 00 89 44 24 1c e8 f1 26 16 00 8b b3 14 01 00 00 83 ee 08
<8b> 6e 08 eb 58 8b 7e 20 85 7c 24 18 74 4a 8b 5e 14 8d 43 14 89
[152108.955000] EIP: [<c0182b3a>] inotify_inode_queue_event+0x4f/0xd0 SS:ESP
0068:ef941d9c
[152108.955000]


after that I can no longer access the HD.
not even with SysRq keys

details are at 
http://www.lorenz.eu.org/~mlo/kernel/?C=M;O=D

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
