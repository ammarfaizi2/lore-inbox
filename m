Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129569AbRBIVTR>; Fri, 9 Feb 2001 16:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129382AbRBIVTI>; Fri, 9 Feb 2001 16:19:08 -0500
Received: from KMLinux.fjfi.cvut.cz ([147.32.8.9]:55558 "EHLO
	KMLinux.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id <S129292AbRBIVSz>; Fri, 9 Feb 2001 16:18:55 -0500
Date: Fri, 9 Feb 2001 22:18:05 +0100 (CET)
From: Henryk Paluch <paluch@KMLinux.fjfi.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: [RESOLVED]: kernel hangs on CD-R HP8100i if compiled w/ VIA IDE
In-Reply-To: <Pine.LNX.4.10.10101211333300.17469-100000@KMLinux.fjfi.cvut.cz>
Message-ID: <Pine.LNX.4.10.10102092200350.11205-100000@KMLinux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!
 
Shortly: kernel (2.2.x, 2.4.x) hangs on CD-R HP8100i, VIA KT133 chipset
(w/ ATA100 support) if kernel is compiled with VIA IDE chipset support.
Please, see my previous post from 21 Jan 2001 for full description.

 After little tweaking via82cxxx.c driver I found, that the cause is
'Prefetch Buffer: ' (/proc/ide/via) - if disabled for appropriate IDE
channel, everything works well. It also explains, why the kernel works
properly if VIA IDE support is not compiled in - BIOS leaves Prefetch
disabled (I hacked that driver a bit more to show chipset configuration
either before and after modification).

So I have a little question: What could be a clean way, to make a kernel
option to disable prefetch for VIA (use something like 'ide1=noprefetch'?)
Any idea?

Sincerely
    Henryk Paluch, paluch@kmlinux.fjfi.cvut.cz


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
