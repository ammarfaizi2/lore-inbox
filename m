Return-Path: <linux-kernel-owner+w=401wt.eu-S1752165AbXAARW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbXAARW4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 12:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbXAARW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 12:22:56 -0500
Received: from xenotime.net ([66.160.160.81]:45877 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750866AbXAARWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 12:22:55 -0500
Date: Mon, 1 Jan 2007 09:09:31 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
Message-Id: <20070101090931.93cc9331.rdunlap@xenotime.net>
In-Reply-To: <20070101084231.GA9863@linux-sh.org>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
	<200612302149.35752.vda.linux@googlemail.com>
	<Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
	<1167518748.20929.578.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0612301750550.16519@localhost.localdomain>
	<20061231183949.GA8323@linux-sh.org>
	<Pine.LNX.4.64.0612311355520.17978@localhost.localdomain>
	<20070101015932.GP13521@vanheusden.com>
	<20070101084231.GA9863@linux-sh.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007 17:42:31 +0900 Paul Mundt wrote:

> On Mon, Jan 01, 2007 at 02:59:32AM +0100, Folkert van Heusden wrote:
> > > > regarding alignment that don't allow clear_page() to be used
> > > > copy_page() in the memcpy() case), but it's going to need a lot of
> > 
> > Maybe these optimalisations should be in the coding style docs?
> > 
> For what purpose? CodingStyle is not about documenting usage constraints
> for every minor part of the kernel. If someone intends to use an API,
> it's up to them to figure out the semantics for doing so. Let's not
> confuse common sense with style.
> -

I agree, these aren't CodingStyle material.  They could make sense
in some other doc, either MM/VM-related or more general.

I've often wanted a somewhat introductory doc about Linux environmental
assumptions (memory model, pointers/longs, data cleared to 0,
many other items that I don't have on my fingertips).

---
~Randy
