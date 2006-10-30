Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWJ3OwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWJ3OwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWJ3OwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:52:19 -0500
Received: from fogou.chygwyn.com ([195.171.2.24]:37299 "EHLO fogou.chygwyn.com")
	by vger.kernel.org with ESMTP id S964940AbWJ3OwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:52:18 -0500
Subject: Re: [PATCH] nfs: Fix nfs_readpages() error path
From: Steven Whitehouse <steve@chygwyn.com>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com
In-Reply-To: <1162159086.5545.70.camel@lade.trondhjem.org>
References: <877iyjundz.fsf@duaron.myhome.or.jp>
	 <1162149038.5545.37.camel@lade.trondhjem.org>
	 <87pscaua7p.fsf@duaron.myhome.or.jp>
	 <1162159086.5545.70.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: ChyGwyn Limited
Date: Mon, 30 Oct 2006 14:57:14 +0000
Message-Id: <1162220234.27980.274.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "fogou.chygwyn.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sun, 2006-10-29 at 16:58 -0500, Trond Myklebust
	wrote: > On Mon, 2006-10-30 at 05:40 +0900, OGAWA Hirofumi wrote: > >
	Well, both seems right things for me. So, the patch was done by > >
	minimum change for -rc. If you want it, I'll do. > > Feel free. I should
	have time to work on it tomorrow, in case you don't > find time today. >
	> > BTW, umm.. now I think, gfs2_readpages() seems to have a bug in
	error > > path by different way. unlock_page() is really needed? > >
	That looks like a definite bug too. > > Cheers, > Trond [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2006-10-29 at 16:58 -0500, Trond Myklebust wrote:
> On Mon, 2006-10-30 at 05:40 +0900, OGAWA Hirofumi wrote:
> > Well, both seems right things for me. So, the patch was done by
> > minimum change for -rc. If you want it, I'll do.
> 
> Feel free. I should have time to work on it tomorrow, in case you don't
> find time today.
> 
> > BTW, umm.. now I think, gfs2_readpages() seems to have a bug in error
> > path by different way. unlock_page() is really needed?
> 
> That looks like a definite bug too.
> 
> Cheers,
>   Trond

Agreed. It will be fixed fairly shortly as part of a patch related to a
race when reading and truncating "stuffed" files,

Steve.


