Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753891AbWKFWia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbWKFWia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbWKFWia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:38:30 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:154
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753891AbWKFWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:38:30 -0500
Date: Mon, 06 Nov 2006 14:38:31 -0800 (PST)
Message-Id: <20061106.143831.88477819.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: acme@mandriva.com
Subject: Re: + net-uninline-xfrm_selector_match.patch added to -mm tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <200611031934.kA3JYCjF030732@shell0.pdx.osdl.net>
References: <200611031934.kA3JYCjF030732@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: akpm@osdl.org
Date: Fri, 03 Nov 2006 11:34:12 -0800

> Subject: net: uninline xfrm_selector_match()
> From: Andrew Morton <akpm@osdl.org>
> 
> Six callsites, huge.
> 
> Cc: Arnaldo Carvalho de Melo <acme@mandriva.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

You can't implement it like this :-)

xfrm_user.c is a bad place to put the uninlined version because
this can be built modular, whereas the callsites in places such
as xfrm_policy.c will be built statically into the kernel.
