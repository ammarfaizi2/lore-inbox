Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269060AbUJKPgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269060AbUJKPgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269113AbUJKPci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:32:38 -0400
Received: from pat.uio.no ([129.240.130.16]:16318 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S269116AbUJKPbL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:31:11 -0400
Subject: Re: [PATCH] NFS using CacheFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Martin Waitz <tali@admingilde.org>
Cc: Steve Dickson <SteveD@redhat.com>, Clemens Schwaighofer <cs@tequila.co.jp>,
       nfs@lists.sourceforge.net,
       Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041011142329.GJ4072@admingilde.org>
References: <4161B664.70109@RedHat.com> <41661950.5070508@tequila.co.jp>
	 <41667865.2000804@RedHat.com>  <20041011142329.GJ4072@admingilde.org>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1097508639.20033.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 17:30:39 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 11/10/2004 klokka 16:23, skreiv Martin Waitz:
> hi :)
> 
> On Fri, Oct 08, 2004 at 07:22:13AM -0400, Steve Dickson wrote:
> > The 'fscache' flag will be coming along with the nfs4 support, since
> > nfs4 mounting code does not have an open (unused) mounting flag....
> 
> is such a flag even neccessary?
> The way I see fscache is that its operations will be no-ops anyway if you
> haven't mounted any backing cache.

You may not want to run cachefs on *all* your NFS partitions. It will
slow you down on those partitions that have lots of cache contention.

That said, David & co.: why did you choose not to use something similar
to the Solaris syntax for cachefs? The "layered filesystem" syntax has
the advantage that it would avoid entirely the need to change the NFS
mount syntax, and would make it easier to port cachefs to cifs etc.

Cheers,
  Trond

