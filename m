Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314411AbSDVSlE>; Mon, 22 Apr 2002 14:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314417AbSDVSlE>; Mon, 22 Apr 2002 14:41:04 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:17145 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314411AbSDVSlB>; Mon, 22 Apr 2002 14:41:01 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 22 Apr 2002 12:39:19 -0600
To: Kent Borg <kentborg@borg.org>
Cc: Libor Vanlk <libor@conet.cz>, linux-kernel@vger.kernel.org
Subject: Re: Adding snapshot capability to Linux
Message-ID: <20020422183919.GG3017@turbolinux.com>
Mail-Followup-To: Kent Borg <kentborg@borg.org>,
	Libor Vanlk <libor@conet.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <3CC3ECD2.9000205@conet.cz> <20020422170745.GD3017@turbolinux.com> <20020422134139.B16000@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 22, 2002  13:41 -0400, Kent Borg wrote:
> On Mon, Apr 22, 2002 at 11:07:46AM -0600, Andreas Dilger wrote:
> > Please see:
> > http://www-mddsp.enel.ucalgary.ca/People/adilger/snapfs/
> > 
> > What you describe is exactly what snapfs does.  The Sourceforge project
> > is currently inactive, but the code itself is GPL and only needs some
> > polishing up and maintenance to be useful (probably also some work to
> > get it all OK under 2.4 again).
> 
> Very interesting.  Firing up google.com/linux I found a LWN story on
> snapfs from a year ago March: <http://lwn.net/2001/0308/kernel.php3>.
> Other than looking to me like it might not be bootable, this looks
> very much like something someone named Kent Borg was asking about a
> few days ago.

Actually, because ext2/ext3 is used as the underlying on-disk format,
you could probably boot from a snapfs filesystem if needed.  The on-disk
layout is designed such that the "current" version of the snapshot is
what you would always get (the snapshot data is hung off EAs on each
inode).  However, since you would then have the root filesystem mounted
as ext2/ext3 and not snapfs, you could not use the snapshot features.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

