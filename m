Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKIMv>; Mon, 11 Dec 2000 03:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLKIMl>; Mon, 11 Dec 2000 03:12:41 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:32008 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129314AbQLKIM2>; Mon, 11 Dec 2000 03:12:28 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 11 Dec 2000 08:41:57 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.0test11: "nanoseconds patch" (prerelease) available
Message-ID: <3A34934D.11549.2458DA@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

related to my question about having nanoseconds in xtime for Linux 2.5, 
two (or three) people were interested, or at least managed to route 
their message to me. As promised I have made an early release patch 
against 2.4.0test11 available at

ftp.kernel.org:/pub/linux/daemons/ntp/PPS/pps-2.4-pre1.tar.bz2 (63kB, 
patch + digital signature)

The modified sources compile, link and boot (for arch/i386), but 
consider this code as alpha quality, and don't use it for production 
use. It is possible that it works perfectly, but I simply don't have 
the experience.

Fixes for any architectures are appreciated. Finally I want to get rid 
of gettimeoffset() and a lot of redundant code.

I noticed that the ATM drivers access xtime directly. If jiffies are 
not fine enough, do_gettimeofday() has to be called for now. If that's 
too slow, we have to think about an alternative.

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
