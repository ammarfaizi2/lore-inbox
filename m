Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVHaEyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVHaEyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 00:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVHaEyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 00:54:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32445 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751248AbVHaEyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 00:54:12 -0400
Date: Wed, 31 Aug 2005 14:53:05 +1000
From: Nathan Scott <nathans@sgi.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050831145305.B4434621@wobbly.melbourne.sgi.com>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de> <20050830234823.GF780@frodo> <20050830235824.GG780@frodo> <17173.12216.263860.76176@tut.ibm.com> <20050831143309.A4434621@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050831143309.A4434621@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Wed, Aug 31, 2005 at 02:33:10PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 02:33:10PM +1000, Nathan Scott wrote:
> ...
> On an unrelated note, are there any known issues with using epoll
> on relayfs file descriptors?  I'm having a few troubles, and just
> wondering if its me doing something silly, or if its known to not
> work...?  Symptoms of the problem are epoll continually reaching
> its timeout with no modified fds found (when I know the inode has
> modified trace buffers attached) ...

Actually, poll(2) seems to have the same behaviour with a simpler
test case (i.e. no epoll, & with just one fd being polled) - if I
read(2) from it every few thousand usec (using the blktrace tool)
it sees new data, but if I poll, it never reports the descriptor
as changed (this is a 2.6.13 kernel with the relayfs patches from
-mm patched into it and Jens' blktrace patch generating the data
that I'm attempting to poll).

cheers.

-- 
Nathan
