Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281163AbRKTXgT>; Tue, 20 Nov 2001 18:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKTXgJ>; Tue, 20 Nov 2001 18:36:09 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36857 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281163AbRKTXfz>;
	Tue, 20 Nov 2001 18:35:55 -0500
Date: Tue, 20 Nov 2001 16:35:23 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jason Tackaberry <tack@auc.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File size limit exceeded with mkfs
Message-ID: <20011120163523.F1308@lynx.no>
Mail-Followup-To: Jason Tackaberry <tack@auc.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1006272138.1263.3.camel@somewhere.auc.ca> <20011120113316.R1308@lynx.no> <1006288154.1863.0.camel@somewhere.auc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1006288154.1863.0.camel@somewhere.auc.ca>; from tack@auc.ca on Tue, Nov 20, 2001 at 03:29:14PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2001  15:29 -0500, Jason Tackaberry wrote:
> On Tue, 2001-11-20 at 13:33, Andreas Dilger wrote:
> > Several people have reported problems like this also.  What happens is
> > that if you are logged on as a user, then su to root, it will fail.  If
> > you log in directly as root, it will work.
> 
> Yep, this is indeed the case.
> 
> > Can you please try some intermediate kernels (2.4.10 would be a good
> > start, because it had some major changes in this area, and then go
> > forward and back depending whether it works or not).
> 
> 2.4.10 does NOT work.
> 2.4.9 DOES work.
> 
> So clearly something happened in 2.4.10 which broke this.  Please let me
> know if I can be of any more help.

That is unfortunate, since a lot of things changed in 2.4.10, so it will
make tracking the change hard.  Yet, I am running 2.4.13 and have no such
problems (well, at least I think not).  I don't have a spare partition >
2GB, but I can do the following without problems, which _should_ be the
same thing:

dd if=/dev/vgtest/lv of=/dev/vgtest/lv bs=4k skip=1100k seek=1100k count=1

(i.e. it reads a block and writes a block from > 4GB offset in the file,
and I can do this when logged in as a non-root user, which has write
access to the disk, and also when su'd to root, just in case).

Can you try the above test, just to confirm that it is equivalent to your
mkfs test?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

