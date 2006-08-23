Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWHWAHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWHWAHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 20:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWHWAHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 20:07:09 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:32138 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932107AbWHWAHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 20:07:08 -0400
Message-ID: <44EB9C28.9030204@namesys.com>
Date: Tue, 22 Aug 2006 17:07:04 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: David Masover <ninja@slaphack.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Mike Benoit <ipso@snappymail.ca>
Subject: Re: [PATCH] reiserfs: eliminate minimum window size for bitmap searching
References: <44EB1484.2040502@suse.com> <44EB23D9.9000508@slaphack.com> <44EB28EC.50802@suse.com>
In-Reply-To: <44EB28EC.50802@suse.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:
>
>
> Also, I think the bigalloc behavior just ultimately ends up introducing
> even more fragmentation on an already fragmented file system. It'll keep
> contiguous chunks together, but those chunks can end up being spread all
> over the disk.
>
> -Jeff
>
Yes, and almost as important, it makes it difficult to understand and
predict the allocator, which means other optimizations become harder to do.
