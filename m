Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281045AbRKGXEv>; Wed, 7 Nov 2001 18:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281052AbRKGXEl>; Wed, 7 Nov 2001 18:04:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:20493 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281045AbRKGXEb>; Wed, 7 Nov 2001 18:04:31 -0500
Message-ID: <3BE9BCC8.925A1234@zip.com.au>
Date: Wed, 07 Nov 2001 14:59:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>, <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <3BE99650.70AF640E@zip.com.au>, <3BE99650.70AF640E@zip.com.au> <20011107133301.C20245@mikef-linux.matchmail.com> <3BE9AF15.50524856@zip.com.au>,
		<3BE9AF15.50524856@zip.com.au> <20011107145229.A560@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Wed, Nov 07, 2001 at 02:00:53PM -0800, Andrew Morton wrote:
> > Mike Fedyk wrote:
> > >
> > > I have a switch "data=journal" that ext2 will choke on when I boot into an
> > > ext2 only kernel.
> > >
> > > Is there another way to change the journaling mode besides modifying
> > > /etc/fstab?
> >
> > Try  adding `rootflags=data=journal' to your kernel boot
> > commandline.
> >
> 
> Oh, JOY!
> 
> adding that line to an ext2 only kernel will make it kernel panic when it
> tries to mount root because it doesn't understand the option!
> 

It's dumb that an unrecognised option be a fatal error.  Same
problem with modules, actually.  If you add a new module option
to modules.conf and then go back to an older kernel your module
won't load (here's where kaos pokes me with the rtfm stick).

You can create a second entry in lilo.conf which refers to the same
kernel image, but which doesn't have the rootflags option.

-
