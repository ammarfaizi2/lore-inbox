Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRJWPMc>; Tue, 23 Oct 2001 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277733AbRJWPMX>; Tue, 23 Oct 2001 11:12:23 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:39432 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277732AbRJWPMP>; Tue, 23 Oct 2001 11:12:15 -0400
Message-ID: <3BD588CE.FBCB081E@prodigy.com>
Date: Tue, 23 Oct 2001 11:12:14 -0400
From: Bill Davidsen <davidsen@prodigy.com>
Organization: Prodigy http://www.prodigy.net
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeffrey W. Baker" <jwbaker@acm.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12 cannot find root device on raid
In-Reply-To: <Pine.LNX.4.33.0110180755090.5641-100000@windmill.gghcwest.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeffrey W. Baker" wrote:
> 
> On Thu, 18 Oct 2001, Norbert Preining wrote:
> 
> > Hi!
> >
> > I have the following problem:
> >
> > kernel 2.4.12, md and raid1 compiled into the kernel.
> > /dev/hdb old linux installation
> > /dev/md0 -> /dev/hde1,/dev/hdg1 new installation
> >
> > When I boot my old installation the md device is automatically configured
> > by the kernel and I can mount it (reiserfs) without any problems.
> >
> > When I try to boot the new installation with the same kernel the md device
> > is initialized, but the kernel cannot mount the root device. I get msgs
> > about FAT problems and about mounting root as msdos.
> >
> > Here some config files:
> > lilo.conf:
> > image = /boot/lx-2.4.12
> >       root = /dev/hdb1
> >       label = old
> > image = /boot/lx-2.4.12
> >       root = /dev/md0
> >       label = new
> >       optional
> 
> To use a md as root, you need to add a kernel command line:
> 
> md0=1,/dev/hde1,/dev/hdg1
> 
> Put that in the append= line of lilo.conf or type it at the lilo command
> prompt.
> 
> See also Documentation/md.txt in the Linux source tree.

The line you provide doesn't look anything like the two forms in the
md.txt you mention. Or rather it looks like a blending, but neither of
them is md0= in form. I have to look at the code to see which is
correct, possibly yours, since the 
  append = "md=0,/dev/sda1,/dev/sdb1"
line doesn't seem to work :-(

The md.txt says the persistent superblock form is:
  md=<md device no.>,dev0,dev1,...,devn
which doesn't seem to work for me.

-- 
bill davidsen (davidsen@prodigy.com)
  Prodigy Internet Server Group
  Project Leader, USENET news
  914-448-1241
