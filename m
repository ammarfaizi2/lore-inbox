Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132733AbRDQP5m>; Tue, 17 Apr 2001 11:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRDQP5W>; Tue, 17 Apr 2001 11:57:22 -0400
Received: from [212.115.175.146] ([212.115.175.146]:16367 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S132733AbRDQP5S>; Tue, 17 Apr 2001 11:57:18 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F11D9@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: RFC: pageable kernel-segments
Date: Tue, 17 Apr 2001 17:57:04 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone be intrested (besides me) in a kernel which can page
out certain parts of itself? The kernel should be in some kind of
vmlinux-ish (as in: uncompressed) format on disk for on-demand
re-loading of pages which are discarded.
Certain parts of drivers could get the __pageable prefix or so
(like the __init parts of drivers which get removed) for letting
the paging-code know that it can be discared if memory-pressure
demands it.
__pageable -code would then be things like (e.g.!) the code which
handles the open()/close() of a device. Most of the time a device
spends more time doing read/write/ioctl then close/open so. Also;
hopefully there's no interrupt-sensitive code in these routines.
I would think is usable (for example) for my 8MB ram laptop.
Anyone any thoughts on this?


Folkert van Heusden

[ http://www.vanheusden.com/Linux/kernel_patches.php3 ]
