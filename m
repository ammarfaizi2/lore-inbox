Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286413AbSAAXwv>; Tue, 1 Jan 2002 18:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286407AbSAAXwm>; Tue, 1 Jan 2002 18:52:42 -0500
Received: from inreach-gw1.idiom.com ([209.209.13.26]:12036 "EHLO
	smile.idiom.com") by vger.kernel.org with ESMTP id <S286402AbSAAXwd>;
	Tue, 1 Jan 2002 18:52:33 -0500
Message-ID: <3C324B0D.44BB4B88@obviously.com>
Date: Tue, 01 Jan 2002 18:49:33 -0500
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Grahame Jordan <gbj@theforce.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why would a valid DVD show zero files on Linux?
In-Reply-To: <E16LQly-0000Yj-00@the-village.bc.nu> <1009927797.5016.2.camel@falcon>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I'm learning, this is complex.  Some DVD's, Alan says, have differing
udf and iso9660 filesystems for copy protection reasons.  They spoof windows
into not allowing easy access to some files.  Maybe your VCD issue is similar.

Try mounting the disc both ways (udf and iso9660) and compare the filesystems.

I'm told windows prefers udf to iso9660.  Linux does it the other way 'round.
Thus a disc that works perfectly on Windows shows zero files on Linux
(confusing users and sysadmins alike, since prior to today, the man pages
for mount and fstab were silent on the issue).

			-Bryce

PS: Thanks for being the first person to also think users should not have
to know about the udf vs. iso9660 issue.

It looks like util-linux, mount is the place to fix this:
ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/util-linux/

See also http://www.osta.org/ , the Optical Storage Technology Association.


Grahame Jordan wrote:
> 
> All,
> 
> Is this similar to the VCD problem I have where I can mount the cd and
> read the smaller files but cannot read the mpg file (avseq01.dat)?
> 
> I installed mtv which plays the CD OK.  But this does not solve the real
> problem.
> 
> I to believe that the user should not need to know the technical
> intricaties of how to mount it (iso9660 udf XA) etc. It should just
> work.
> 
> The question is where to fix it?  If it is possible to do in the kernel
> it should be done there.  If it nees to be done in userspace then where
> in userspace does this need to be fixed?  I am willing to help but know
> not where to start.
> 
> Thanks
> 
> Grahame Jordan
> 
> On Wed, 2002-01-02 at 02:24, Alan Cox wrote:
> > > Windows, somehow, detects the difference.  Whatever method used by Windows
> > > will be the one tested by the makers of most DVD/CDROM's.
> >
> > Actually half of the copy protected CD thing relies on the fact windows does
> > not get its decisions right.
> >
> > > If the distinction is something that can be automated well, then what is
> > > the argument against doing it?
> >
> > Certainly relevant - but for the kde file manager and gnome nautilus lists
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> --
> Grahame Jordan
> TheForce

-- 
Hi! I'm a do-it-yourself virus... please delete 4 files at random
from your hard drive.  Pass me on to all your friends.
