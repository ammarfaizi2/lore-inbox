Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315154AbSEDSbl>; Sat, 4 May 2002 14:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSEDSbk>; Sat, 4 May 2002 14:31:40 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:43018 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315154AbSEDSbk>; Sat, 4 May 2002 14:31:40 -0400
Date: Sat, 4 May 2002 20:31:27 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.13 on alpha - undefined symbol local_irq_save in snd-seq-midi-event.o
Message-ID: <20020504183127.GA8700@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All right - adding an include file is something I can do, but this
is different - any ideas on how to fix this:

cd /lib/modules/2.5.13; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.13; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.13/kernel/sound/core/seq/snd-seq-midi-event.o
depmod:         local_irq_save
depmod:         local_irq_restore
make: *** [_modinst_post] Error 1

alpha:/usr/src/linux-2.5.13-jwk#

Thanks,
Jurriaan
-- 
THIS time it really is fixed. I mean, how many times can we
get it wrong? At some point, we just have to run out of really
bad ideas..
	Linus Torvalds
Debian GNU/Linux 2.5.10 on Alpha 988 bogomips 6 users load:0.74 0.50 0.39
