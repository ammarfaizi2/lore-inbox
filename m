Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270855AbTGNVDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270846AbTGNVBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:01:03 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:18985 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S270844AbTGNVAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:00:22 -0400
Subject: Re: airo_cs load error
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Ritz Daniel <daniel.ritz@alcatel.ch>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'MatthewK@hsius.com'" <MatthewK@hsius.com>
In-Reply-To: <33A932AD8C46D411A30F00508BACE9A3028758D8@exzh003.alcatel.ch>
References: <33A932AD8C46D411A30F00508BACE9A3028758D8@exzh003.alcatel.ch>
Content-Type: text/plain
Message-Id: <1058217065.1714.5.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 17:13:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 09:21, Ritz Daniel wrote:
> >@@ -4838,7 +4850,7 @@
> > 	readCapabilityRid(local, &cap_rid);
> > 
> > 	dwrq->length = sizeof(struct iw_range);
> >-	memset(range, 0, sizeof(*range));
> >+	memset(range, 0, sizeof(range));
> > 	range->min_nwid = 0x0000;
> > 	range->max_nwid = 0x0000;
> > 	range->num_channels = 14;
> 
> this is wrong, sizeof(*range) is correct.
> 
> btw. the driver is broken anyway, transmit can kill keventd.
> (see reports on sf.net, redhat-bugzilla, list-archive)
> i'm fixing it, currently testing a 2.4 patch, 2.6-test
> patch follows as soon as 2.4 is ok again.

Yep, I somehow sent out an incorrect diff that had some things reversed
that shouldn't have been.  I've been working on cleaner version that has
a few more fixes but have just been too swamped with other things to get
it done.  Sounds like you're working on the same thing so I'll put mine
on hold for a while.

Later,
Tom


