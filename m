Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVKWDtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVKWDtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVKWDtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:49:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932502AbVKWDtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:49:12 -0500
Date: Tue, 22 Nov 2005 19:48:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
cc: Andrew Morton <akpm@osdl.org>, Zan Lynx <zlynx@acm.org>, ak@muc.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: Linux 2.6.15-rc2
In-Reply-To: <4383E4F6.8000202@mnsu.edu>
Message-ID: <Pine.LNX.4.64.0511221944120.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <43829ED2.3050003@mnsu.edu>
 <20051122150002.26adf913.akpm@osdl.org> <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
 <20051122170507.37ebbc0c.akpm@osdl.org> <Pine.LNX.4.64.0511221735400.13959@g5.osdl.org>
 <4383E4F6.8000202@mnsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Jeffrey Hundstad wrote:
> 
> This one compiles and boots just fine.  I was also able to loop mount an
> ext2 filesystem.

Ok. Andrew added it to his queue, I guess I'll get my patch back that way ;)

> BTW: Since I have your ear, this same version DOES seem to have some
> other bug as well.  I did a "make distclean" and the "rm -f" of all he
> object files hung forever in "D" state.  I'm using XFS on IDE disks. 
> I'm using the same config as was posted before.  I didn't get anything
> in an log files that would indicate a problem.  Has this been reported? 
> If not, what can I do to make a meaningful report?

I don't recognize those symptoms, so more info would be nice.

For example, it would be good to know where the threads are that are 
waiting uninterruptibly. You should be able to get that info with Sysrq 
'T' (or with the old "ctrl + ScrollLock" thing).

That should tell us if they're hung on a semaphore or waiting for disk IO 
to complete or what...

		Linus
