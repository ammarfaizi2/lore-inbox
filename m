Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTFBHsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 03:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTFBHsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 03:48:38 -0400
Received: from holomorphy.com ([66.224.33.161]:7581 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262015AbTFBHsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 03:48:37 -0400
Date: Mon, 2 Jun 2003 01:02:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: pgcl-2.5.70-bk6-1
Message-ID: <20030602080201.GC20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(1) fix incorrect virtual address calculation in kmap_atomic()
(2) more compilefixes for arch/i386/mm/highmem.c
(3) checking for alignment of kmap() and kmap_atomic() virtualspace
        in arch/i386/mm/init.c
(4) rework fixmap enums yet again so kmap() and kmap_atomic() areas
        actually come out properly aligned
(5) change FIXADDR_TOP to -PAGE_SIZE so the offset calculation isn't
        as easy to screw up
(6) fix mismerge of pgd_ctor() bits that installed garbage pmd's on
        CONFIG_HIGHMEM64G

Also available vs. pgcl-2.5.70-bk5-2 as pgcl-2.5.70-bk5-3.

This appears to boot and run on CONFIG_HIGHMEM64G, but I've had reports
of some sysenter bug. If I could get them reproduced with this release
so I can look further into them, I'd be much obliged. Testers running
with CONFIG_HIGHMEM64G, please update to this release.

As usual, available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/


-- wli
