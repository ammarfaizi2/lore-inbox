Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTKXVhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTKXVhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:37:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47621 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261575AbTKXVhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:37:38 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test9-mm4
Date: 24 Nov 2003 21:26:43 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bptt2j$v5h$1@gatekeeper.tmr.com>
References: <20031118225120.1d213db2.akpm@osdl.org> <3FBDCCDF.9010304@gmx.de> <20031121130810.GQ22764@holomorphy.com>
X-Trace: gatekeeper.tmr.com 1069709203 31921 192.168.12.62 (24 Nov 2003 21:26:43 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031121130810.GQ22764@holomorphy.com>,
William Lee Irwin III  <wli@holomorphy.com> wrote:

| diff -prauN mm4-2.6.0-test9-1/mm/memory.c mm4-2.6.0-test9-default-2/mm/memory.c
| --- mm4-2.6.0-test9-1/mm/memory.c	2003-11-19 00:07:15.000000000 -0800
| +++ mm4-2.6.0-test9-default-2/mm/memory.c	2003-11-19 18:08:49.000000000 -0800
| @@ -1424,7 +1424,7 @@ do_no_page(struct mm_struct *mm, struct 
|  	pte_t entry;
|  	struct pte_chain *pte_chain;
|  	int sequence = 0;
| -	int ret;
| +	int ret = VM_FAULT_MINOR;
|  
|  	if (!vma->vm_ops || !vma->vm_ops->nopage)
|  		return do_anonymous_page(mm, vma, page_table,

Good show, I would have expected the compiler to whine if there was a
path out of a proc which returned an unset value. Or did it, and I
didn't try w/o the patch to see it?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
