Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbTIDROg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbTIDRNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:13:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4272 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265188AbTIDRNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:13:24 -0400
Date: Thu, 4 Sep 2003 10:03:43 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: geert@linux-m68k.org, paulus@samba.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904100343.32c99406.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0309040958420.6676-100000@home.osdl.org>
References: <20030904094328.59961739.davem@redhat.com>
	<Pine.LNX.4.44.0309040958420.6676-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 10:06:48 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> On Thu, 4 Sep 2003, David S. Miller wrote:
> > 
> > > So clearly ioremap() has to work for other buses too.
> > 
> > What if they are like I/O ports on x86 and require special
> > instructions to access?
> 
> ioremap() is very easy to explain to a mathematician: its "domain" is
> _exactly_ that which is in the "iomem_resource" tree. The "range" is a
> virtual address.

A virtual address?  On x86 IOMEM resources are stored as physical
addresses and ioremap() returns a virtual mapping of that physical
address.

Maybe our wires are just crossed.
