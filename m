Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422702AbVLOMdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422702AbVLOMdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbVLOMdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:33:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:23528 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965199AbVLOMdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:33:38 -0500
Date: Thu, 15 Dec 2005 13:33:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christoph Hellwig <hch@infradead.org>
cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: [PATCH 1/3] m68k: compile fix - hardirq checks were in wrong
 place
In-Reply-To: <20051215122252.GA23407@infradead.org>
Message-ID: <Pine.LNX.4.61.0512151329260.1609@scrub.home>
References: <20051215085402.GT27946@ftp.linux.org.uk>
 <Pine.LNX.4.61.0512151252110.1605@scrub.home> <20051215122252.GA23407@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Dec 2005, Christoph Hellwig wrote:

> > You separate the definition from the check, now you push the 
> > responsibility to get the order right to the header users.
> > Sorry, but I prefer to fix the header dependencies than scatter things 
> > which belong together over multiple files.
> 
> For 2.6.16 I'll submit a patch to merge asm/irq.h and asm/hardirq.h.

This will likely break m68k header dependencies.

> Until then this is the much better fix because it doesn't require
> pointless include reordering all over the tree.

In this case I would prefer to leave it as is, as it conflicts with m68k 
tree and I would prefer to fix the mess only once.

bye, Roman
