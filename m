Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVCMUmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVCMUmv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVCMUmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:42:51 -0500
Received: from pat.uio.no ([129.240.130.16]:2225 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261448AbVCMUmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:42:49 -0500
Subject: Re: [CHECKER] inconsistent NFS stat cache (NFS on ext3, 2.6.11)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Junfeng Yang <yjf@stanford.edu>, nfs@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU
In-Reply-To: <20050313200412.GA21521@nevyn.them.org>
References: <Pine.GSO.4.44.0503120335160.12085-100000@elaine24.Stanford.EDU>
	 <1110690267.24123.7.camel@lade.trondhjem.org>
	 <20050313200412.GA21521@nevyn.them.org>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 15:42:29 -0500
Message-Id: <1110746550.23876.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 13.03.2005 Klokka 15:04 (-0500) skreiv Daniel Jacobowitz:

> I can't find any documentation about this, but it seems like the same
> problem that has been causing me headaches lately; when I replace glibc
> from the server side of an nfsroot, the client has a couple of
> variously wrong reads before it sees the new files.  If it breaks NFS
> so badly, why is it the default for the Linux NFS server?

No, that's a very different issue: you are violating the NFS cache
consistency rules if you are changing a file that is being held open by
other machines.
The correct way to do the above is to use GNU install with the '-b'
option: that will rename the version of glibc that is in use, and then
install the new glibc in a different inode.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

