Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUCHTQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 14:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbUCHTQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 14:16:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:39132 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261154AbUCHTQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 14:16:54 -0500
Message-Id: <200403081916.i28JGgE25794@mail.osdl.org>
Date: Mon, 8 Mar 2004 11:16:39 -0800 (PST)
From: markw@osdl.org
Subject: lvm2 performance data with linux-2.6
To: linux-lvm@redhat.com
cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've started collecting various data (including oprofile) using our
DBT-2 (OLTP) workload with lvm2 on linux 2.6.2 and 2.6.3 on ia32 and
ia64 platforms:
	http://developer.osdl.org/markw/lvm2/

So far I've only varied the stripe width with lvm, from 8 KB to 512 KB,
for PostgreSQL that is using 8 KB sized blocks with ext2.  It appears
that a stripe width of 16 KB through 128KB on the ia64 system gives the
best throughput for the DBT-2 workload on a volume that should be doing
mostly sequential writes.

I'm going to run through more tests varying the block size that
PostgreSQL uses, but I wanted to share what I had so far in case there
were other suggestions or recommendations.

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
http://developer.osdl.org/markw/
