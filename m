Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270746AbRIAOPz>; Sat, 1 Sep 2001 10:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270721AbRIAOPp>; Sat, 1 Sep 2001 10:15:45 -0400
Received: from scispor.dolphinics.no ([193.71.152.117]:60174 "EHLO
	scispor.dolphinics.no") by vger.kernel.org with ESMTP
	id <S270712AbRIAOPk> convert rfc822-to-8bit; Sat, 1 Sep 2001 10:15:40 -0400
Message-ID: <200109011619480531.23AA844A@scispor.dolphinics.no>
X-Mailer: Calypso Version 3.00.03.02 (1)
Date: Sat, 01 Sep 2001 16:19:48 +0200
From: "Simen Thoresen" <simentt@dolphinics.no>
To: "alan" <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Status of the VIA KT133a and 2.4.x debacle?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, list, et all,

I've picked up a KT133a board (EpoX 8KTA/3) and a 1.2GHz Thunderbird processor (133MHz FSB), and have seen the same problems that have been reported previously with the KT133a. Random oops'es, both fatal and non fatal, when running the system on a 2.4 kernel with CONFIG_MK7.

The bord seems rock solid with 2.2.x kernels, and also with 2.4.x kernels with CONFIG_M686 set for basic i686 + MMX. I've also run the board with a 100MHz FSB, but that has not improved anything. Also turning off /some/ optimizations in bios have not helped.

Currently, I'm running with a CONFIG_MK7 2.4.9 kernel, but with the Athlon-specific MMX-optimizations in arch/i386/lib/mmx.c turned off, and using the generic mmx-functions available from non-K7 processers. This seems to be working, and I've not been able to provoke a fatal crash oops, nor seen signs of non-fatal oopses.

I have not determined if it is static void fast_clear_page(void *page), or  static void fast_copy_page(void *to, void *from) which is to blame here, but I will continue investigating.

Does this match the results other people have had? Is anything else known about this problem?

Yours,
-Simen Thoresen
--
Simen Thoresen, Beowulf-cleaner and random artist - close and personal.

Er det ikke rart?
The gnu RART-project on http://valinor.dolphinics.no:1080/~simentt/rart


