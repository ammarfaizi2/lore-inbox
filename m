Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbRK0PpT>; Tue, 27 Nov 2001 10:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRK0PpK>; Tue, 27 Nov 2001 10:45:10 -0500
Received: from mons.uio.no ([129.240.130.14]:18380 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S280971AbRK0Pox>;
	Tue, 27 Nov 2001 10:44:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15363.46302.205479.958516@charged.uio.no>
Date: Tue, 27 Nov 2001 16:44:30 +0100
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Re: Fix knfsd readahead cache in 2.4.15
In-Reply-To: <20011127102348.A19330@redhat.com>
In-Reply-To: <15362.18626.303009.379772@charged.uio.no>
	<15362.53694.192797.275363@esther.cse.unsw.edu.au>
	<20011126.155347.45872112.davem@redhat.com>
	<20011126202509.J15582@redhat.com>
	<15363.39718.446155.619699@charged.uio.no>
	<20011127102348.A19330@redhat.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Benjamin LaHaise <bcrl@redhat.com> writes:

     > Sorry for not being clear, but what I was referring to is
     > making the decision about how to read ahead by what is already
     > in the page cache.  It has a number of benefits that database
     > people are after as it allows multiple threads using
     > pread/pwrite to obtain the benefits of readahead.

Ah, OK. Sorry for being so dense ;-)

Yeah, that would be an improvement for knfsd too. The current scheme
can only manage readahead for 1 reader per inode.
Are there any records of a more detailed discussion of how to go about
implementing such a readahead strategy for Linux?

Cheers,
   Trond
