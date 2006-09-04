Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWIDOya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWIDOya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWIDOya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:54:30 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:16818 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751451AbWIDOy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:54:29 -0400
Date: Mon, 4 Sep 2006 16:50:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 08/16] GFS2: Resource group code
In-Reply-To: <1157031351.3384.799.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041637500.17279@yvahk01.tjqt.qr>
References: <1157031351.3384.799.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+#define BFITNOENT 0xFFFFFFFF

See previous mail, (uint32_t)-1 / (uint32_t)~0 or leave it.

>+static inline int rgrp_contains_block(struct gfs2_rindex *ri, uint64_t block)
>+{
>+	uint64_t first = ri->ri_data0;
>+	uint64_t last = first + ri->ri_data;
>+	return !!(first <= block && block < last);
>+}

No need for the !!, the expression !! is operating on is already a boolean.
IOW,

	return first <= block && block < last;


>+/**
>+ * gfs2_alloc_put - throw away the struct gfs2_alloc for an inode
>+ * @ip: the inode
>+ *
>+ */
>+
>+void gfs2_alloc_put(struct gfs2_inode *ip)
>+{
>+	return;
>+}

Missing some code? Code that comes later?


Jan Engelhardt
-- 
