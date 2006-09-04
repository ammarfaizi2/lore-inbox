Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWIDRsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWIDRsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWIDRsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:48:55 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:24706 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964877AbWIDRsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:48:54 -0400
Date: Mon, 4 Sep 2006 19:44:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 10/16] GFS2: Logging and recovery
In-Reply-To: <1157031466.3384.803.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041856030.28823@yvahk01.tjqt.qr>
References: <1157031466.3384.803.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>+		a = (old_tail <= ai->ai_first);
>+		b = (ai->ai_first < new_tail);

>+	if (!(!error && dbn)) {
>+		printk(KERN_INFO "error=%d, dbn=%llu lbn=%u", error, (unsigned long long)dbn, lbn);
>+	}

error || dbn
-{}

>+#if 0
>+	unsigned int d;
>+
>+	d = log_distance(sdp, sdp->sd_log_flush_head, sdp->sd_log_head);
>+
>+	gfs2_assert_withdraw(sdp, d + 1 == sdp->sd_log_blks_reserved);
>+#endif

>+		if (lb->lb_real) {
>+			while (atomic_read(&bh->b_count) != 1)  /* Grrrr... */
>+				schedule();

Grrr? Someone stole us the b_count?

>+	unsigned int offset = sizeof(struct gfs2_log_descriptor);
>+	offset += (sizeof(__be64)-1);
>+	offset &= ~(sizeof(__be64)-1);
()


Jan Engelhardt
-- 
