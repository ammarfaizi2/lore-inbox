Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVIWGOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVIWGOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 02:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVIWGOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 02:14:36 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38313
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750700AbVIWGOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 02:14:35 -0400
Date: Thu, 22 Sep 2005 23:14:34 -0700 (PDT)
Message-Id: <20050922.231434.07643075.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: clameter@engr.sgi.com
Subject: making kmalloc BUG() might not be a good idea
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm sort-of concerned about this change:

    [PATCH] __kmalloc: Generate BUG if size requested is too large.

it opens a can of worms, and stuff that used to generate
-ENOMEM kinds of failures will now BUG() the kernel.

Unless you're going to audit every user triggerable
path for proper size limiting, I think we should revert
this change.

Thanks.
