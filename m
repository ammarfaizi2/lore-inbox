Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282933AbRK0Uis>; Tue, 27 Nov 2001 15:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282936AbRK0Uii>; Tue, 27 Nov 2001 15:38:38 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:56821
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282933AbRK0Uib>; Tue, 27 Nov 2001 15:38:31 -0500
Date: Tue, 27 Nov 2001 12:38:04 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Paul Bristow <paul@paulbristow.net>
Cc: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: ide-floppy.c vs devfs
Message-ID: <20011127123804.F9391@mikef-linux.matchmail.com>
Mail-Followup-To: Paul Bristow <paul@paulbristow.net>,
	Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <000601c1773f$d80d9ba0$21c9ca95@mow.siemens.ru> <3C03D197.7050605@paulbristow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C03D197.7050605@paulbristow.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 06:47:03PM +0100, Paul Bristow wrote:
> 
> 
> Borsenkow Andrej wrote:
> 
> >>This is made somewhat more complicated by the fact that ide-floppy
> >>
> >disks
> >
> >>can use either the whole disk, with no partition table or, more
> >>commonly, partition4.  So a user-friendly solution would be to create
> >>
> >a
> >
> >>floppy node that pointed to the partition, if it existed, or the whole
> >>disk if it didn't.  With appropriate code to handle that fact that
> >>anyone can partition these disks in any way they like.
> >>
> >>
> >
> >Where's the problem? Use .../disc for whole disc or .../part4 for
> >"normal" access. (Or /dev/hdc and /dev/hdc4 if you prefer) It is nice if
> >partition code can detect it but it is not ide-floppy driver problem.
> 
> 
> Just wondering if we should be clever for the users here.  Maybe I 
> should leave that to user-space tools?  Or is there anything in devfs 
> that can take care of this?  The nice solution for end-users might be
> a /dev/idefloppy that is a symlink to the relevant node in the 
> /dev/ide... tree.
>

Can't devfsd be configured to do something like this?

> >Why complicate things more than needed?
> 
> Because you can boot from a zip or ls-120 drive, with the BIOS setting 
> it to this mode.  There are disks out there that are unreadable unless 
> you ignore track zero, by formatting them in a PC like this.
>

If that's what is required to boot from ls-120 and zip, then it probably
needs to be in kernel space.

MF
