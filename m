Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQKFRh0>; Mon, 6 Nov 2000 12:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129928AbQKFRhG>; Mon, 6 Nov 2000 12:37:06 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:26120 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129525AbQKFRgz>;
	Mon, 6 Nov 2000 12:36:55 -0500
Date: Mon, 6 Nov 2000 17:37:14 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0011061025210.17375-100000@fs1.dekanat.physik.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.21.0011061733250.6278-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > How recent of a test kernel. Yes their was a problem with the console
> > > > palette but it is now fixed in the most recent test kernels.
> > > 
> > > 2.4.0-test10-pre5
> > 
> > Please upgrade to a newer kernel. This problem has been fixed :-)
> > 
> 
> Unfortunately I cannot confirm this. Checked 2.4.0-test10 and the problem
> is still there. I digged further and it seems to be a race condition(?)
> triggered by swapped out stuff - because just starting X and switching
> back to the console works fine, but as I start some memory-consuming stuff
> (I have only 32Megs of ram) and then switch back to the console its
> completely garbagled the first time and black the second time and later.

I have seen this problem before. The problem is the X server is the one
that sets the hardware back to vga text mode. Under heavy stress the X
server can fail and the hardware is left in a undeterminate state. I have
started on working to solve this problem but it will be something for
2.5.X since it requires quite a bit of change to vgacon and the console
system. My recent vga patches where early attempts at this but they are
still incomplete.  

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
