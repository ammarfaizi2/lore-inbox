Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbTBTXCa>; Thu, 20 Feb 2003 18:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbTBTXCa>; Thu, 20 Feb 2003 18:02:30 -0500
Received: from mons.uio.no ([129.240.130.14]:671 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265809AbTBTXC3>;
	Thu, 20 Feb 2003 18:02:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15957.24787.735814.496471@charged.uio.no>
Date: Fri, 21 Feb 2003 00:12:19 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
In-Reply-To: <20030220230430.GX9800@gtf.org>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
	<200302191742.02275.m.c.p@wolk-project.de>
	<20030219174940.GJ14633@x30.suse.de>
	<200302201629.51374.m.c.p@wolk-project.de>
	<20030220103543.7c2d250c.akpm@digeo.com>
	<20030220215457.GV31480@x30.school.suse.de>
	<shs1y22zhm9.fsf@charged.uio.no>
	<20030220230430.GX9800@gtf.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jeff Garzik <jgarzik@pobox.com> writes:

     > One should also consider kmap_atomic...  (bcrl suggest)

The problem is that sendmsg() can sleep. kmap_atomic() isn't really
appropriate here.

Cheers,
  Trond
