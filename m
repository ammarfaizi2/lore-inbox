Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTIENsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTIENsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:48:51 -0400
Received: from 69-55-72-141.ppp.netsville.net ([69.55.72.141]:38861 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262566AbTIENss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:48:48 -0400
Subject: Re: precise characterization of ext3 atomicity
From: Chris Mason <mason@suse.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Hans Reiser <reiser@namesys.com>, Mike Fedyk <mfedyk@matchmail.com>,
       Andrew Morton <akpm@osdl.org>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030904160344.E15623@schatzie.adilger.int>
References: <3F574A49.7040900@namesys.com>
	 <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com>
	 <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com>
	 <20030904181540.GC13676@matchmail.com> <3F578656.60005@namesys.com>
	 <20030904132804.D15623@schatzie.adilger.int> <3F57AF79.1040702@namesys.com>
	 <20030904160344.E15623@schatzie.adilger.int>
Content-Type: text/plain
Message-Id: <1062769640.31951.209.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 05 Sep 2003 09:47:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 18:03, Andreas Dilger wrote:
> On Sep 05, 2003  01:32 +0400, Hans Reiser wrote:
> > Andreas Dilger wrote:
> > >It is possible to do the same with ext3, namely exporting journal_start()
> > >and journal_stop() (or some interface to them) to userspace so the application
> > >can start a transaction for multiple operations.  We had discussed this in
> > >the past, but decided not to do so because user applications can screw up in
> > >so many ways, and if an application uses these interfaces it is possible to
> > >deadlock the entire filesystem if the application isn't well behaved.
> >
> > That's why we confine it to a (finite #defined number) set of 
> > operations within one sys_reiser4 call.  At some point we will allow 
> > trusted user space processes to span multiple system calls (mail server 
> > applicances, database appliances, etc., might find this useful).  You 
> > might consider supporting sys_reiser4 at some point.

Please rename sys_reiser4 if you want it to be a generic use syscall ;-)

-chris


