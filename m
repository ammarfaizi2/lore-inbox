Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130142AbRB1MDF>; Wed, 28 Feb 2001 07:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbRB1MCz>; Wed, 28 Feb 2001 07:02:55 -0500
Received: from pat.uio.no ([129.240.130.16]:32392 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S130142AbRB1MCv>;
	Wed, 28 Feb 2001 07:02:51 -0500
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: David Fries <dfries@umr.edu>, linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Stale NFS handles on 2.4.2
In-Reply-To: <20010214002750.B11906@unthought.net>
	<20010224141855.B12988@d-131-151-189-65.dynamic.umr.edu>
	<15000.39826.947692.141119@notabene.cse.unsw.edu.au>
	<20010224235342.D483@d-131-151-189-65.dynamic.umr.edu>
	<15000.53110.664338.230709@notabene.cse.unsw.edu.au>
	<20010225131013.E483@d-131-151-189-65.dynamic.umr.edu>
	<15004.16978.439300.108625@notabene.cse.unsw.edu.au>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 28 Feb 2001 13:02:31 +0100
In-Reply-To: Neil Brown's message of "Wed, 28 Feb 2001 11:12:02 +1100 (EST)"
Message-ID: <shsd7c3817s.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Neil Brown <neilb@cse.unsw.edu.au> writes:

     > So... you can access things under /home/david, but you cannot
     > access /home/david itself?  So, supposing that "fred" were some
     > file that you happen to know is in /home/david, then

     >     ls /home/david fails with ESTALE and does not cause
     > 			       any traffic to the server and

This is normal. Once an inode gets flagged as being stale, then it
remains stale. After all it would be a bug too if a filehandle were
stale one moment, and then not the next.

The question here is therefore really why did the server tell us that
the filehandle was stale in the first place.

Cheers,
   Trond
