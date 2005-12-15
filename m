Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbVLOFz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbVLOFz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbVLOFz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:55:26 -0500
Received: from waste.org ([64.81.244.121]:20421 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1161140AbVLOFzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:55:25 -0500
Date: Wed, 14 Dec 2005 21:48:01 -0800
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: sri@us.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051215054800.GU8637@waste.org>
References: <20051215033937.GC11856@waste.org> <20051214.203023.129054759.davem@davemloft.net> <20051215050250.GT8637@waste.org> <20051214.212309.127095596.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214.212309.127095596.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 09:23:09PM -0800, David S. Miller wrote:
> From: Matt Mackall <mpm@selenic.com>
> Date: Wed, 14 Dec 2005 21:02:50 -0800
> 
> > There needs to be two rules:
> > 
> > iff global memory critical flag is set
> > - allocate from the global critical receive pool on receive
> > - return packet to global pool if not destined for a socket with an
> >   attached send mempool
> 
> This shuts off a router and/or firewall just because iSCSI or NFS peed
> in it's pants.  Not really acceptable.

That'll happen now anyway.

> > I think this will provide the desired behavior
> 
> It's not desirable.
> 
> What if iSCSI is protected by IPSEC, and the key management daemon has
> to process a security assosciation expiration and negotiate a new one
> in order for iSCSI to further communicate with it's peer when this
> memory shortage occurs?  It needs to send packets back and forth with
> the remove key management daemon in order to do this, but since you
> cut it off with this critical receive pool, the negotiation will never
> succeed.

Ok, encapsulation completely ruins the idea.

-- 
Mathematics is the supreme nostalgia of our time.
