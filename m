Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266788AbRGOR7X>; Sun, 15 Jul 2001 13:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266757AbRGOR7D>; Sun, 15 Jul 2001 13:59:03 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:53009 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S266754AbRGOR7B>; Sun, 15 Jul 2001 13:59:01 -0400
Date: Sun, 15 Jul 2001 19:59:03 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6-ac2: "uart401: bad devc"
Message-ID: <20010715195903.A5982@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.6-ac2 with CONFIG_MIDI_VIA82CXXX set does cause a 
kernel hang on my setup. On the first sound I play (ie cat >/dev/dsp)
an endless stream of "uart401: bad devc" messages shows up on the 
console - everything else hangs.

Related config details:

/dev/dsp is on a sound blaster live, via82cxxx_audio is the second 
sound card (not really used). Both are loaded as modules.

emu10k1 and via82cxxx share the same interrupt (5). I assume that 
the via midi driver gets confused by the interrupt that was meant
for the sound blaster live.

If I try a kernel without CONFIG_MIDI_VIA82CXXX defined, the problem
disappears.

Jan

