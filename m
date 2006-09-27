Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965383AbWI0G3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965383AbWI0G3D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965384AbWI0G3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:29:01 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4011
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965383AbWI0G3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:29:01 -0400
Date: Tue, 26 Sep 2006 23:28:59 -0700 (PDT)
Message-Id: <20060926.232859.30185882.davem@davemloft.net>
To: snakebyte@gmx.de
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: [Patch] Possible dereference in net/core/rtnetlink.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <1159267851.5558.2.camel@alice>
References: <1159267851.5558.2.camel@alice>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>
Date: Tue, 26 Sep 2006 12:50:51 +0200

> another possible dereference spotted by coverity (#cid 1390).
> if the nlmsg_parse() call fails, we goto errout, where we call
> dev_put(), with dev still initialized to NULL.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

Applied, thanks Eric.
