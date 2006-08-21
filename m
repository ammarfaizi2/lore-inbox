Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWHUXhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWHUXhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWHUXhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:37:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1744
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751351AbWHUXhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:37:46 -0400
Date: Mon, 21 Aug 2006 16:38:01 -0700 (PDT)
Message-Id: <20060821.163801.15260979.davem@davemloft.net>
To: hadi@cyberus.ca
Cc: vda.linux@googlemail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 800+ byte inlines in include/net/pkt_act.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <1156163160.5126.47.camel@jzny2>
References: <200608201933.10293.vda.linux@googlemail.com>
	<1156163160.5126.47.camel@jzny2>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: jamal <hadi@cyberus.ca>
Date: Mon, 21 Aug 2006 08:26:00 -0400

> As per last discussion, either Patrick McHardy or myself are going
> to work on it - at some point. Please be patient. The other
> alternative is: you fix it and send patches.

I'm working on it right now.  This code is really gross and needs
to be fixed immediately.

What I'll do is define a "struct tcf_common" and have the generic
interfaces take that as well as a "struct tcf_hashinfo *" parameter to
deal with the individual hash tables.

We define all of this templated stuff then don't even use it in
act_police.c, we just duplicate everything!

Absolutely unbelievable.
