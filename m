Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286845AbRL1LlQ>; Fri, 28 Dec 2001 06:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286851AbRL1Lkz>; Fri, 28 Dec 2001 06:40:55 -0500
Received: from fepC.post.tele.dk ([195.41.46.147]:32180 "EHLO
	fepC.post.tele.dk") by vger.kernel.org with ESMTP
	id <S286845AbRL1Lku>; Fri, 28 Dec 2001 06:40:50 -0500
Date: Fri, 28 Dec 2001 12:40:37 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011228124037.K2973@suse.de>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de> <20011227140723.A4713@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227140723.A4713@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27 2001, rwhron@earthlink.net wrote:
> On Mon, Dec 24, 2001 at 06:02:44PM +0100, Jens Axboe wrote:
> > > I tried unpatched 2.5.2-pre1 on a k6-2.  dbench 32 hung similarly with 
> > > 32 in "b", bo and bi = 0, and id = 100.  That machine is ill now and can't
> > > find "init" when booting, boot single, or boot init=/bin/bash.
> > 
> > Please send ps -eo cmd,wchan info for a hung machine.
> > 
> > -- 
> > Jens Axboe
> > 
> 
> I rebuilt the reiserfs that dbench writes to.
> Here is ps -eo cmd,wchan on the k6-2 running 2.5.2-pre2:

Ah this is interesting, all stuck in get_request_wait. I cannot
reproduce your problem here whatever I do, no reiser though.

-- 
Jens Axboe

