Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422778AbWBIChc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWBIChc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 21:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422779AbWBIChc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 21:37:32 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:37866 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422778AbWBIChb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 21:37:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Hwfxw+aenhHJfiSaPpJYLYYK9oCf7ACO2oRUN6g3Uj9bTQdMeSCGbZsXy/RnIONJTuaV7vd3xR06/lW7KUVTaRr1zRszwPXpCv1GBM74A1epuhVJKqrV1fXh0hLq2Hve7finlBn5apuycD6Z5yQkm4nh5BsmE6OTkLH2lEqXI2A=
Message-ID: <43EAB5FF.9030305@gmail.com>
Date: Wed, 08 Feb 2006 19:24:47 -0800
From: Anthony Tippett <atippett@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/swap.c:49
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone direct to whom I should send this kernel BUG or what else I 
should send as debugging information.

It looks like it might be an issue with Xorg and fglrx (ati drivers)

Feb  8 16:50:42 act kernel: kernel BUG at mm/swap.c:49!
Feb  8 16:50:42 act kernel: invalid operand: 0000 [#1]
Feb  8 16:50:42 act kernel: Modules linked in: fglrx binfmt_misc nfsd 
exportfs lockd nfs_acl sunrpc parport_pc lp parport autofs4 ipv6 deflate 
zlib_deflate twofish serpent aes blowfish des sha256 sha1 crypto_null 
af_key snd_bt87x emu10k1_gp gameport snd_emu10k1_synth snd_emux_synth 
snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi 
snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_seq_device 
snd_util_mem snd_hwdep ohci1394 ieee1394 snd_intel8x0
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer 
snd soundcore snd_page_alloc forcedeth ehci_hcd ohci_hcd ide_cd cdrom 
ide_disk ide_generic usb_storage nvidia_agp agpgart usbhid usbcore 
tvaudio tuner msp3400 bttv video_buf firmware_class v4l2_common 
btcx_risc tveeprom videodev i2c_algo_bit i2c_core amd74xx ide_core 
joydev ext3 jbd mbcache sd_mod sata_sil libata scsi_mod shpchp 
pci_hotplug evdev mousedev
Feb  8 16:50:42 act kernel: CPU:    0
Feb  8 16:50:42 act kernel: EIP:    0060:[put_page+78/105]    Tainted: 
P    B VLI
Feb  8 16:50:42 act kernel: EFLAGS: 00213256   (2.6.15-1-k7)
Feb  8 16:50:42 act kernel: EIP is at put_page+0x4e/0x69
Feb  8 16:50:42 act kernel: eax: 00000000   ebx: c12e6560   ecx: 
c12e6560   edx: c12e6560
Feb  8 16:50:42 act kernel: esi: d658d5a0   edi: 00000020   ebp: 
b6968000   esp: da65be94
Feb  8 16:50:42 act kernel: ds: 007b   es: 007b   ss: 0068
Feb  8 16:50:42 act kernel: Process Xorg (pid: 4479, threadinfo=da65a000 
task=daf54050)
Feb  8 16:50:42 act kernel: Stack: c013b59f c12e6560 c12e6560 dea10a20 
ffffffff 00000000 b6968000 dda2fb68
Feb  8 16:50:42 act kernel:        b6969000 dda2fb68 c013b6e9 c032443c 
d942f6a4 dda2fb68 b6968000 b6969000
Feb  8 16:50:42 act kernel:        da65bf14 00000000 dda2fb68 b6968000 
d942f6a4 b6969000 da65bf48 c013b79f
Feb  8 16:50:42 act kernel: Call Trace:
Feb  8 16:50:42 act kernel:  [zap_pte_range+358/476] 
zap_pte_range+0x166/0x1dc
Feb  8 16:50:42 act kernel:  [unmap_page_range+212/227] 
unmap_page_range+0xd4/0xe3
Feb  8 16:50:42 act kernel:  [unmap_vmas+167/339] unmap_vmas+0xa7/0x153
Feb  8 16:50:42 act kernel:  [unmap_region+114/209] unmap_region+0x72/0xd1
Feb  8 16:50:42 act kernel:  [do_munmap+201/232] do_munmap+0xc9/0xe8
Feb  8 16:50:42 act kernel:  [sys_munmap+57/84] sys_munmap+0x39/0x54
Feb  8 16:50:42 act kernel:  [sysenter_past_esp+84/117] 
sysenter_past_esp+0x54/0x75
Feb  8 16:50:42 act kernel: Code: 00 46 a1 27 c0 83 42 04 ff 0f 98 c0 84 
c0 74 35 8b 4a 30 89 54 24 04 ff e1 8b 02 89 d1 f6 c4 40 74 03 8b 4a 0c 
8b 41 04 40 75 08 <0f> 0b 31 00 46 a1 27 c0 83 42 04 ff 0f 98 c0 84 c0 
74 07 89 d0

