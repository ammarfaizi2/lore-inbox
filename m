Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTBSVLx>; Wed, 19 Feb 2003 16:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbTBSVLx>; Wed, 19 Feb 2003 16:11:53 -0500
Received: from rth.ninka.net ([216.101.162.244]:4769 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261527AbTBSVLv>;
	Wed, 19 Feb 2003 16:11:51 -0500
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: "David S. Miller" <davem@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Ion Badulescu <ionut@badula.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030219092046.458c2876.rddunlap@osdl.org>
References: <Pine.LNX.4.44.0302191050290.29393-100000@guppy.limebrokerage.com> 
	<20030219092046.458c2876.rddunlap@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Feb 2003 14:06:12 -0800
Message-Id: <1045692372.14268.9.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 09:20, Randy.Dunlap wrote:
> Does this help with being able to printk() a <dma_addr_t>?  How?
> Always use a cast to (u64) or something else?

One should always cast to long long and use %llx.  There is no
printf format appropriate for a 'u64'.

