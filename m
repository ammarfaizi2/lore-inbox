Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUIJTlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUIJTlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUIJTlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:41:50 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:51963 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267851AbUIJTkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:40:07 -0400
To: Brian Somers <brian.somers@sun.com>
Cc: "David S. Miller" <davem@redhat.com>, Michael.Waychison@sun.com,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
X-Message-Flag: Warning: May contain useful information
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
	<20040826123730.375ce5d2.davem@redhat.com> <41419F82.10109@sun.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 10 Sep 2004 12:40:03 -0700
In-Reply-To: <41419F82.10109@sun.com> (Brian Somers's message of "Fri, 10
 Sep 2004 13:35:14 +0100")
Message-ID: <52r7p9dib0.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Sep 2004 19:40:03.0429 (UTC) FILETIME=[F796A150:01C4976D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Brian> The problem seems to be that autoneg is disabled on the IBM
    Brian> switches.  After disabling autoneg on the Sun shelf
    Brian> switches, I see the problem.  This patch fixes things by
    Brian> reverting to sw autoneg which defaults to a
    Brian> 1000Mbps/full-duplex link but with no flow control when it
    Brian> fails (IBM should really have autoneg enabled!) - I'd
    Brian> appreciate it if someone could test this against an IBM
    Brian> blade.

Yes, 2.6.8.1 with this patch works for me on a JS20.  There is a pause
of maybe 20 seconds when the interface is brough up (while hardware
autoneg times out?) and then the network comes up (and serial-over-lan
recovers).

Unfortunately this patch doesn't apply to the latest bk (3.9) tg3 driver.

Thanks,
  Roland
