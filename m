Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbTIDPfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbTIDPfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:35:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:40674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265110AbTIDPfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:35:42 -0400
Date: Thu, 4 Sep 2003 08:35:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
cc: "David S. Miller" <davem@redhat.com>, Paul Mackerras <paulus@samba.org>,
       <rmk@arm.linux.org.uk>, <hch@lst.de>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030904073650.B22822@home.com>
Message-ID: <Pine.LNX.4.44.0309040834000.580-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Matt Porter wrote:
> 
> My local tree has an ugly hack to remap_page_range() (and friends)
> so it uses a phys_addr_t and calls fixup_bigphys_addr() to allow
> use of unmodified PCI FB drivers.  I'd like to get this working
> without hacks. :)

We could make a new remap_page_range() that takes the FPN (not the 
address, the page "number") instead. But it would need a new name, not a 
flag-day "change all users".

		Linus

