Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTEWIIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTEWIIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:08:20 -0400
Received: from [62.112.80.35] ([62.112.80.35]:19840 "EHLO ipc1.karo")
	by vger.kernel.org with ESMTP id S263918AbTEWIIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:08:19 -0400
Message-ID: <16077.55787.797668.329213@ipc1.karo>
Date: Fri, 23 May 2003 10:20:59 +0200
From: "Lothar Wassmann" <LW@KARO-electronics.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
In-Reply-To: <20030522151156.C12171@flint.arm.linux.org.uk>
References: <16076.50160.67366.435042@ipc1.karo>
	<20030522151156.C12171@flint.arm.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> We seem to have flush_icache_page() in install_page() - I wonder whether
> we should also have flush_dcache_page() in there as well.
> 
Maybe because install_page() isn't called in the situation I
was talking about. install_page() is called from filemap_populate()
which in turn is called from do_file_map() in handle_pte_fault(),
while I was talking about filemap_nopage() called by do_no_page() in
handle_pte_fault().

And maybe because *every* other call to flush_page_to_ram() has been
replaced by one of the new interface macros except that one in
filemap_nopage() in 'mm/filemap.c'.


Lothar Wassmann
