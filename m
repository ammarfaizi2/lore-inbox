Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVCTQQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVCTQQC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 11:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVCTQQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 11:16:02 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:30431 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261227AbVCTQPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 11:15:55 -0500
Date: Sun, 20 Mar 2005 17:15:30 +0100
From: bert hubert <ahu@ds9a.nl>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: fuse is cool and robust
Message-ID: <20050320161529.GA26365@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1DCLLi-0001Lx-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DCLLi-0001Lx-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos, Andrew,

I'm wondering what the status of Fuse is wrt to 2.6.12 or 2.6.13, especially
since the code is (now) perfectly orthogonal.

I just spent a short amount of time setting up and trying to break fusefs
and some of the filesystems based on it, and I did not succeed (in breaking
it). 

So far all userspace filesystem things have been brittle for me, often
causing kernel panics or an otherwise hosed system.

FUSE worked out of the box and furthermore survived outright killing of the
daemon, sending it SIGSTOP, doing demanding operations on a fusefs system,
and stracing of the daemon. I use it to host a subversion repository on
currently, using fsfs.

To boot, it is immediately useful as well. I've seen a bit of the
deliberations on merging Fuse or not, and I'm not skilled enough to say
anything about the kernel side of things, but from my userland perspective,
I'd like to see this merged.

Especially since I'm a C++-head, which connects very well to the userspace
part of fuse.

I do understand that a filesystem is a particularly poor API for many
things, and I'm not in favour of 'sqlfs' or 'ftpfs', but fuse IS a great
enabler. 'encfs' would be hard to do from kernel space (or at least, a lot
harder). http://arg0.net/users/vgough/encfs.html

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
