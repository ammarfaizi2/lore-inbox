Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbTE0ViZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTE0ViZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:38:25 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:53232 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S264139AbTE0ViY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:38:24 -0400
Date: Tue, 27 May 2003 23:51:18 +0200
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: 2.4.21-rc5 - drivers/ide/pci/via82cxxx.c (PCI_DEVICE_ID_VIA_8237)
Message-ID: <20030527215118.GA30616@deimos.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: 1 will be enough!
X-GG: 88988
X-ICQ: 59367544
X-JID: deimos@jabber.gda.pl
X-Operating-System: Slackware GNU/Linux, kernel 2.4.21-rc4, up  3:29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With new -rc5 there is, something like add new:
{ "vt8237",     PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 |
VIA_BAD_AST },

This is not correct.

After make bzImage I have:

(...)
make[4]: Entering directory `/usr/src/linux-2.4.20/drivers/ide/pci'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
-mpreferred-stack-boundary=2 -march=athlon  -I../ -nostdinc -iwithprefix
include -DKBUILD_BASENAME=via82cxxx  -c -o via82cxxx.o via82cxxx.c
via82cxxx.c:78: `PCI_DEVICE_ID_VIA_8237' undeclared here (not in a function)
via82cxxx.c:78: initializer element is not constant
via82cxxx.c:78: (near initialization for `via_isa_bridges[0].id')
via82cxxx.c:78: initializer element is not constant
via82cxxx.c:78: (near initialization for `via_isa_bridges[0]')
(...)

So, you better live it in / FUTURE_BRIDGES / like it was before or something
;-)

P.S. It works, but I don't know if it supose to be that:

#ifdef FUTURE_BRIDGES
        { "vt8237",     PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
#endif

Take care.

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
