Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280814AbRK0PYP>; Tue, 27 Nov 2001 10:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280817AbRK0PYF>; Tue, 27 Nov 2001 10:24:05 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:8990 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280814AbRK0PXt>; Tue, 27 Nov 2001 10:23:49 -0500
Date: Tue, 27 Nov 2001 10:23:48 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Re: Fix knfsd readahead cache in 2.4.15
Message-ID: <20011127102348.A19330@redhat.com>
In-Reply-To: <15362.18626.303009.379772@charged.uio.no> <15362.53694.192797.275363@esther.cse.unsw.edu.au> <20011126.155347.45872112.davem@redhat.com> <20011126202509.J15582@redhat.com> <15363.39718.446155.619699@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15363.39718.446155.619699@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Nov 27, 2001 at 02:54:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 02:54:46PM +0100, Trond Myklebust wrote:
> >>>>> " " == Benjamin LaHaise <bcrl@redhat.com> writes:
> 
>      > Hint: readahead via the page cache is the way to go...
> 
> That's not the problem: knfsd has always done readahead via the page
> cache.

Sorry for not being clear, but what I was referring to is making the 
decision about how to read ahead by what is already in the page cache.  
It has a number of benefits that database people are after as it allows 
multiple threads using pread/pwrite to obtain the benefits of readahead.

		-ben
