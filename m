Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUEJWt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUEJWt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUEJWrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:47:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:42420 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbUEJWpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:45:30 -0400
Date: Mon, 10 May 2004 15:48:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040510154800.5a5183ea.akpm@osdl.org>
In-Reply-To: <200405102227.i4AMRZH0005222@turing-police.cc.vt.edu>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510223755.A7773@infradead.org>
	<20040510150203.3257ccac.akpm@osdl.org>
	<200405102227.i4AMRZH0005222@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Mon, 10 May 2004 15:02:03 PDT, Andrew Morton said:
> 
> > > These two just introduced a subtile behaviour change during stable series,
> > > possibly (not likely) leading to DoS opportunities from applications running
> > > as gid 0.
> > 
> > mlock_group is likely to go away.
> > 
> > Is an unprivileged user likely to have gid 0?   Easy enough to fix, anyway.
> 
> Equally important, is gid 0 (with its other possible overloadings) something that we
> want to put on a user just because they have a need for mlock??

You misread the code.  The sysctl, when non-zero, specifies the group which is
allowed to allocate hugetlb-backed shm segments.
