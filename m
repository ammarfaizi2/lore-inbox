Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273730AbRIQWb4>; Mon, 17 Sep 2001 18:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273726AbRIQWa6>; Mon, 17 Sep 2001 18:30:58 -0400
Received: from [194.213.32.137] ([194.213.32.137]:516 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273730AbRIQWaW>;
	Mon, 17 Sep 2001 18:30:22 -0400
Date: Fri, 14 Sep 2001 10:06:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: John Ripley <jripley@riohome.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: COW fs (Re: Editing-in-place of a large file)
Message-ID: <20010914100632.D35@toy.ucw.cz>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua> <3B9B80E2.C9D5B947@riohome.com> <3B9B9917.DA1CC12F@riohome.com> <1000057292.1867.1.camel@nomade> <3B9C1767.2A35BFD2@riohome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B9C1767.2A35BFD2@riohome.com>; from jripley@riohome.com on Mon, Sep 10, 2001 at 02:29:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > le dim 09-09-2001 at 18:30 John Ripley a _rit :
> > 
> > > /dev/sda6 - /tmp      -  210845 blocks,  17697 duplicates,  8.39%
> > > /dev/sda7 - /var      -   32122 blocks,   5327 duplicates, 16.58%
> > > /dev/sdb5 - /home     -  220885 blocks,  24541 duplicates, 11.11%
> > > /dev/sdc7 - /usr      - 1084379 blocks, 122370 duplicates, 11.28%
> > 
> > How many of these blocks actually belong to file data ?
> 
> Hmm, good point:
> 
> Filesystem         1024-blocks  Used Available Capacity Mounted on
> /dev/sda6             841616    4508   837108      1%   /tmp
> /dev/sda7             124407   63774    54209     54%   /var
> /dev/sdb5             855138  677328   177810     79%   /home
> /dev/sdc7            4191237 3946214   245023     94%   /usr
> 
> My thinking was that I've managed to run out of space on all of the
> partitions in the past and had to prune a lot of stuff... so nearly all
> the blocks should contain at least some "likely" data. Still, I guess I
> need to verify that this isn't distorting the results. The program needs
> to recurse over all files on the filesystem rather than all blocks on a
> partition.
just cat /dev/urandom > file to fill it with garbage
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

