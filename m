Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274231AbRISW0T>; Wed, 19 Sep 2001 18:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274229AbRISW0C>; Wed, 19 Sep 2001 18:26:02 -0400
Received: from ns.caldera.de ([212.34.180.1]:56006 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S274227AbRISWZr>;
	Wed, 19 Sep 2001 18:25:47 -0400
Date: Thu, 20 Sep 2001 00:26:05 +0200
Message-Id: <200109192226.f8JMQ5112543@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: rfuller@nsisoftware.com ("Rob Fuller")
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com> you wrote:
> In my one contribution to this thread I wrote:
>
> "One argument for reverse mappings is distributed shared memory or
> distributed file systems and their interaction with memory mapped files.
> For example, a distributed file system may need to invalidate a specific
> page of a file that may be mapped multiple times on a node."

Please take a look at zap_inode_mappings in -ac.
Currently it only invalidates a whole mapping, but we can easily add
offset and lenght (and will probably do).

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
