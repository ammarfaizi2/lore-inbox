Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263175AbVGaGSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263175AbVGaGSc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 02:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbVGaGSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 02:18:32 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18866
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263175AbVGaGSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 02:18:32 -0400
Date: Sat, 30 Jul 2005 23:18:29 -0700 (PDT)
Message-Id: <20050730.231829.59467939.davem@davemloft.net>
To: zaitcev@redhat.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 ub 2/3: Fold one line
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050730225145.4b99ecd0.zaitcev@redhat.com>
References: <20050730225145.4b99ecd0.zaitcev@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pete Zaitcev <zaitcev@redhat.com>
Date: Sat, 30 Jul 2005 22:51:45 -0700

> -static ssize_t ub_diag_show(struct device *dev, struct device_attribute *attr, char *page)
> +static ssize_t ub_diag_show(struct device *dev, struct device_attribute *attr,
> +    char *page)

FWIW, I am generally against this kind of thing at least
for non-static functions.

I used to love this kind of code styling, until I started trying to
often grep a tree to verify the types of arguments to some function.

With the above kind of construct, you get the first few types, but not
all of them, in your grep output.
