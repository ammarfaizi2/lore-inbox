Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUBQVrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUBQVoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:44:54 -0500
Received: from ns.suse.de ([195.135.220.2]:14815 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266665AbUBQVnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:43:51 -0500
Date: Wed, 18 Feb 2004 22:34:15 +0100
From: Andi Kleen <ak@suse.de>
To: Jim Paradis <jparadis@redhat.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix fencepost error in x86_64 IOMMU (2.4)
Message-Id: <20040218223415.4db195e6.ak@suse.de>
In-Reply-To: <40328446.5030805@redhat.com>
References: <40328446.5030805@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 16:14:46 -0500
Jim Paradis <jparadis@redhat.com> wrote:

> There's a fencepost error in the GART IOMMU handling on x86_64
> in the unmap path.  When testing to see if the bus address is
> within the IOMMU window and needs to be unmapped, the start of
> the first page *beyond* the window also passes the test.  This
> can cause the first doubleword of the next page beyond the gatt
> table to be smashed to zero, with unpredictable results depending
> on what that page is used for.
> 
> Patch attached for 2.4.  The same problem also exists in 2.6,
> for which I'll send a separate patch.

Thanks. I will add it to my tree.

-Andi
