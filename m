Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbTBUVWr>; Fri, 21 Feb 2003 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTBUVWq>; Fri, 21 Feb 2003 16:22:46 -0500
Received: from pat.uio.no ([129.240.130.16]:19078 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267725AbTBUVWp>;
	Fri, 21 Feb 2003 16:22:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15958.39675.751782.559671@charged.uio.no>
Date: Fri, 21 Feb 2003 22:32:43 +0100
To: Andrew Morton <akpm@digeo.com>
Cc: andrea@suse.de, m.c.p@wolk-project.de, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing
 system to a crawl]
In-Reply-To: <20030221125259.5d22a42f.akpm@digeo.com>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
	<200302191742.02275.m.c.p@wolk-project.de>
	<20030219174940.GJ14633@x30.suse.de>
	<200302201629.51374.m.c.p@wolk-project.de>
	<20030220103543.7c2d250c.akpm@digeo.com>
	<20030220215457.GV31480@x30.school.suse.de>
	<shs1y22zhm9.fsf@charged.uio.no>
	<20030221125259.5d22a42f.akpm@digeo.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@digeo.com> writes:

    >> For 2.5.x we should rather fix MSG_MORE so that it actually
    >> works instead of messing with hacks to kmap().

     > Is the fixing of MSG_MORE likely to actually happen?

We had better try. The server/knfsd has already converted to sendpage
+ MSG_MORE 8-)

That won't work for 2.4.x though, since that doesn't have support for
sendpage over UDP.

Cheers,
  Trond
