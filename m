Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130822AbQKGJ5B>; Tue, 7 Nov 2000 04:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131154AbQKGJ4v>; Tue, 7 Nov 2000 04:56:51 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:33808 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S130822AbQKGJ4l>; Tue, 7 Nov 2000 04:56:41 -0500
Date: Tue, 7 Nov 2000 10:56:26 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: James Simmons <jsimmons@suse.com>
cc: Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        tytso@mit.edu, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0011061733250.6278-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.21.0011071053211.17375-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, James Simmons wrote:

> > Unfortunately I cannot confirm this. Checked 2.4.0-test10 and the problem
> > is still there. I digged further and it seems to be a race condition(?)
> > triggered by swapped out stuff - because just starting X and switching
> > back to the console works fine, but as I start some memory-consuming stuff
> > (I have only 32Megs of ram) and then switch back to the console its
> > completely garbagled the first time and black the second time and later.
> 
> I have seen this problem before. The problem is the X server is the one
> that sets the hardware back to vga text mode. Under heavy stress the X
> server can fail and the hardware is left in a undeterminate state. I have
> started on working to solve this problem but it will be something for
> 2.5.X since it requires quite a bit of change to vgacon and the console
> system. My recent vga patches where early attempts at this but they are
> still incomplete.  

Umm, so why does this not happen with 2.2.X at all? Also the system is
not really stressed, but I simply do startx, inside an xterm go to
some random source, make -j, wait till the compile is complete and then
switch back to the console - its just that it seems that swapped out
X server or console stuff causes this.

I consider this quite a showstopper for 2.4.0.

Richard. 

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
