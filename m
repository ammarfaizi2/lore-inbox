Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbUL0WX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUL0WX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUL0WX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 17:23:26 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:38781 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261641AbUL0WXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:23:16 -0500
Date: Tue, 28 Dec 2004 00:23:48 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: nico@cam.org
Cc: linux-kernel@vger.kernel.org
Subject: MTD needs denedency on MTD partitioning?
Message-ID: <20041227222348.GB13628@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Sorry, I had a wrong subject.

>>>>

It seems that you can disable MTD partitioning support 
but enable , e.g. NAND.
And, if you are upgrading from and older kernel without
the paritioning option, and do oldconfig and are not careful,
thats what you end up with.
But, lots of code is calling del_mtd_partitions now, so you get
unresolved del_mtd_partitions.

Its easy to work around this by enabling partitioning, but
should not the dependency be added in the relevant KConfig?

Cc me directly, I'm not on the list.
Thanks,
MST
