Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBHWjy>; Thu, 8 Feb 2001 17:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbRBHWjo>; Thu, 8 Feb 2001 17:39:44 -0500
Received: from fe070.worldonline.dk ([212.54.64.208]:3597 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S129075AbRBHWjl>; Thu, 8 Feb 2001 17:39:41 -0500
Date: Thu, 8 Feb 2001 23:37:31 +0100
From: Torben Mathiasen <torben@kernel.dk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
Message-ID: <20010208233731.A661@fry>
In-Reply-To: <E14QwU4-0004QE-00@the-village.bc.nu> <Pine.LNX.4.21.0102082005400.2378-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0102082005400.2378-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Feb 08, 2001 at 08:12:39PM -0200
X-OS: Linux 2.4.1-ac7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08 2001, Rik van Riel wrote:
> On Thu, 8 Feb 2001, Alan Cox wrote:
> 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> > 
> > 2.4.1-ac7
> > o	Rebalance the 2.4.1 VM				(Rik van Riel)
> > 	| This should make things feel a lot faster especially
> > 	| on small boxes .. feedback to Rik
> 
> I'd really like feedback from people when it comes to this
> change. The change /should/ fix most paging performance bugs
> because it makes kswapd do the right amount of work in order
> to solve the free memory shortage every time it is run.
 
Rik,

Just installed ac7 and after some 30 minutes of unpacking
kernel-sources and diffing patches, I left my computer unattended
for about 1 hour. When I came back the system was unusable (like it 
was frozen), and /var/log/messages just displayed messages of the
type:

Feb  8 22:54:40 fry kernel: Out of Memory: Killed process 455 (xmms).
...

The OOM killer killed most of my apps, and finally X. I had to reboot
in order to get the system back. I've been running ac1-ac6 since they
came out with no problems, so I guess its the VM hack that is buggy.

This is on an AMD K7 1200Mhz, 512MB Ram, ATA100. Nothing big was
running at the time (xchat, xmms, mozilla, gnome, x, a few xterms).

I'll do some more testing tomorrow and provide any further information
you might need.



-- 
Torben Mathiasen <torben@kernel.dk>
Linux ThunderLAN maintainer 
http://opensource.compaq.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
