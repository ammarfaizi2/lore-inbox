Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbUK3Uz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbUK3Uz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUK3Uv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:51:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:55707 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262413AbUK3Uuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:50:50 -0500
Date: Tue, 30 Nov 2004 12:50:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <michael.kerrisk@gmx.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmtcl SHM_LOCK perms
Message-ID: <20041130125045.E2357@build.pdx.osdl.net>
References: <Pine.LNX.4.44.0411291855560.23341-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0411291855560.23341-100000@localhost.localdomain>; from hugh@veritas.com on Mon, Nov 29, 2004 at 07:09:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins (hugh@veritas.com) wrote:
> Michael Kerrisk has observed that at present any process can SHM_LOCK
> any shm segment of size within process RLIMIT_MEMLOCK, despite having no
> permissions on the segment: surprising, though not obviously evil.  And
> any process can SHM_UNLOCK any shm segment, despite no permissions on it:
> that is surely wrong.

You may be neither the owner, nor the creator of a segment but have read
access to it.  In which case you could simply copy the contents of the
segment anywhere you like, which has similar effect to SHM_UNLOCK from
the point of view of paging out sensitive data.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
