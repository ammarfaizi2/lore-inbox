Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTKYVUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 16:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTKYVUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 16:20:49 -0500
Received: from dp.samba.org ([66.70.73.150]:12695 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263228AbTKYVUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 16:20:48 -0500
Date: Wed, 26 Nov 2003 08:16:11 +1100
From: Anton Blanchard <anton@samba.org>
To: Jack Steiner <steiner@sgi.com>
Cc: Jes Sorensen <jes@trained-monkey.org>, Alexander Viro <viro@math.psu.edu>,
       Andrew Morton <akpm@osdl.org>,
       "William Lee Irwin, III" <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031125211611.GE26811@krispykreme>
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125204814.GA19397@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125204814.GA19397@sgi.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Some architectures (IA64, for example) dont have severe limitations on
> usage of vmalloc space. Would it make sense to use vmalloc on these
> architectures. Even if the max size of the structures being allocated
> is limited to an acceptible size, it still concentrates the memory on
> a single node. 

The kernel region on many architectures is mapped with large pages, we
would lose that by going to vmalloc.

Anton
