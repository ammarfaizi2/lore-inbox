Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWHMSZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWHMSZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 14:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWHMSZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 14:25:16 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:48914 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750718AbWHMSZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 14:25:15 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>,
       netdev@vger.kernel.org
Subject: Re: [2.6.17.8] NFS stall / BUG in UDP fragment processing / SKB trimming
References: <87zme9fy94.fsf@hades.wkstn.nix>
	<20060813125910.GA18463@gondor.apana.org.au>
From: Nix <nix@esperi.org.uk>
X-Emacs: (setq software-quality (/ 1 number-of-authors))
Date: Sun, 13 Aug 2006 19:24:33 +0100
In-Reply-To: <20060813125910.GA18463@gondor.apana.org.au> (Herbert Xu's message of "Sun, 13 Aug 2006 22:59:11 +1000")
Message-ID: <87wt9cqyse.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006, Herbert Xu suggested tentatively:
> Oops, I missed this code path when I disallowed skb_trim from operating
> on a paged skb.  This patch should fix the problem.
> 
> Greg, we need this for 2.6.17 stable as well if Dave is OK with it.
> 
> [INET]: Use pskb_trim_unique when trimming paged unique skbs
[...]

Yes, that seems to have fixed it. Thank you!

-- 
`We're sysadmins. We deal with the inconceivable so often I can clearly 
 see the need to define levels of inconceivability.' --- Rik Steenwinkel
