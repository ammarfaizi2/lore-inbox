Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbTIEFUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbTIEFUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:20:12 -0400
Received: from dp.samba.org ([66.70.73.150]:2707 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262150AbTIEFUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:20:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix 
In-reply-to: Your message of "Thu, 04 Sep 2003 18:16:09 +0100."
             <20030904171609.GA30394@mail.jlokier.co.uk> 
Date: Fri, 05 Sep 2003 13:55:56 +1000
Message-Id: <20030905052006.72B952C135@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030904171609.GA30394@mail.jlokier.co.uk> you write:
> What does PROT_SEM mean for Linux, btw?

It's a relic: some archs might need a special flag to ensure
inter-process atomic ops worked as expected.  It was never fully
implemented, with the assumption that such archs just won't be able to
use futexes, and if someone really wants to fix it, they will.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
