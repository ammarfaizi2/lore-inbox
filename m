Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWGUNRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWGUNRM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 09:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWGUNRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 09:17:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750705AbWGUNRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 09:17:10 -0400
Date: Fri, 21 Jul 2006 06:16:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: jpk@sgi.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
Message-Id: <20060721061642.923c7052.akpm@osdl.org>
In-Reply-To: <20060720051929.GB763333@sgi.com>
References: <20060719153155.30856.2479.sendpatchset@attica.americas.sgi.com>
	<20060720051929.GB763333@sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2006 22:19:29 -0700
Jeremy Higdon <jeremy@sgi.com> wrote:

> On Wed, Jul 19, 2006 at 10:31:55AM -0500, John Keller wrote:
> > Resend #2 changes include:
> > 
> > - use 'void __iomem *' for ioremap() return values,
> >   and handle error cases.
> > 
> > sgiioc4.c had been recently converted to using mmio ops.
> > There are still a few issues to cleanup.
> > 
> > Signed-off-by: jpk@sgi.com
> Signed-off-by: jeremy@sgi.com

hrm.  I think we're owed a couple of iounmap()s, please.  One in the
ide_dma_sgiioc4() error path and one in the takedown path.

Maybe that was one of the "few issues to cleanup", but it's a pretty simple
one.
