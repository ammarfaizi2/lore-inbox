Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSKRPhT>; Mon, 18 Nov 2002 10:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSKRPhT>; Mon, 18 Nov 2002 10:37:19 -0500
Received: from stine.vestdata.no ([195.204.68.10]:391 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id <S262580AbSKRPhS>;
	Mon, 18 Nov 2002 10:37:18 -0500
Date: Mon, 18 Nov 2002 16:44:08 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Rashmi Agrawal <rashmi.agrawal@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Failover in NFS
Message-ID: <20021118164408.B30589@vestdata.no>
References: <3DD90197.4DDEEE61@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DD90197.4DDEEE61@wipro.com>; from rashmi.agrawal@wipro.com on Mon, Nov 18, 2002 at 08:34:55PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 08:34:55PM +0530, Rashmi Agrawal wrote:
> 1. I have a 4 node cluster and nfsv3 in all the nodes of cluster with
> server running in one
> of the 2 nodesconnected to shared storage and 2 other nodes are acting
> as clients.
> 2. If nfs server node crashes, I need to failover to another node
> wherein I need to have access
> to the lock state of the previous server and I need to tell the clients
> that the IP address of the
> nfs server node has changed. IS IT POSSIBLE or what can be done to
> implement it?

No, you need to move the IP-address from the old nfs-server to the new
one. Then to the clients it will look like a regular reboot. (Check out
heartbeat, at http://www.linux-ha.org/)

You need to make sure that NFS is using the shared ip (the one you move
around) rather than the fixed ip. (I assume you will have a fixed ip on
each host in addition to the one you move around). Also, you need to put
/var/lib/nfs on shared stoarage. See the archive for more details.



-- 
Ragnar Kjørstad
Big Storage
