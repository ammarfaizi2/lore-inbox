Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129686AbQKBIMg>; Thu, 2 Nov 2000 03:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130309AbQKBIM0>; Thu, 2 Nov 2000 03:12:26 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:3076 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S129686AbQKBIMH>; Thu, 2 Nov 2000 03:12:07 -0500
Date: Thu, 2 Nov 2000 00:12:27 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] two swapping processes freeze 2.4.0-test10 (but not
 2.2.18pre19)
In-Reply-To: <Pine.LNX.4.21.0011012222210.1296-100000@shimura.math.berkeley.edu>
Message-ID: <Pine.LNX.4.21.0011020005550.1565-100000@shimura.math.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Wayne Whitney wrote:

> On Wed, 1 Nov 2000, Rik van Riel wrote (in "Re: [BUG] /proc/<pid>/stat
> access stalls badly for swapping process, 2.4.0-test10"):
>
> > 3) combine this with the elevator starvation stuff (ask Jens 
> >    Axboe for blk-7 to alleviate this issue) and you have a 
> >    scenario where processes using /proc/<pid>/stat have the 
> >    possibility to block on multiple processes that are in the 
> >    process of handling a page fault (but are being starved) 

I just tried patching 2.4.0-test10 with Jens Axboe's blk-7 patch for
2.4.0-test10-pre6.  It applies cleanly other than "Hunk #1 succeeded at
855 (offset -20 lines)" on file mm/filemap.c.  Unfortunately, this had no
effect on the behavior I described . . .

Best wishes,
Wayne



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
