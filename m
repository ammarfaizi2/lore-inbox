Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBHWrO>; Thu, 8 Feb 2001 17:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRBHWrF>; Thu, 8 Feb 2001 17:47:05 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:6384 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129093AbRBHWq4>; Thu, 8 Feb 2001 17:46:56 -0500
Date: Thu, 8 Feb 2001 20:46:23 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Torben Mathiasen <torben@kernel.dk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <20010208233731.A661@fry>
Message-ID: <Pine.LNX.4.21.0102082044250.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Torben Mathiasen wrote:
> On Thu, Feb 08 2001, Rik van Riel wrote:
> > On Thu, 8 Feb 2001, Alan Cox wrote:
> > 
> > > 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> > > 
> > > 2.4.1-ac7
> > > o	Rebalance the 2.4.1 VM				(Rik van Riel)
> > > 	| This should make things feel a lot faster especially
> > > 	| on small boxes .. feedback to Rik

> Just installed ac7 and after some 30 minutes of unpacking
> kernel-sources and diffing patches, I left my computer unattended
> for about 1 hour. When I came back the system was unusable (like it 
> was frozen), and /var/log/messages just displayed messages of the
> type:
> 
> Feb  8 22:54:40 fry kernel: Out of Memory: Killed process 455 (xmms).
> ...
> 
> The OOM killer killed most of my apps, and finally X. I had to reboot
> in order to get the system back. I've been running ac1-ac6 since they
> came out with no problems, so I guess its the VM hack that is buggy.

Highly unlikely since the VM rebalancing patch doesn't change
any of the actual swapout mechanisms.

All it does is change how often the particular algorithms get
called by kswapd and by user programs.

As for trigerring the OOM killer, this strongly suggest a
memory leak since there's a bug in the code which makes it
very hard to trigger the OOM killer under normal situations
(I'm working on a fix for that now).

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
