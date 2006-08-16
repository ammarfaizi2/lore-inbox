Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWHPT2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWHPT2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWHPT2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:28:13 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:33998 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932187AbWHPT2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:28:11 -0400
Date: Wed, 16 Aug 2006 23:27:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH2 1/1] network memory allocator.
Message-ID: <20060816192726.GB19537@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <20060816075137.GA22397@2ka.mipt.ru> <20060816095712.120b3171@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060816095712.120b3171@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 16 Aug 2006 23:27:30 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 09:57:12AM -0700, Stephen Hemminger (shemminger@osdl.org) wrote:
> IMHO the network memory allocator is being a little too focused on one problem,
> rather than looking at a general enhancement.
> 
> Have you looked into something like the talloc used by Samba (and others)?
> 	http://talloc.samba.org/
> 	http://samba.org/ftp/unpacked/samba4/source/lib/talloc/talloc_guide.txt
> 
> By having a context, we could do better resource tracking and also cleanup
> would be easier on removal.

Yes, I saw it - it is slow (not that big overhead, but it definitely not
the case where we can slow things down more).
Netwrok tree allocator can be used by other users too without any
problems ,mmu-less systems will greatly benefit from it.
There is nothing which prevent other than network cases, so I see no
problems there.

-- 
	Evgeniy Polyakov
