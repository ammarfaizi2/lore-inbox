Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270654AbTGNNID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTGNNHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:07:55 -0400
Received: from exzh001.alcatel.ch ([212.243.156.171]:1297 "HELO
	exzh001.alcatel.ch") by vger.kernel.org with SMTP id S270647AbTGNNG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:06:58 -0400
Message-ID: <33A932AD8C46D411A30F00508BACE9A3028758D8@exzh003.alcatel.ch>
From: Ritz Daniel <daniel.ritz@alcatel.ch>
To: "'ttsig@tuxyturvy.com'" <ttsig@tuxyturvy.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'MatthewK@hsius.com'" <MatthewK@hsius.com>
Subject: Re: airo_cs load error
Date: Mon, 14 Jul 2003 15:21:36 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>@@ -4838,7 +4850,7 @@
> 	readCapabilityRid(local, &cap_rid);
> 
> 	dwrq->length = sizeof(struct iw_range);
>-	memset(range, 0, sizeof(*range));
>+	memset(range, 0, sizeof(range));
> 	range->min_nwid = 0x0000;
> 	range->max_nwid = 0x0000;
> 	range->num_channels = 14;

this is wrong, sizeof(*range) is correct.

btw. the driver is broken anyway, transmit can kill keventd.
(see reports on sf.net, redhat-bugzilla, list-archive)
i'm fixing it, currently testing a 2.4 patch, 2.6-test
patch follows as soon as 2.4 is ok again.

thx
-daniel
