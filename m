Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUD3QCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUD3QCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUD3QA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:00:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:60328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265076AbUD3P75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:59:57 -0400
Date: Fri, 30 Apr 2004 08:59:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       Paul Jackson <pj@sgi.com>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040430085954.U21045@build.pdx.osdl.net>
References: <20040430071750.A8515@infradead.org> <Pine.LNX.4.44.0404300853230.6976-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0404300853230.6976-100000@chimarrao.boston.redhat.com>; from riel@redhat.com on Fri, Apr 30, 2004 at 08:54:08AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel (riel@redhat.com) wrote:
> On Fri, 30 Apr 2004, Christoph Hellwig wrote:
> 
> > Still doesn't make a lot of sense.  CKRM is a huge cludgy beast poking
> > everywhere while PAGG is a really small layer to allow kernel modules
> > keeping per-process state.  If CKRM gets merged at all (and the current
> > looks far to horrible and the gains are rather unclear) it should layer
> > ontop of something like PAGG for the functionality covered by it.
> 
> What was the last time you looked at the CKRM source?
> 
> Sure it's a bit bigger than PAGG, but that's also because
> it includes the functionality to change the group a process
> belongs to and other things that don't seem to be included
> in the PAGG patch.

I looked briefly at one of the PAGG modules called job.  It contains the
grouping functionalities.  I suspect that this is something that would
be a common need for all users of a resource grouping mechanism.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
