Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbTATOFS>; Mon, 20 Jan 2003 09:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTATOFS>; Mon, 20 Jan 2003 09:05:18 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:49855 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S265643AbTATOFP>; Mon, 20 Jan 2003 09:05:15 -0500
Date: Mon, 20 Jan 2003 14:14:19 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: jlnance@unity.ncsu.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANN] ntfsprogs (formerly Linux-NTFS) 1.7.0beta released
In-Reply-To: <20030120133938.GA2842@ncsu.edu>
Message-ID: <Pine.SOL.3.96.1030120140722.6544B-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 jlnance@unity.ncsu.edu wrote:
> On Sun, Jan 19, 2003 at 04:05:50PM +0100, Pawel Kot wrote:
> > There exists a new ntfs driver called NTFS-TNG, which is present already
> > in 2.5.x kernel series and it has its backport to the 2.4.x kernel series
> > (you'll find it at http://linux-ntfs.sf.net/).
> > 
> > This driver has no write support yet, but it allows you to overwrite the
> > files, without changing their attributes and size (ie. mmap() the file,
> > change the contents, write() the file). And the overwrite is considered
> > safe.
> 
> Is this stable enough to allow you to put an ext2 image on an NTFS
> partition and then mount that image as a r/w loopback mount from
> Linux?

Yes! This was the most desired item by people which is why I made sure it
was the first thing to be implemented (it also happens to be the easiest
thing to implement as it doesn't involve any changes to metadata at all). 

I consider that completely stable although there have been some reports of
hangs but I have never seen one and everyone who has filed a bug report
wasn't able to reproduce the hang on request so I am not really sure where
the hangs come from... It might not even be the ntfs driver per se but a
bad interaction between ntfs and some other kernel subsystem like the mm
layer or the block layer. But I have only seen three reports of a system
freeze so far and Mandrake who ship the new driver I would assume have
more users than that and either they are not complaining or they are not
having problems. I hope the latter. (-;

In any case, even if there is a bug somewhere which causes the kernel to
hang, no damage to the ntfs partition will occur from the new driver as it
is now. It simply doesn't modify any metadata at all so it can't cause any
damage.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

