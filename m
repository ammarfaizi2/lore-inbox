Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422837AbWJNTRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422837AbWJNTRj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 15:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422841AbWJNTRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 15:17:39 -0400
Received: from mail.gmx.de ([213.165.64.20]:8353 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422798AbWJNTRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 15:17:38 -0400
Content-Type: text/plain; charset="iso-8859-1"
Date: Sat, 14 Oct 2006 21:17:37 +0200
From: "Philipp Kohlbecher" <xt28@gmx.de>
Message-ID: <20061014191737.323490@gmx.net>
MIME-Version: 1.0
Subject: ra_pages and max_sectors
To: linux-kernel@vger.kernel.org
X-Authenticated: #34473864
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I was wondering why I can change the read-ahead size of my DVD drive via hdparm -a [size], but not by writing into /sys/block/hdb/queue/read_ahead_kb.

In other words: Why does queue_ra_store() [block/ll_rw_blk.c:3755] perform the following check

        if (ra_kb > (q->max_sectors >> 1))
                ra_kb = (q->max_sectors >> 1);

while blkdev_locked_ioctl() [block/ioctl.c:138] does not check this in the case that cmd == BLKRASET?

Thanks for your consideration,
- Philipp Kohlbecher


Please CC me -- I'm not on the list.
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
