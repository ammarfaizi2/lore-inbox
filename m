Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVAUPyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVAUPyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 10:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVAUPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 10:54:10 -0500
Received: from pat.uio.no ([129.240.130.16]:34442 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262399AbVAUPxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 10:53:36 -0500
Subject: Re: knfsd and append-only attribute:  "operation not permitted"
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Vladimir Saveliev <vs@namesys.com>
Cc: "Aaron D.Ball" <adb@bdi.com>, reiserfs-list@namesys.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1106318654.3200.38.camel@tribesman.namesys.com>
References: <8381054C-6B13-11D9-BFA6-000D933B35AA@bdi.com>
	 <1106318654.3200.38.camel@tribesman.namesys.com>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 10:53:07 -0500
Message-Id: <1106322787.30627.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.05, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 21.01.2005 Klokka 17:44 (+0300) skreiv Vladimir Saveliev:
> Hello
> 
> On Thu, 2005-01-20 at 21:45, Aaron D.Ball wrote:
> > When I use the kernel-based NFS server to export directories on 
> > ReiserFS that have the append-only attribute set, I can't access the 
> > files from the client machines at all:  for example, "ls" returns 
> > "operation not permitted".  Is this a known bug?  Is there a good 
> > workaround?
> > 
> 
> It looks like the problem is not in reiserfs, but in nfsd.
> fs/nfsd/vfs.c:nfsd_open() refuses to open append only files.

Append-only is an unsupported concept in the all existing revisions of
the NFS protocol. In fact, NFS has no support for append writes at all:
they have to be emulated by the clients.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

