Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRAaNvp>; Wed, 31 Jan 2001 08:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130132AbRAaNvf>; Wed, 31 Jan 2001 08:51:35 -0500
Received: from sj-msg-core-2.cisco.com ([171.69.43.88]:13756 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S129792AbRAaNv1>; Wed, 31 Jan 2001 08:51:27 -0500
Message-ID: <3A782666.1DB4F228@cisco.com>
Date: Wed, 31 Jan 2001 15:51:18 +0100
From: Jan Just Keijser <janjust@cisco.com>
Organization: Cisco Systems Inc
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.4.1 i686)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.1 : unresolved external name_to_kdev_t in md.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unpacked kernel 2.4.1, configured a very modular kernel, including
modules for RAID linear/RAID-[015] and now I get an unresolved external
in the module md.o, as reported by depmod:

 depmod -ea
depmod: *** Unresolved symbols in
/lib/modules/2.4.1/kernel/drivers/md/md.o
depmod:         name_to_kdev_t

The symbol 'name_to_kdev_t' is unknown. Same or similar kernel .config
file in 2.4.0 gave no problems at all. After looking in md.c I saw that
the 2.4.0 version contained a lot of #IFDEF's which are not all gone -
perhaps the assumption is now made that the md.o module is compiled into
the kernel by default now?
FYI: name_to_kdev_t is listed in init/main.c.

any clues anyone?

Tx,

JJK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
