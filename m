Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269783AbUICU33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269783AbUICU33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269782AbUICU32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:29:28 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:24663 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S269767AbUICU3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:29:19 -0400
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Paul Larson <plars@linuxtestproject.org>,
       "David S. Miller" <davem@davemloft.net>,
       Brian Somers <Brian.Somers@Sun.COM>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
X-Message-Flag: Warning: May contain useful information
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
	<4138C3DD.1060005@sun.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 03 Sep 2004 13:18:11 -0700
In-Reply-To: <4138C3DD.1060005@sun.com> (Mike Waychison's message of "Fri,
 03 Sep 2004 15:19:57 -0400")
Message-ID: <52acw7rtrw.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Sep 2004 20:18:11.0357 (UTC) FILETIME=[22687CD0:01C491F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Paul> I tried this patch alone on top of 2.6.9-rc1 and tg3 is
    Paul> still broken for me on JS20 blades.  Was there another patch
    Paul> I should have applied in conjunction with this?

Me too -- I copied the latest BK tg3.c/tg3.h to my 2.6.8.1 tree and
tried it on my JS20 and it didn't work.  Unfortunately the JS20 blade
only has serial-over-LAN for the console, which also dies as soon as
tg3 gets loaded, so I'm not sure exactly what happened.

    Mike> Is this with or without autonegotiation enabled on the switch?

I believe that the internal ports of the BladeCenter switch are always
locked to full-duplex gigabit operation (ie no autoneg).  In the
switch management GUI, there is a pull-down menu for setting
Speed/Duplex of external ports, but for internal ports to the blades,
there is no menu (just a hard-coded display of 1000/Full).

Thanks,
  Roland
