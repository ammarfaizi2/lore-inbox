Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUIJVFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUIJVFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUIJVFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:05:23 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:13833 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267880AbUIJVFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:05:07 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Brian Somers <brian.somers@sun.com>, Michael.Waychison@sun.com,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
X-Message-Flag: Warning: May contain useful information
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
	<20040826123730.375ce5d2.davem@redhat.com> <41419F82.10109@sun.com>
	<20040910135357.393f7737.davem@redhat.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 10 Sep 2004 14:05:03 -0700
In-Reply-To: <20040910135357.393f7737.davem@redhat.com> (David S. Miller's
 message of "Fri, 10 Sep 2004 13:53:57 -0700")
Message-ID: <52oekdbzsw.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Sep 2004 21:05:03.0616 (UTC) FILETIME=[D7896800:01C49779]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> The real problem was the MAC_STATUS register checking in
    David> tg3_timer() that we use to determine if we should call the
    David> PHY code.  Specifically, we were failing to test
    David> MAC_STATUS_SIGNAL_DET being set, which when trying to bring
    David> the link up means we should call tg3_setup_phy().

    David> There are still some nagging problems with certain blades
    David> even with my current code.  Brian, if you want to help I'd
    David> really appreciate it if you worked with current tg3 sources
    David> as I rewrote the 5704 hw autoneg support from scratch since
    David> it was missing a hw bug workaround and had other issues as
    David> well.

Hmm... for what it's worth, Brian's patch against 2.6.8.1 works on my
JS20 blade, and the latest BK tg3 code doesn't.

Thanks,
  Roland
