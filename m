Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319498AbSIMCRO>; Thu, 12 Sep 2002 22:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319503AbSIMCRO>; Thu, 12 Sep 2002 22:17:14 -0400
Received: from snark.ucr.edu ([138.23.237.47]:11524 "EHLO snark.ucr.edu")
	by vger.kernel.org with ESMTP id <S319498AbSIMCRN>;
	Thu, 12 Sep 2002 22:17:13 -0400
Date: Thu, 12 Sep 2002 19:22:04 -0700 (PDT)
From: Jacek Pliszka <pliszka@physics.ucr.edu>
X-X-Sender: pliszka@snark.ucr.edu
Reply-To: Jacek Pliszka <pliszka@physics.ucr.edu>
To: linux-kernel@vger.kernel.org
Subject: recalc_sigpending in usb.c
Message-ID: <Pine.LNX.4.44.0209121917390.1206-100000@snark.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am trying to compile  2.5.34. But during make modules_install

depmod: *** Unresolved symbols in 
/lib/modules/2.5.34/kernel/drivers/usb/storage/usb-storage.o
depmod:         show_trace
depmod:         recalc_sigpending

When I comment out show_trace and add 
EXPORT_SYMBOL(recalc_sigpending);

to kernel/ksyms.c

make modules_install works but then 

modprobe usb-storage gives:

/lib/modules/2.5.34/kernel/drivers/usb/storage/usb-storage.o: unresolved 
symbol recalc_sigpending
/lib/modules/2.5.34/kernel/drivers/usb/storage/usb-storage.o: insmod 
/lib/modules/2.5.34/kernel/drivers/usb/storage/usb-storage.o failed
/lib/modules/2.5.34/kernel/drivers/usb/storage/usb-storage.o: insmod 
usb-storage failed

If I comment out recalc_sigpending instead - the drive does not
work at all. Hangs during eject.

Drive worked, though slowly in 2.4.18-10 (Red Hat 7.3)

I am sorry I am not subscribed so please, CC the answer to me.

Thanks for any help you could provide,

Jacek



