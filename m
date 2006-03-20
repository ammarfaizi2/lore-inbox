Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWCTX3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWCTX3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWCTX3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:29:47 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48098
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964961AbWCTX3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:29:46 -0500
Date: Mon, 20 Mar 2006 15:28:38 -0800 (PST)
Message-Id: <20060320.152838.68858441.davem@davemloft.net>
To: chrisw@sous-sol.org
Cc: cxzhang@watson.ibm.com, netdev@axxeo.de, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060320213636.GT15997@sorel.sous-sol.org>
References: <200603201244.58507.netdev@axxeo.de>
	<20060320201802.GS15997@sorel.sous-sol.org>
	<20060320213636.GT15997@sorel.sous-sol.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wright <chrisw@sous-sol.org>
Date: Mon, 20 Mar 2006 13:36:36 -0800

> The point of Catherine's original patch was to make sure there's always
> a security identifier associated with AF_UNIX messages.  So receiver
> can always check it (same as having credentials even w/out sender
> control message passing them).  Now we will have garbage for sid.

I'm seriously considering backing out Catherine's AF_UNIX patch from
the net-2.6.17 tree before submitting it to Linus later today so that
none of this crap goes in right now.

It appears that this needs a lot more sorting out, so for now that's
probably the right thing to do.
