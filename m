Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263909AbRFSGmq>; Tue, 19 Jun 2001 02:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263910AbRFSGmf>; Tue, 19 Jun 2001 02:42:35 -0400
Received: from cassis.axialys.net ([217.146.224.11]:59908 "EHLO
	smtp.axialys.net") by vger.kernel.org with ESMTP id <S263909AbRFSGmW>;
	Tue, 19 Jun 2001 02:42:22 -0400
Date: Mon, 18 Jun 2001 22:21:31 +0200
From: Simon Huggins <huggie@earth.li>
To: Pavel Machek <pavel@suse.cz>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown
Message-ID: <20010618222131.A26018@paranoidfreak.co.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010615152306.B37@toy.ucw.cz>
User-Agent: Mutt/1.3.18i
Organization: Black Cat Networks, http://www.blackcatnetworks.co.uk/
X-Attribution: huggie
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 03:23:07PM +0000, Pavel Machek wrote:
> > Roger> It does if you are running on a laptop. Then you do not want
> > Roger> the pages go out all the time. Disk has gone too sleep, needs
> > Roger> to start to write a few pages, stays idle for a while, goes to
> > Roger> sleep, a few more pages, ...
> > That could be handled by a metric which says if the disk is spun
> > down, wait until there is more memory pressure before writing.  But
> > if the disk is spinning, we don't care, you should start writing out
> > buffers at some low rate to keep the pressure from rising too
> > rapidly.  
> Notice that write is not free (in terms of power) even if disk is
> spinning.  Seeks (etc) also take some power. And think about
> flashcards. It certainly is cheaper tha spinning disk up but still not
> free.

Isn't this why noflushd exists or is this an evil thing that shouldn't
ever be used and will eventually eat my disks for breakfast?


Description: allow idle hard disks to spin down
 Noflushd is a daemon that spins down disks that have not been read from
 after a certain amount of time, and then prevents disk writes from
 spinning them back up. It's targeted for laptops but can be used on any
 computer with IDE disks. The effect is that the hard disk actually spins
 down, saving you battery power, and shutting off the loudest component of
 most computers.

http://noflushd.sourceforge.net


Simon.

-- 
[ "CATS. CATS ARE NICE." - Death, "Sourcery"                           ]
        Black Cat Networks.  http://www.blackcatnetworks.co.uk/
