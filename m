Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVLWBpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVLWBpc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 20:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVLWBpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 20:45:32 -0500
Received: from pat.uio.no ([129.240.130.16]:46038 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964968AbVLWBpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 20:45:32 -0500
Subject: Re: nfs insecure_locks / Tru64 behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ron Peterson <rpeterso@MtHolyoke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051223013933.GB22949@mtholyoke.edu>
References: <20051222133623.GE7814@mtholyoke.edu>
	 <1135293713.3685.9.camel@lade.trondhjem.org>
	 <20051223013933.GB22949@mtholyoke.edu>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 02:45:25 +0100
Message-Id: <1135302325.3685.69.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.031, required 12,
	autolearn=disabled, AWL 1.92, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 20:39 -0500, Ron Peterson wrote:
> > As for your problem accessing files in the directory
> > 
> > drwxr-x---  2 root     system  4096 Dec 22 08:22 d/
> > 
> > as an unprivileged user on group 'kmw', the solution is obvious:
> > 
> > 'chgrp kmw d'
> > 
> > or
> > 
> > chmod a+x d
> 
> That's exactly the problem.  The first obvious solution doesn't work.
> Your second solution does.  The directory must have the execute bit set
> for other, or the the file cannot be edited, no matter who owns the
> directory (unless the owner/group is nobody/nogroup).

Why wouldn't the chgrp solution work? Isn't /etc/groups on the client
and server in sync?

Cheers,
  Trond

