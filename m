Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWIEKG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWIEKG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWIEKG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:06:28 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:29363 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750997AbWIEKG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:06:27 -0400
Date: Tue, 5 Sep 2006 12:02:00 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 12/16] GFS2: Mounting & sysfs interface
In-Reply-To: <1157031578.3384.807.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609051156330.32409@yvahk01.tjqt.qr>
References: <1157031578.3384.807.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>+static struct kset gfs2_kset = {
>+	.subsys = &fs_subsys,
>+	.kobj   = {.name = "gfs2",},

I think

	.kobj   = {.name = "gfs2"},

would suffice style-wise (, only looks good on multiple lines IMO, but anyone
who wants to object may scream out loud *now*).

>+	.ktype  = &gfs2_ktype,
>+};


>+/* one oddball doesn't fit the macro mold */
>+static ssize_t noatime_show(struct gfs2_sbd *sdp, char *buf)
>+{
>+	return sprintf(buf, "%d\n", !!test_bit(SDF_NOATIME, &sdp->sd_flags));
>+}

Hm, what does test_bit return, if not 0 or 1? (Questioning the
possible redundancy of !!)



Jan Engelhardt
-- 
