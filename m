Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTEZWcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTEZW0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:26:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12430 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262341AbTEZWXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:23:02 -0400
Date: Mon, 26 May 2003 15:35:30 -0700 (PDT)
Message-Id: <20030526.153530.71119050.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: akpm@digeo.com, hugh@veritas.com, LW@KARO-electronics.de,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030526095551.C4417@flint.arm.linux.org.uk>
References: <20030523193458.B4584@flint.arm.linux.org.uk>
	<1053919171.14018.2.camel@rth.ninka.net>
	<20030526095551.C4417@flint.arm.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Mon, 26 May 2003 09:55:51 +0100

   Ok, so the flush_dcache_page() interface looses this; the original
   placement of the flush_page_to_ram() ensured that data written by
   device drivers was visible to user space.

That's possible, but see my response to Roman's posting for how
this can be easily fixed using current interfaces yet retaining
identical or even potentially better performance.
