Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWCaOfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWCaOfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWCaOfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:35:03 -0500
Received: from unthought.net ([212.97.129.88]:1804 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751370AbWCaOfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:35:01 -0500
Date: Fri, 31 Mar 2006 16:35:00 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331143500.GK9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060331094850.GF9811@unthought.net> <1143807770.8096.4.camel@lade.trondhjem.org> <20060331124518.GH9811@unthought.net> <1143810392.8096.11.camel@lade.trondhjem.org> <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143814889.8096.22.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 09:21:29AM -0500, Trond Myklebust wrote:
...
> 
> Hmm... Nothing obvious.

Ok.

I'm wondering... Can anyone else reproduce this problem?

Just to explain quickly:
 Running nfsbench (on the NFS client) once with LEADING_EMPTY_SPACE set
 to 0 and then once with the option set to 1.  If there's a big change
 in wall-clock execution time, this indicates that the problem exists.

I'd be really interested in knowing whether I'm the only one who sees
this problem.

> Try catting /proc/self/mountstats and see if the entry for your NFS
> mount shows anything interesting.

mountstats doesn't exist on 2.6.15.7 so I can't really compare...

I wonder if any of the following is 'interesting'  :)

device sparrow:/exported/joe mounted on /u/joe with fstype nfs statvers=1.0
 opts: rw,vers=3,rsize=32768,wsize=32768,acregmin=3,acregmax=60,acdirmin=30,
       acdirmax=60,hard,intr,proto=udp,timeo=7,retrans=3
 age:    274
 caps:   caps=0x1,wtmult=4096,dtsize=4096,bsize=0,namelen=255
 sec:    flavor=1
 events: 175 77 3 3 14 15 108 4 0 7 0 4 0 1 2 0 0 14 0 1 4 0 0 0 0 
 bytes:  194733 11746 0 0 37748 15340 13 0 
 RPC iostats version: 1.0  p/v: 100003/3 (nfs)
 xprt:   udp 1023 0 74 74 0 74 0
 per-op statistics
 ... then follows the nfsstat numbers as far as I can see ...

Does the above tell you anything?

-- 

 / jakob

