Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266861AbUGLOtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266861AbUGLOtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265138AbUGLOtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:49:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44242 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266861AbUGLOtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:49:07 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Date: Mon, 12 Jul 2004 09:49:03 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net,
       dm-devel@redhat.com, torvalds@osdl.org, agk@redhat.com
References: <200407011035.13283.kevcorry@us.ibm.com> <1089197914.986.17.camel@new.localdomain> <20040707041059.17287591.akpm@osdl.org>
In-Reply-To: <20040707041059.17287591.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407120949.03928.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 July 2004 6:10 am, Andrew Morton wrote:
> Jim Houston <jim.houston@comcast.net> wrote:
> >
> > Hi Andrew,
> >
> > It's not quite right.  If you want to keep a count in the upper bits
> > you have to mask off that count before checking if the id is beyond the
> > end of the allocated space.
>
> OK, I'll fix that up.
>
> But I don't want to keep a count in the upper bits!  I want rid of that
> stuff altogether, completely, all of it.  It just keeps on hanging around
> :(
>
> We should remove MAX_ID_* from the kernel altogether.

Just following up on the proposed IDR changes. Based on the patches in the 
latest -mm tree, I'm assuming there is or will be a fix for IDR so it will 
always return NULL when asked to find an id that's not currently allocated. 
Is this correct? If so, I can drop the second "dm-use-idr" patch (from July 
6, 2004) and keep the one that's currently in -mm.

Thanks!

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
