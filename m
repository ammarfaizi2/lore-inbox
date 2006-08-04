Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWHDJXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWHDJXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbWHDJXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:23:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6624 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161122AbWHDJXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:23:39 -0400
Subject: Re: heavy file i/o on ext3 filesystem leads to huge
	ext3_inode_cache and dentry_cache that doesn't return to normal for hours
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maarten Maathuis <madman2003@gmail.com>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <6d4bc9fc0608040053x4d7a9e14xe9de793cd0787736@mail.gmail.com>
References: <6d4bc9fc0608030927t175f16c0kfef6a21cc521e368@mail.gmail.com>
	 <1154661560.17180.31.camel@kleikamp.austin.ibm.com>
	 <6d4bc9fc0608040053x4d7a9e14xe9de793cd0787736@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 10:43:07 +0100
Message-Id: <1154684587.23655.175.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-04 am 09:53 +0200, ysgrifennodd Maarten Maathuis:
> > > Whenever there is serious hard drive activity (such as doing "slocate
> > > -u") ext3_inode_cache and dentry_cache grow to a combined 400-500 MiB.
> >
> > The behavior of slocate (updatedb) is pretty well-known, but nobody has
> > come up with a real solution.

Thats not actually true. There is patch to page back in code on a quiet
machine which is in -mm and is designed to pull stuff back after a busy
period. There was also discussion (but not yet code) for splitting the
dcache into two and being much smarter about recycling it.


