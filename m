Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbSJ1MWm>; Mon, 28 Oct 2002 07:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSJ1MWm>; Mon, 28 Oct 2002 07:22:42 -0500
Received: from ns.suse.de ([213.95.15.193]:19471 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262408AbSJ1MWl>;
	Mon, 28 Oct 2002 07:22:41 -0500
Date: Mon, 28 Oct 2002 13:29:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugo Mills <hugo-lkml@carfax.org.uk>, Rik van Riel <riel@conectiva.com.br>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops in kswapd, 2.4.19 kernel and before
Message-ID: <20021028132901.B27077@oldwotan.suse.de>
References: <20021028102439.GB13490@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021028102439.GB13490@carfax.org.uk>; from hugo-lkml@carfax.org.uk on Mon, Oct 28, 2002 at 10:24:39AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 10:24:39AM +0000, Hugo Mills wrote:
>    Hi,
> 
>    This is the third time I've tried to report this problem, with no
> response so far. One last try. If you're not interested, please tell
> me and I won't bother you any more...
> 
>    I'm getting regular oopsen in kswapd on my 2.4.19 kernel. They
> generally appear to happen while running Amanda (a tape backup

if it only happens while or after running Amanda, it may be a tape
driver bug.

>    Decoded oopsen are below (they _are_ decoded with the right system
> maps, despite ksymoops's concerns). If there's anything else that's
> needed in order to track this down, please let me know.

the oopses shows some inode was corrupted, it doesn't tell us who is
corrupting them but most likely it is not a piece of common code (a driver
or a non mainstream feature or we should be able to reproduce it) You
should try to localize the bug to a piece of code, by for example making
100% sure that it triggers as soon as you start amanda. Then you can try
to backup using another device (not tape) and see if you can still
reproduce. finally you can try to use older or newer 2.4 drivers for the
tape and see if there's any change that fixes the problem in the old/new
drivers. Of course it isn't certain at all that it is the tape, I'm just
guessing because you said it happens while backing up to the tape.

Andrea
