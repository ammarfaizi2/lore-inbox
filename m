Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263591AbREYGu7>; Fri, 25 May 2001 02:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263593AbREYGut>; Fri, 25 May 2001 02:50:49 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:60940 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S263591AbREYGub>; Fri, 25 May 2001 02:50:31 -0400
From: Norbert Preining <preining@logic.at>
Date: Fri, 25 May 2001 08:50:24 +0200
To: linux-kernel@vger.kernel.org, webcam@smcc.demon.nl
Subject: ac15 and 2.4.5-pre6, pwc format conversion
Message-ID: <20010525085024.A17867@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

According to ac ChangeLog:
o       Rip format conversion out of the pwc driver     (me)
        | It belongs in user space..

This change is included in 2.4.5-pre6, but
	drivers/usb/pwc-uncompress.c
still relies on this files:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.5.6-packet/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE   -DEXPORT_SYMTAB -c pwc-uncompress.c
pwc-uncompress.c:25: vcvt.h: No such file or directory
pwc-uncompress.c: In function `pwc_decompress':
pwc-uncompress.c:158: warning: implicit declaration of function `vcvt_420i_rgb24'
pwc-uncompress.c:161: warning: implicit declaration of function `vcvt_420i_bgr24'
pwc-uncompress.c:164: warning: implicit declaration of function `vcvt_420i_rgb32'
pwc-uncompress.c:167: warning: implicit declaration of function `vcvt_420i_bgr32'
pwc-uncompress.c:171: warning: implicit declaration of function `vcvt_420i_yuyv'
pwc-uncompress.c:185: warning: implicit declaration of function `vcvt_420i_420p'

Best wishes

Norbert

PS: Please reply by email since I am not subscribed and I skim the
mailing list via the web archive.
THANKS.

-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+
