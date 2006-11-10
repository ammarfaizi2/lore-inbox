Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946203AbWKJJwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946203AbWKJJwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946236AbWKJJwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:52:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:21637 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946203AbWKJJwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:52:03 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] x86_64: Make the NUMA hash function nodemap allocation dynamic and remove NODEMAPSIZE
Date: Fri, 10 Nov 2006 10:51:52 +0100
User-Agent: KMail/1.9.5
Cc: Amul Shah <amul.shah@unisys.com>, LKML <linux-kernel@vger.kernel.org>
References: <1163029076.3553.36.camel@ustr-linux-shaha1.unisys.com> <200611100748.30889.ak@suse.de> <200611101043.14749.dada1@cosmosbay.com>
In-Reply-To: <200611101043.14749.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101051.52727.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Therefore I suggest to use a structure like that :
> 
> struct memnode {
>  	int shift;
> 	unsigned int mapsize; /* no need to use 8 bytes here */
> 	u8 *map;
> 	u8 embedded_map[64-8]; /* total size = 64 bytes */
>  } ____cacheline_aligned;
> 
> and make memnode.map point to memnode.embedded_map if mapsize <= 56 ?

That's a good idea yes.

-Andi
