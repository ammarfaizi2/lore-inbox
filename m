Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270326AbTHLNmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270328AbTHLNmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:42:32 -0400
Received: from dsl017-022-215.chi1.dsl.speakeasy.net ([69.17.22.215]:15110
	"EHLO gateway.two14.net") by vger.kernel.org with ESMTP
	id S270326AbTHLNma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:42:30 -0400
Date: Tue, 12 Aug 2003 08:42:21 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20030812134221.GA6412@furrr.two14.net>
Reply-To: maney@pobox.com
References: <20030812035803.GA17921@furrr.two14.net> <Pine.LNX.4.44.0308121011100.3386-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308121011100.3386-100000@logos.cnet>
User-Agent: Mutt/1.3.28i
From: maney@two14.net (Martin Maney)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 10:12:19AM -0300, Marcelo Tosatti wrote:
> Can you tell me exactly how can I try to reproduce the problem you're 
> seeing? 
> 
> With just cp and unmount you can see the corruption? 

Yes.  With the c. 50MB file it happens every time (now out of a couple
dozen tests).  A 3MB file did not get corrupted in half a dozen trials,
including ones where both were copied before the umount.

The age & condition of the target filesystem don't seem to matter; at
least I have replicated this immediately following mke2fs of the
target.  The original observed corruption was on much older and more
cluttered filesystems - the first sign of trouble was when a local
build of XFree failed.

In case I wasn't perfectly clear (it was late, so that may well be), I
used the umount/mount only to invalidate the buffers; merely syncing
after copying wouldn't produce any immediate effect.  The copy always
looks good until the data has to be read back from the target
filesystem.

One other item which I didn't think to mention is that the compiler was
"gcc version 2.95.4 20011002" - Debian's normal compiler in the Woody
release.  Of course that's been used for every other 2.4 kernel I've
built here as well.

-- 
the warfare on the cutting edge of any science draws attention
away from the huge uncontested background, the dull metal heft
of the axe that gives the cutting edge its power.  -- Dennett

