Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUIJVqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUIJVqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUIJVqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:46:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29151 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267934AbUIJVqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:46:36 -0400
Date: Fri, 10 Sep 2004 14:45:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: Roland Dreier <roland@topspin.com>
Cc: brian.somers@sun.com, Michael.Waychison@sun.com,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040910144552.0f86b73b.davem@redhat.com>
In-Reply-To: <52oekdbzsw.fsf@topspin.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com>
	<412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com>
	<412DC055.4070401@sun.com>
	<20040826123730.375ce5d2.davem@redhat.com>
	<41419F82.10109@sun.com>
	<20040910135357.393f7737.davem@redhat.com>
	<52oekdbzsw.fsf@topspin.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 14:05:03 -0700
Roland Dreier <roland@topspin.com> wrote:

>     David> The real problem was the MAC_STATUS register checking in
>     David> tg3_timer() that we use to determine if we should call the
>     David> PHY code.  Specifically, we were failing to test
>     David> MAC_STATUS_SIGNAL_DET being set, which when trying to bring
>     David> the link up means we should call tg3_setup_phy().
> 
>     David> There are still some nagging problems with certain blades
>     David> even with my current code.  Brian, if you want to help I'd
>     David> really appreciate it if you worked with current tg3 sources
>     David> as I rewrote the 5704 hw autoneg support from scratch since
>     David> it was missing a hw bug workaround and had other issues as
>     David> well.
> 
> Hmm... for what it's worth, Brian's patch against 2.6.8.1 works on my
> JS20 blade, and the latest BK tg3 code doesn't.

Ok, some debugging to do. :)
