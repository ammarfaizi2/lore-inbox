Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWC3QMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWC3QMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWC3QMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:12:40 -0500
Received: from pat.uio.no ([129.240.10.6]:55701 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751029AbWC3QMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:12:39 -0500
Subject: Re: NFS/Kernel Problem: getfh failed: Operation not permitted
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0603301011160.18696@p34>
References: <Pine.LNX.4.64.0603300813270.18696@p34>
	 <1143728720.8074.41.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0603300929340.18696@p34>
	 <1143729766.8074.49.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0603300949000.18696@p34>
	 <1143731364.8074.53.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0603301011160.18696@p34>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 11:12:31 -0500
Message-Id: <1143735152.8093.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.679, required 12,
	autolearn=disabled, AWL 1.32, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 10:13 -0500, Justin Piszcz wrote:
> On Thu, 30 Mar 2006, Trond Myklebust wrote:
> 
> > On Thu, 2006-03-30 at 09:50 -0500, Justin Piszcz wrote:
> >> I tried an exportfs -rv and it did not help.  Any other suggestions?
> >
> > Did the output from 'exportfs -rv' match with the contents
> > of /etc/exports? If so, did it also match with the contents
> > of /var/lib/nfs/xtab and /proc/fs/nfs/exports?
> >
> > Cheers,
> >  Trond
> >
> 
> In the /etc/exports file, I have an entry that looks like this:
> /path	specific-host-001(ro,root_squash,no_sync)
> /path	specific-host-002((ro,root_squash,no_sync)
> /path	*(ro,root_squash,no_sync)
> 
> So while there are only three entries, there are:
> 
> cat /proc/fs/nfs/exports | wc -> 566
> cat /var/lib/nfs/xtab | wc -> 564

Yes, but do they match? /var/lib/nfs/xtab and /proc/fs/nfs/exports are
supposed to differ in that 'exportfs' will fill in a few default
options. The question is whether there are entries for
specific-host-001, specific-host-002,...

> Entries per file.
> 
> Is this more of a kernel or nfsutils issue at this point?

More likely to be an nfs-utils issue.

Cheers,
  Trond

