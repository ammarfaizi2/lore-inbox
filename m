Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285309AbRLFXgI>; Thu, 6 Dec 2001 18:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285310AbRLFXft>; Thu, 6 Dec 2001 18:35:49 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:18859 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285309AbRLFXff>;
	Thu, 6 Dec 2001 18:35:35 -0500
Date: Fri, 7 Dec 2001 00:35:28 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: devfs unable to handle permission: 2.4.17-pre[4,5] / ALSA-0.9.0beta[9,10]
Message-Id: <20011207003528.1448673e.rene.rebe@gmx.net>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

At least since 2.4.17-pre4 and -pre5 devfs is not handling permissions in the
right way with ALSA:

rene@jackson:/dev > l dsp sound/dsp 
ls: sound/dsp: Permission denied
lr-xr-xr-x   1 root     root            9 Dec  7 00:14 dsp -> sound/dsp
rene@jackson:/dev > cd sound/
bash: cd: sound/: Permission denied
rene@jackson:/dev > 

rene@jackson:/dev > l snd
ls: snd/..: Permission denied
ls: snd/.: Permission denied
ls: snd/controlC0: Permission denied
ls: snd/controlC1: Permission denied
ls: snd/timer: Permission denied
ls: snd/midiC0D0: Permission denied
ls: snd/pcmC0D2p: Permission denied
ls: snd/pcmC0D1c: Permission denied
ls: snd/pcmC0D0p: Permission denied
ls: snd/pcmC0D0c: Permission denied
ls: snd/midiC1D0: Permission denied
ls: snd/pcmC1D0p: Permission denied
ls: snd/pcmC1D0c: Permission denied
total 0

They all have 666 (or 777 for dirs)! It is possible to this as root.

Also loading the modules gives me:
Dec  7 00:31:58 jackson kernel: devfs: devfs_register(unknown): could not append to parent, err: -17

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
