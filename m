Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTCOQSI>; Sat, 15 Mar 2003 11:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTCOQSI>; Sat, 15 Mar 2003 11:18:08 -0500
Received: from 67.231.118.64.mia-ftl.netrox.net ([64.118.231.67]:60328 "EHLO
	smtp.netrox.net") by vger.kernel.org with ESMTP id <S261330AbTCOQSH>;
	Sat, 15 Mar 2003 11:18:07 -0500
Subject: Re: [PATCH] remove BKL from ext2's readdir
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20030315023614.3e28e67b.akpm@digeo.com>
References: <m3vfyluedb.fsf@lexa.home.net>
	 <20030315023614.3e28e67b.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047745867.946.1.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 15 Mar 2003 11:31:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 05:36, Andrew Morton wrote:

> > I took a look at readdir() in 2.5.64's ext2 and found it serialized by BKL.
> 
> Yes, I had this in -mm for ages, seem to have lost it.  Also removal of BKL
> from lseek().

I moved lseek() from the BKL to the i_sem in early 2.5.

	Robert Love

