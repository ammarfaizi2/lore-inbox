Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVCSPrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVCSPrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 10:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVCSPrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 10:47:19 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:30028 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261531AbVCSPrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 10:47:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=XdLQrUifCcZ1U+AnUDPTH40rKWrRudNlsL88LzLyWJVixtCCHu9jAfx78GV+i7X4OctVdYNvqIT0IPsRGglFvTaGv+N7Ndvrrg+XX70U+QBRHioNFtd6mRjxF6byS9bK3pBFRX3YA0k8O1Z17oVYBu0ogjtzOhd/wh/ShJyrDXc=
Message-ID: <b6d0f5fb050319074718fc7efb@mail.gmail.com>
Date: Sat, 19 Mar 2005 15:47:11 +0000
From: Cameron Harris <thecwin@gmail.com>
Reply-To: Cameron Harris <thecwin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic - r8169 on 2.6.11-rc1-mm1
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time i try to use eth1 which is r8169, i get a kernel panic, but
on the actual use of it, not the configuring it.

e.g.
laptop ~ # ifconfig eth1 up 192.168.1.1

laptop ~ # ping 192.168.1.2

PING 192.168.1.2 (192.168.1.2) 56(84) bytes of data.

Oops: 0000 [#1]

Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq_oss
seq_midi_event snd_seq snd_seq_device irtty_sir sir_dev irda pcspkr
snd_intel8x0 snd_ac97_codec snd_pcm snd_timer

snd snd_page_alloc wlan_wep fglrx sis_agp psmouse r8169 ath_pci
ath_rate_onoe wlan ath_hal

CPU:	0

EIP:	0060:[<d15481e5>]	Tainted: P	VLI

EFLAGS:	00010206	(2.6.11-rc1-mm1)

EIP is at rtl8169_start_xmit+0x55/0x2b0 [r8169]

eax: 0000003f	ebx: cf236140 	ecx: cc9c6000	edx: 00000000

esi: cf236240	edi: cfd9b280	ebp: cfd9b280	esp: c0685e00

ds: 007b	es: 007b 	ss: 0068

Process swapper (pid: 0, threadinfo=c0684000 task=c05b6ba0)

Stack: c0107e50 cf236140 cf935080 cfd9b280 00000000 d14da000 cc9c6000 00000000

       80000000 cf236140 cf935080 cf236000 cfd9b280 c049141e cfd9b280 cf236000

       00000000 00000000 cf236000 cfd9b280 cf236140 c048387f cf236000 cf935080

....

 <0>Kernel panic - not syncing: Fatal exception in interrupt

I never had time to write down the whole stack trace (and there was no
core file created)
This driver used to work in a previous kernel version (but it did get
IRQ #x nobody cared messages, usually when there was some sort of a
disconnection of my ethernet cable for whatever reason). This is
always reproducable.

uname -a:
Linux laptop 2.6.11-rc1-mm1 #2 SMP Sun Jan 16 22:36:26 GMT 2005 i686
Intel(R) Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux

I would try a newer kernel, but the command line options for
specifying the framebuffer settings seems to have changed in the
latest kernel and i haven't had enough time to work out how to specify
it.
-- 
Cameron Harris
