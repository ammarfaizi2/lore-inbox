Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264538AbRFJQDJ>; Sun, 10 Jun 2001 12:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264539AbRFJQC7>; Sun, 10 Jun 2001 12:02:59 -0400
Received: from as73.astro.ch ([192.53.104.1]:18191 "EHLO as73.astro.ch")
	by vger.kernel.org with ESMTP id <S264538AbRFJQCr>;
	Sun, 10 Jun 2001 12:02:47 -0400
Date: Sun, 10 Jun 2001 18:02:08 +0200 (METDST)
From: Alois Treindl <alois@astro.ch>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Oops with kernel 2.4.5 on heavy disk traffic
In-Reply-To: <Pine.GSO.4.21.0106101122570.22838-100000@weyl.math.psu.edu>
Message-ID: <Pine.HPX.4.21.0106101755220.13723-100000@as73.astro.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001, Alexander Viro wrote:

> 	Please, apply. What's happing here is simple - we set i_ino by
> PID and get something out of range of per-process inode. Confusion
> follows... Fix: move initializing ->u.proc_i.task past the check.
> Then proc_delete_inode() will be happy with it.
> 	Alois, Bryce - that ought to fix the oopsen you see.

Alexander

do I read this right: this is not a very critical bug?
In my case, it was 'top' which crashed twice (I was unable to reproduce
this while trying hard in the last 4 hours, after the original two cases). 

Are any processes which are not - like top or ps - trying to read
the /proc file system likely to be affected by the bug?

I am a bit worried about applying 'unauthorized' kernel paches to my
server. This has created problems for me in the past.

So, it the bug is non critical, I would rather accept the occasional
crash of 'top' or 'ps' than playing around with kernel code.

Please, comment.
 
Alois

