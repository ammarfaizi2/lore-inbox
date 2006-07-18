Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWGRN2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWGRN2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWGRN2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:28:41 -0400
Received: from mxsf15.cluster1.charter.net ([209.225.28.215]:43666 "EHLO
	mxsf15.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932192AbWGRN2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:28:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17596.57854.569394.880757@stoffel.org>
Date: Tue, 18 Jul 2006 09:28:30 -0400
From: "John Stoffel" <john@stoffel.org>
To: largret@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic related to ReiserFS (v3)
In-Reply-To: <1153208388.8074.18.camel@localhost>
References: <1153208388.8074.18.camel@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris> This kernel panic happened a few minutes ago, and it is
Chris> probably related to a firefox bug, but it shouldn't cause the
Chris> kernel to panic. I'm running the 2.6.16.16 kernel with the
Chris> latest squashfs (CVS) patch which supported this kernel
Chris> series. The distro is Slamd64, and is on a 64-bit AMD X2
Chris> system. As you can probably guess, my main filesystem is
Chris> ReiserFS. It is on an SATA drive. If more information is
Chris> needed, let me know.

Chris> Jul 17 23:42:49 localhost kernel: Modules linked in: usb_storage vmnet
Chris> parport_pc parport vmmon snd_pcm_oss snd_mixer_oss md5 ipv6 ipt_recent
Chris> ipt_REJECT xt_state iptable_filter nfs lockd nfs_acl sunrpc r8169
Chris> ohci1394 ieee1394 emu10k1_gp gameport snd_emu10k1 snd_rawmidi
Chris> snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer
Chris> snd_page_alloc snd_util_mem snd_hwdep snd 8250_pci 8250 serial_core
Chris> tda9887 tuner cx8800 cx88xx video_buf ir_common tveeprom compat_ioctl32
Chris> v4l1_compat v4l2_common btcx_risc videodev nvidia forcedeth i2c_nforce2
Chris> pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core
Chris> Jul 17 23:42:49 localhost kernel: Pid: 7770, comm: firefox-bin Tainted:
Chris> P      2.6.16.16 #1


You've got a binary kernel module loaded here, please try to re-create
this crash without the nvidia module loaded.  We (hah!  Not me
actually... :-) can't debug this with such a module.

The key is the 'Tainted' flag.  

John
