Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbTIDRSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbTIDRRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:17:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:12978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265293AbTIDRRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:17:06 -0400
Date: Thu, 4 Sep 2003 10:16:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: geert@linux-m68k.org, <paulus@samba.org>, <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030904100343.32c99406.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0309041015220.6676-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, David S. Miller wrote:
> > ioremap() is very easy to explain to a mathematician: its "domain" is
> > _exactly_ that which is in the "iomem_resource" tree. The "range" is a
> > virtual address.
> 
> A virtual address?  On x86 IOMEM resources are stored as physical
> addresses and ioremap() returns a virtual mapping of that physical
> address.
> 
> Maybe our wires are just crossed.

No, I'm bad.

The "range" is not a virtual address, it's an offsettable cookie, useful
for read[bwl]() and write[bwl]() and the "memcpy_[to|from]io()" functions.

But the "domain" part was the important thing.

			Linus

