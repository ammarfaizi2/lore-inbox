Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVAMNFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVAMNFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 08:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVAMNFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 08:05:42 -0500
Received: from main.gmane.org ([80.91.229.2]:40896 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261621AbVAMNFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 08:05:05 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Trouble with 8-pixel screen fonts and 2.6 kernels (2.6.9, 2.6.10)
Date: Thu, 13 Jan 2005 18:06:42 +0500
Message-ID: <cs5rlm$ir2$1@sea.gmane.org>
References: <cs3iou$ibs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:

> (This report is on behalf of Declan Moriarty)
> 
> To reproduce the problem, install the "kbd" package, and from the first
> virtual console execute the following command:
> 
> setfont lat1-08          # or any other 8-pixel font

Forgot to say that this bug is reproducible only on non-framebuffer console.

> Then switch to the second console and see that the cursor disappeared.
> Moreover, the following escape sequences function improperly:
> 
> echo -e '\033[?Xc' where X is a digit
> 
> Even more, from the second console this command
> 
> setfont lat1-16
> 
> gives 43 screen lines with only upper halves of characters (bottoms are
> cut, and I suspect this also happens with the cursor).
> 
> Looks like a bug in the character cell height logic. Could you please fix
> it or at least point me to some overview of the relevant source files?

This bug seems to be Radeon-specific (doesn't exist on ATI Mach64). But even
on Radeons, it can't be reproduced in 2.4 kernels - so it's a kernel bug.

-- 
Alexander E. Patrakov

