Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264576AbTK0SDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 13:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbTK0SDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 13:03:44 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:56193 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264573AbTK0SDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 13:03:42 -0500
Date: Thu, 27 Nov 2003 18:03:29 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: "Joseph D. Wagner" <theman@josephdwagner.info>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       "'Matthew Wilcox'" <willy@debian.org>
Subject: Re: [PATCH] fs/locks.c fcntl_setlease did not check if a file was opened for writing before granting a read lease
Message-ID: <20031127180329.GC19669@mail.shareable.org>
References: <000301c3b504$689afbf0$0201a8c0@joe> <20031127165043.GA19669@mail.shareable.org> <16326.14408.365320.326423@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16326.14408.365320.326423@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
>  > dentry->d_flags is a combination of the S_ flags, not O_ flags.
>  > E.g. S_SYNC, S_NOATIME etc.
>  > 
>  > inode->i_flags is a combination of the DCACHE_ flags.
>  > E.g. DCACHE_AUTOFS_PENDING, DCACHE_REFERENCED tc.
> 
> I think it is other way around. ->i_flags are combined from S_SYNC (see,
> include/linux/fs.h:IS_IMMUTABLE(), for example), and ->d_flags are
> combined from DCACHE_*, latter is explicitly stated in
> include/linux/dcache.h

Oh, yes of course :)

-- Jamie
