Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVKSQiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKSQiz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 11:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVKSQiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 11:38:55 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:23448 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S1750708AbVKSQiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 11:38:55 -0500
Subject: [Patch 0/2] 2.6.15-rc1-mm2: disabling the pagecache for doing
	benchmarks
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <437F4F5F.6000304@aknet.ru>
References: <437F4F5F.6000304@aknet.ru>
Content-Type: text/plain
Date: Sat, 19 Nov 2005 17:38:15 +0100
Message-Id: <1132418295.11657.11.camel@home.sweethome>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For doing some benchmarks on the block-layer especially for the
I/O-Schedulers I thought it would be very useful, to turn off the
pagecache.
Therefore I implemented a global integer as bool for toggling it on and
off.
If "pagecache" is set "1" everything works as normal.
If it's set to "0" the pagecache is disabled by marking all pages as
not-uptodate to force the pagecache to load them again.

In the next step I wrote a module to get access to this bool via the
proc-fs.

It would be very nice if anybody could have a look on it.

Thanks

Dirk Gerdes
-- 



