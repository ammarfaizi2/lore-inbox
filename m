Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTJOXWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTJOXWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:22:14 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:18697 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262563AbTJOXWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:22:11 -0400
Date: Thu, 16 Oct 2003 00:22:05 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-fbdev-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>,
       Chris Heath <chris@heathens.co.nz>
Subject: Re: FBDEV 2.6.0-test7 updates.
In-Reply-To: <20031015161705.221a579b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0310160018100.13660-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> > Several fixes. The patch is against 2.6.0-test7
> > 
> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> Cool.  I've had the below fix floating about for a while.  Is it still
> relevant?

Its not the proper fix. The latest patch fixes this problem. I had to save 
the area under the cursor and redraw that area when the cursor was 
disabled or moved. The cursor api is set in stone from the drivers 
prespective. So it will be easy for driver writers to make use of 
a hardware cursor. The old cursor code was written around a software 
emulated cursor. The new code favors hardware cursors with software 
emulation the exception.

