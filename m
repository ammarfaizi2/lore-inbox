Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWHRIwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWHRIwK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWHRIwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:52:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33494
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751270AbWHRIwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:52:08 -0400
Date: Fri, 18 Aug 2006 01:51:23 -0700 (PDT)
Message-Id: <20060818.015123.104036098.davem@davemloft.net>
To: ak@suse.de
Cc: clameter@sgi.com, hch@infradead.org, johnpol@2ka.mipt.ru, arnd@arndb.de,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608181129.15075.ak@suse.de>
References: <20060816142557.acccdfcf.ak@suse.de>
	<Pine.LNX.4.64.0608171920220.28680@schroedinger.engr.sgi.com>
	<200608181129.15075.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Fri, 18 Aug 2006 11:29:14 +0200

> So ideal would be something dynamic to turn on/off io placement, maybe based 
> on node_distance() again, with the threshold tweakable per architecture?

We have this ugly 'hashdist' thing, let's remove the __initdata tag
on it, give it a useful name, and let architectures set it as
they deem appropriate.
