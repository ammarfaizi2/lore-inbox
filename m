Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129488AbQKJHtQ>; Fri, 10 Nov 2000 02:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbQKJHtG>; Fri, 10 Nov 2000 02:49:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21890 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129488AbQKJHtA>;
	Fri, 10 Nov 2000 02:49:00 -0500
Date: Thu, 9 Nov 2000 23:34:26 -0800
Message-Id: <200011100734.XAA26767@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: aprasad@in.ibm.com
CC: bsuparna@in.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <CA256993.0026C8BD.00@d73mta05.au.ibm.com> (aprasad@in.ibm.com)
Subject: Re: Oddness in i_shared_lock and page_table_lock nesting
	 hierarchies ?
In-Reply-To: <CA256993.0026C8BD.00@d73mta05.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: aprasad@in.ibm.com
   Date: 	Fri, 10 Nov 2000 12:25:24 +0530

   this link might be useful
   http://mail.nl.linux.org/linux-mm/2000-07/msg00038.html

This talks about a completely different bug.

We are talking here about inconsistant ordering of lock acquisition
when both mapping->i_shared_lock and mm->page_table_lock must be
held simultaneously.

The thread you quoted merely mentions the issue we have mm->rss
modifications are not always protected properly by the
page_table_lock.

There were no previous public discussions about the
i_shared_lock/page_table_lock deadlock problems.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
