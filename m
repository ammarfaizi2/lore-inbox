Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbVIBTSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVIBTSP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVIBTSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:18:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27357
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750924AbVIBTSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:18:15 -0400
Date: Fri, 02 Sep 2005 12:18:14 -0700 (PDT)
Message-Id: <20050902.121814.95712089.davem@davemloft.net>
To: viro@ZenIV.linux.org.uk
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dereference of uninitialized pointer in zatm
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050902184642.GA5155@ZenIV.linux.org.uk>
References: <20050902184642.GA5155@ZenIV.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: viro@ZenIV.linux.org.uk
Date: Fri, 2 Sep 2005 19:46:42 +0100

> Fixing breakage from [NET]: Kill skb->list - original was
> 	assign vcc
> 	do a bunch of stuff using ZATM_VCC(vcc)->pool as common subexpression
> Now we do
> 	int pos = ZATM_VCC(vcc)->pool;
> 	assign vcc
> 	do a bunch of stuff
> even though vcc is not even initialized when we enter that block...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied, thanks Al.
