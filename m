Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVCMUqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVCMUqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVCMUqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:46:52 -0500
Received: from pat.uio.no ([129.240.130.16]:27831 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261453AbVCMUqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:46:50 -0500
Subject: Re: [CHECKER] inconsistent NFS stat cache (NFS on ext3, 2.6.11)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Junfeng Yang <yjf@stanford.edu>, nfs@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU
In-Reply-To: <1110746550.23876.8.camel@lade.trondhjem.org>
References: <Pine.GSO.4.44.0503120335160.12085-100000@elaine24.Stanford.EDU>
	 <1110690267.24123.7.camel@lade.trondhjem.org>
	 <20050313200412.GA21521@nevyn.them.org>
	 <1110746550.23876.8.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 15:46:34 -0500
Message-Id: <1110746794.23876.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 13.03.2005 Klokka 15:42 (-0500) skreiv Trond Myklebust:

> No, that's a very different issue: you are violating the NFS cache
> consistency rules if you are changing a file that is being held open by
> other machines.
> The correct way to do the above is to use GNU install with the '-b'
> option: that will rename the version of glibc that is in use, and then
> install the new glibc in a different inode.

BTW: there is a more complete description of the NFS cache consistency
model in the NFS FAQ:

  http://nfs.sourceforge.net/index.cel.php#faq_a8

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

