Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVAGAaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVAGAaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVAGAaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:30:00 -0500
Received: from ozlabs.org ([203.10.76.45]:35278 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261198AbVAGA3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:29:35 -0500
Date: Fri, 7 Jan 2005 11:26:48 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] kernel/printk.c  lockless access
Message-ID: <20050107002648.GD14239@krispykreme.ozlabs.ibm.com>
References: <20050106195812.GL22274@austin.ibm.com> <20050106161241.11a8d07c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106161241.11a8d07c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> We faced the same problem in the Digeo kernel.  When the kernel oopses we
> want to grab the last kilobyte or so of the printk buffer and stash it into
> nvram.  We did this via a function which copies the data rather than
> exporting all those variables, which I think is a nicer and more
> maintainable approach:

Actually Id love to do this on ppc64 too. Its always difficult to get a
customer to remember to save away an oops report.

Anton
