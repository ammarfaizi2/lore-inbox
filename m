Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbUCPDSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 22:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUCPDSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 22:18:25 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:25492 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262864AbUCPDSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 22:18:22 -0500
Date: Tue, 16 Mar 2004 12:20:57 +0900 (JST)
Message-Id: <20040316.122057.00477633.taka@valinux.co.jp>
To: ak@suse.de
Cc: n-yoshida@pst.fujitsu.com, raybry@sgi.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: Hugetlbpages in very large memory machines.......
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040316.113209.63031370.taka@valinux.co.jp>
References: <JP20040316093003.3103921@pst.fujitsu.com>
	<20040316015401.GF9931@wotan.suse.de>
	<20040316.113209.63031370.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Yes, you are true.
> In the fault handler, we should use find_lock_page() instead of
> find_get_page() to find a hugepage associated with the fault address.

Sorry, locking page is not needed.

> After that pte_none(*pte) should be called again to check whether 
> some races has happened.

While checking, mm->page_table_lock have to be locked.

