Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbTCYL4v>; Tue, 25 Mar 2003 06:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262205AbTCYL4v>; Tue, 25 Mar 2003 06:56:51 -0500
Received: from holomorphy.com ([66.224.33.161]:19361 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262198AbTCYL4u>;
	Tue, 25 Mar 2003 06:56:50 -0500
Date: Tue, 25 Mar 2003 04:07:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.5.66-1
Message-ID: <20030325120742.GP1232@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(1) add a CONFIG_PAGE_CLUSTER config option for i386.
(2) add stubs for MMUPAGE_* and PAGE_MMU* for non-i386
(3) fix up a do_page_cache_readahead() call in filemap_populate()
(4) fix up other file offset calculations surrounding the filepte merge
(5) sunrpc request buffer sizing fix from zwane
(6) make do_anonymous_page() less broken for x86 (but still nonportable)

do_wp_page() and other fault handler antifragmentation heuristics are
still underway. Once they're actually working and pagetable fragmentation
is fixed, some abstraction can be filtered out for the fault handlers'
needs and cleanups begin.

I'll reiterate for those who forgot the original announcement: this
patch is a WIP and it's not in yet in a state where the faint of heart
will be prepared to run it. Send pgcl bugreports as either followups to
my announcements or directly to me to avoid confusion regardless of
what subsystem they affect or who maintains the affected code.

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/


-- wli
