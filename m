Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbVGICfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbVGICfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 22:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbVGICfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 22:35:45 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:10312 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263084AbVGICfn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 22:35:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pfJaP3iC5UU8YdZ+BLtXqf7o+RvqPtciB8tCKAutVwUB6BwLzmnKlm39pytvJusVUB6F35se2yvIq4Ksuv9gumkIv3aspLd7g6hAb4R68aj5HoxKtOXHjwi/YRbqCMBw2vFTPK8WpbVrExnZMHMMPsmPlwPlGczDG90g/+T711g=
Message-ID: <21d7e9970507081935268a2651@mail.gmail.com>
Date: Sat, 9 Jul 2005 12:35:42 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: nboyle@tampabay.rr.com
Subject: Re: [BUG] Oops: EIP is at sysfs_release+0x34/0x80
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42CEB851.1000004@tampabay.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42CEB851.1000004@tampabay.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unable to handle kernel paging request at virtual address 762f7473
>   printing eip:
> c0183c14
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: rtc nls_utf8 snd_emu10k1_synth snd_emu10k1
> snd_emux_synth snd_seq_virmidi snd_rawmidi snd_pcm_oss snd_ac97_codec
> snd_seq_midi_event snd_seq_midi_emul snd_seq snd_pcm ehci_hcd ide_cd
> usbhid snd_mixer_oss snd_timer uhci_hcd af_packet ohci_hcd cdrom
> snd_seq_device snd_page_alloc floppy isofs usbcore snd_hwdep ntfs snd
> tulip snd_util_mem soundcore evdev crc32 smbfs ext2 nls_base unix
> CPU:    0
> EIP:    0060:[<c0183c14>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.13-rc2-GIT-08-7-2005-0)
> EIP is at sysfs_release+0x34/0x80
> eax: 00000001   ebx: dc7c2000   ecx: d1979860   edx: 00000001
> esi: 762f7373   edi: d5ba26a0   ebp: d9368544   esp: dc7c3f80
> ds: 007b   es: 007b   ss: 0068
> Process udev (pid: 31802, threadinfo=dc7c2000 task=c7c19040)
> Stack: df468c40 df798140 dffe4140 c0153c08 d5a9edbc df468c40 df798140
> 00000000
>         dc7c2000 c01523d3 00000000 00000003 080ac568 00000003 c0103101
> 00000003
>         080ac568 00000004 080ac568 00000003 08057198 00000006 0000007b
> 0000007b
> Call Trace:
>   [<c0153c08>] __fput+0xf8/0x110
>   [<c01523d3>] filp_close+0x43/0x70
>   [<c0103101>] syscall_call+0x7/0xb
> Code: 8b 41 0c 8b 40 48 8b 58 14 8b 41 48 8b 40 14 85 db 8b 70 04 74 07
> 89 d8 e8 9a 11 02 00 85 f6 74 1f bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 8e
> 00 01 00 00 83 3e 02 74 32 8b 43 08 ff 4b 14 a8 08 75 21
>   <6>note: udev[31802] exited with preempt_count 1
> 
> I was still able to log in afterwards (I still haven't rebooted the
> machine and I'm typing this on it) but hotplug processes are reproducing
> like rodents and I think the kernel is starting them (I kill everything
> related and they all come back). This was around 5-10 minutes after my
> first boot with this kernel.
> 
Can you send my your .config, lspci and /var/log/Xorg.0.log?

Dave.
