Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVLANRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVLANRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVLANRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:17:39 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:7309 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S932216AbVLANRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:17:38 -0500
Subject: [PATCH 0/4] linux-2.6-block: deactivating pagecache for benchmarks
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 14:17:31 +0100
Message-Id: <1133443051.6110.32.camel@noti>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens!

For doing benchmarks on the I/O-Schedulers, I thought it would be very
useful to disable the pagecache.

I didn't want to make it so complicated so I just mark pages as
not-uptodate, so they have to be read again. Another reason was, that I
wanted to keep the conditions as near to reality as possible.

Further I thought it would be useful, if you could turn the pagecache on
and off without rebooting the system.

I implemented a proc-fs entry "/proc/benchmark/pagecache" for this.

Probably this patch can be useful for anyone else, who wants to do  some
benchmarks on block-layer stuff.
And if not, I would appreciate if you could have a look on it.

Signed-off-by: Dirk Gerdes <mail@dirk-gerdes.de>



