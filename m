Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbSJHAoV>; Mon, 7 Oct 2002 20:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbSJHAoV>; Mon, 7 Oct 2002 20:44:21 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:20732 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S262655AbSJHAoU>;
	Mon, 7 Oct 2002 20:44:20 -0400
Date: Mon, 7 Oct 2002 20:49:56 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41: cpqarray compile fixes
Message-ID: <20021008004956.GA30697@www.kroptech.com>
References: <20021007233627.GB24284@www.kroptech.com> <Pine.GSO.4.21.0210071936540.29030-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210071936540.29030-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 07:39:46PM -0400, Alexander Viro wrote:
>
> On Mon, 7 Oct 2002, Adam Kropelin wrote:
> > cpqarray in 2.5.41 needs the patch below to compile. 
>
> Yeah, and more than that.  Same typo is in cciss, rd.c sets ->first_minor to
> 0 for all units and HD_IRQ definition is needed if CONFIG_BLK_DEV_HD is
> defined.

Don't forget the second part of that patch ;) Also I've verified cpqarray still
needs the queue plugging fixed in order to not deadlock here. The stopgap patch
I sent you the other day still works for now. I'll work up a better fix soon.

--Adam

