Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTDGJCC (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 05:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTDGJCB (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 05:02:01 -0400
Received: from [12.47.58.191] ([12.47.58.191]:58344 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263355AbTDGJCA (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 05:02:00 -0400
Date: Mon, 7 Apr 2003 02:13:31 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: rml@tech9.net, trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: 2.5: NFS troubles
Message-Id: <20030407021331.1ffbfa7f.akpm@digeo.com>
In-Reply-To: <1049706067.592.5.camel@teapot.felipe-alfaro.com>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	<shsbrzjn5of.fsf@charged.uio.no>
	<20030406171855.6bd3552d.akpm@digeo.com>
	<1049675270.753.166.camel@localhost>
	<1049706067.592.5.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 09:13:28.0610 (UTC) FILETIME=[F3B30020:01C2FCE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> On Mon, 2003-04-07 at 02:27, Robert Love wrote:
> > On Sun, 2003-04-06 at 20:18, Andrew Morton wrote:
> > 
> > > if it shows dir_index then it might be an ext3 problem.  If not then it is
> > > probably an NFS problem.
> > 
> > Nah, its not an ext3 problem (at least not with htree).
> 
> But it could be an interaction problem between NFS and ext3. I did what
> Andrew pointed (disabling dir_index) and it solved my problems.
> 
> I don't think it's a client problem, since I can't reproduce with
> 2.4+ext3, 2.5.66+ext2 and 2.5.66+ext3-dir_index, but is reproducible
> with 2.5.66+ext3+dir_index.
> 

Well it could still be an NFS problem.  Turning off htree on the server could
cause filenames to be returned in a different order (or is that illegal?) or
changed timing or such.

If Robert is seeing it on non-htree servers then we'd need to see that fixed
up before deciding if there is also an(other) htree bug.

First thing we need to do is to debug it.  Trond would have a better idea of
how to set about that than I.  Possibly a tcpdump of the traffic?

