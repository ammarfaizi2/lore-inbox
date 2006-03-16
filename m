Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWCPD64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWCPD64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWCPD64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:58:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14229 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932362AbWCPD6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:58:55 -0500
Date: Wed, 15 Mar 2006 19:58:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1142477579.6994.124.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603151957230.3618@g5.osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com> <1142477579.6994.124.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Mar 2006, Bryan O'Sullivan wrote:
> 
> This is what it looks like when I always call get_page in my nopage
> handler (after checking that the pfn is valid and pfn_to_page hasn't
> given me junk).
> 
> Bad page state at free_hot_cold_page (in process 'mpi_hello', page ffff810002098af8)
> flags:0x0100000000000404 mapping:0000000000000000 mapcount:0 count:0 (Not tainted)
> Backtrace:

You shouldn't use PG_reserved on regular pages that you do page counting 
on.

			Linus
