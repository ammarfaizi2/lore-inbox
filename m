Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755076AbWKLMLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbWKLMLP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 07:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755079AbWKLMLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 07:11:15 -0500
Received: from mail.gmx.de ([213.165.64.20]:59111 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1755060AbWKLMLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 07:11:15 -0500
X-Authenticated: #24128601
Date: Sun, 12 Nov 2006 13:07:36 +0100
From: Sebastian Kemper <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: idecd: attempt to access beyond end of device
Message-ID: <20061112120736.GA4062@section_eight>
Mail-Followup-To: Sebastian Kemper <sebastian_ml@gmx.net>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I'm getting these errors trying to mount a burned DVD-R:

Nov  8 12:39:08 section_eight attempt to access beyond end of device
Nov  8 12:39:08 section_eight hdc: rw=0, want=68, limit=4
Nov  8 12:39:08 section_eight isofs_fill_super: bread failed, dev=hdc,
iso_blknum=16, block=1

The drive is a NEC ND-4550A ATAPI. I use idecd and kernel 2.6.18.2.

DVD+R discs mount just fine. There were no errors while burning the
DVD-R. I tried k3b(-0.12.17),
cdrecord(-2.01.01_alpha10/-2.01.01_alpha20) and growisofs-6.1/-7.0. The
drive is flashed with the latest firmware and the manufacturer claims my
16x DVD-R media is supported.

I can actually mount the burned DVD-R in my other DVD-ROM drive (it's a
read-only device, LITE-ON DVD SOHD-16P9SV).

I'm a bit lost because I can't figure out the proper place to report
this bug. I already posted to k3b-user but got no response. If you could
direct me to the proper person to talk to I'd be happy.

./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux section_eight 2.6.18.2 #1 Mon Nov 6 12:06:35 CET 2006 i686 AMD
Sempron(tm)   2400+ AuthenticAMD GNU/Linux

Gnu C                  4.1.1
Gnu make               3.81
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               6.4
udev                   087
Modules Loaded         rt61 snd_seq_midi snd_seq_midi_event snd_seq
snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_ac97_codec
snd_pcm snd_timer snd_page_alloc snd_ac97_bus snd_i2c snd_mpu401_uart
snd_rawmidi snd_seq_device snd lirc_serial lirc_dev

Thanks
Sebastian
