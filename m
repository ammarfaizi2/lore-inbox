Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUGLSQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUGLSQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266906AbUGLSQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:16:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:18606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266914AbUGLSP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:15:58 -0400
Date: Mon, 12 Jul 2004 11:14:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jim.houston@comcast.net, dm-devel@redhat.com,
       torvalds@osdl.org, agk@redhat.com
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-Id: <20040712111445.374bf579.akpm@osdl.org>
In-Reply-To: <200407120949.03928.kevcorry@us.ibm.com>
References: <200407011035.13283.kevcorry@us.ibm.com>
	<1089197914.986.17.camel@new.localdomain>
	<20040707041059.17287591.akpm@osdl.org>
	<200407120949.03928.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> On Wednesday 07 July 2004 6:10 am, Andrew Morton wrote:
> > Jim Houston <jim.houston@comcast.net> wrote:
> > >
> > > Hi Andrew,
> > >
> > > It's not quite right.  If you want to keep a count in the upper bits
> > > you have to mask off that count before checking if the id is beyond the
> > > end of the allocated space.
> >
> > OK, I'll fix that up.
> >
> > But I don't want to keep a count in the upper bits!  I want rid of that
> > stuff altogether, completely, all of it.  It just keeps on hanging around
> > :(
> >
> > We should remove MAX_ID_* from the kernel altogether.
> 
> Just following up on the proposed IDR changes. Based on the patches in the 
> latest -mm tree, I'm assuming there is or will be a fix for IDR so it will 
> always return NULL when asked to find an id that's not currently allocated. 
> Is this correct? If so, I can drop the second "dm-use-idr" patch (from July 
> 6, 2004) and keep the one that's currently in -mm.
> 

Yes, I'm assuming that the code in Linus's tree at present is acceptable,
and I'll take another look at the idr code post-2.6.8.

