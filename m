Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUIJKOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUIJKOr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUIJKOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:14:47 -0400
Received: from the-village.bc.nu ([81.2.110.252]:55214 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266149AbUIJKOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:14:46 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20040910071530.GB4480@taniwha.stupidest.org>
References: <20040909232532.GA13572@taniwha.stupidest.org>
	 <1094798428.2800.3.camel@laptop.fenrus.com>
	 <20040910064519.GA4232@taniwha.stupidest.org>
	 <20040910065213.GA11140@devserv.devel.redhat.com>
	 <20040910071530.GB4480@taniwha.stupidest.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094807529.17029.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 10:12:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 08:15, Chris Wedgwood wrote:
> also, why 4K and not 8K or 2K?  because it's the page size?  why not
> 4K to then on amd64 or ppc64?

It would be really really nice to get AMD64 down to 4K stacks. The
bigger sizes of stack frames may make that harder for current big 
stack users. The pain/gain ratio isn't so sweet as with x86 down to
4K.

Also the x86 one really didnt change anything. AMD64 has IRQ stacks
while x86 did not. That meant in practical terms anything using > 4K
was eventually going to go bang 

Alan

