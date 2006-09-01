Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWIAWhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWIAWhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWIAWhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:37:18 -0400
Received: from cs.columbia.edu ([128.59.16.20]:8651 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S1751144AbWIAWhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:37:15 -0400
Subject: Re: [PATCH 04/22][RFC] Unionfs: Common file operations
From: Shaya Potter <spotter@cs.columbia.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
In-Reply-To: <1157149200.5628.38.camel@localhost>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060901014138.GE5788@fsl.cs.sunysb.edu>
	 <1157149200.5628.38.camel@localhost>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 18:36:01 -0400
Message-Id: <1157150161.4398.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter1.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 18:20 -0400, Trond Myklebust wrote:

> Race! You cannot open an underlying NFS file by name after it has been
> looked up: you have no guarantee that it hasn't been renamed.

In a unionfs case that's not an issue.  Nothing else is allowed to use
the backing store (i.e. the nfs fs) while unionfs is using it, so there
shouldn't be a renaming issue.


-- 
VGER BF report: H 0
