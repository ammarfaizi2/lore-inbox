Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVCNKW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVCNKW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVCNKW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:22:28 -0500
Received: from rev.193.226.232.162.euroweb.hu ([193.226.232.162]:53639 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262100AbVCNKWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:22:25 -0500
To: mrmacman_g4@mac.com
CC: yjf@stanford.edu, linux-kernel@vger.kernel.org,
       fuse-devel@lists.sourceforge.net, mc@cs.stanford.edu
In-reply-to: <0EFE5EBF-93C7-11D9-A59F-000393ACC76E@mac.com> (message from Kyle
	Moffett on Sun, 13 Mar 2005 08:51:54 -0500)
Subject: Re: [MC] [CHECKER] Need help on mmap on FUSE (linux user-land file system)
References: <Pine.GSO.4.44.0503122327090.7685-100000@elaine24.Stanford.EDU> <0EFE5EBF-93C7-11D9-A59F-000393ACC76E@mac.com>
Message-Id: <E1DAmi5-0001OI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 14 Mar 2005 11:22:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Forget to mention, we are checking linux 2.6.  It appears to us
> > that mmap doesnt' work for FUSE in linux 2.6.
> 
> IIRC, the reason mmap doesn't work on FUSE is because when it
> dirties pages they cannot be flushed reliably, because writing them
> out involves calling a userspace process which may allocate RAM,
> etc.

Yes.  To be precise this only affects writable shared mmap(), which is
not used by the great majority of applications.  Any other kind of
memory mapping should work OK.

Thanks,
Miklos
