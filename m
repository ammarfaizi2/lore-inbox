Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTEWJiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTEWJiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:38:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9444 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263985AbTEWJiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:38:17 -0400
Date: Fri, 23 May 2003 02:49:22 -0700 (PDT)
Message-Id: <20030523.024922.118612798.davem@redhat.com>
To: akpm@digeo.com
Cc: rmk@arm.linux.org.uk, LW@KARO-electronics.de, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030523021204.4e3a4954.akpm@digeo.com>
References: <20030522151156.C12171@flint.arm.linux.org.uk>
	<1053676924.30675.2.camel@rth.ninka.net>
	<20030523021204.4e3a4954.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Fri, 23 May 2003 02:12:04 -0700
   
   install_page() is prefaulting pages into pagetables, so perhaps it should
   have an update_mmu_cache()?

I agree.  Someone should take a close look at the do_file_page()
code paths to make sure that's still kosher after such a change.
