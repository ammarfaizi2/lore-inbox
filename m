Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUEWJuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUEWJuP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUEWJuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:50:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23307 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261752AbUEWJuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:50:11 -0400
Date: Sun, 23 May 2004 11:48:53 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
Message-ID: <20040523094853.GA16448@alpha.home.local>
References: <20040522234059.GA3735@infradead.org> <1085296400.2781.2.camel@laptop.fenrus.com> <20040523084415.GB16071@alpha.home.local> <20040523091356.GD5889@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523091356.GD5889@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 11:13:56AM +0200, Arjan van de Ven wrote:
> On Sun, May 23, 2004 at 10:44:15AM +0200, Willy Tarreau wrote:
> > Hi Arjan,
> > 
> > On Sun, May 23, 2004 at 09:13:20AM +0200, Arjan van de Ven wrote:
> > > on first look it seems to be missing a bunch of get_user() calls and
> > > does direct access instead....
> > 
> > It was intentional for speed purpose. The areas are checked once with
> > verify_area() when we need to access memory, then data is copied directly
> > from/to memory. I don't think there's any risk, but I can be wrong.
> 
> it's an oopsable offence; nothing is making sure the memory is actually
> present for example.

You mean like when a user does a malloc() and the memory is not physically
allocated because not used yet ? or even in case memory has been swapped
out ? I believe I begin to understand, but the corner case is not really
clear to me. It yet seems strange to me that the user can reference memory
areas that the kernel cannot access. I'm certainly mistaken somewhere, but
I don't know where. In fact, if you could give me a simple example which
puts my original code at fault, it would really help me. Then I'll change
the code as suggested by Andrew but at least I would understand what I do.

Thanks in advance.
Willy

