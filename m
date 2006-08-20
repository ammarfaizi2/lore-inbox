Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWHTTrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWHTTrm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWHTTrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:47:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17370
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751183AbWHTTrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:47:41 -0400
Date: Sun, 20 Aug 2006 12:47:51 -0700 (PDT)
Message-Id: <20060820.124751.104041574.davem@davemloft.net>
To: arjan@infradead.org
Cc: solar@openwall.com, ak@suse.de, wtarreau@hera.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
From: David Miller <davem@davemloft.net>
In-Reply-To: <1156091451.23756.51.camel@laptopd505.fenrus.org>
References: <200608201034.43588.ak@suse.de>
	<20060820161602.GA20163@openwall.com>
	<1156091451.23756.51.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Sun, 20 Aug 2006 18:30:51 +0200

> this reasoning goes out the window with kernel preemption of course ;)

Yes and even though this thing is for 2.4.x, it just shows
that this is a hack and we shouldn't eat two userspace
accesses for a hack.

Instead fix the setsockopt() implementations that aren't
checking the optlen parameter correctly.
