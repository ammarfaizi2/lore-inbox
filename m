Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273413AbRIRTPf>; Tue, 18 Sep 2001 15:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273414AbRIRTPZ>; Tue, 18 Sep 2001 15:15:25 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:35833 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S273413AbRIRTPM>; Tue, 18 Sep 2001 15:15:12 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 18 Sep 2001 13:14:19 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918131419.A14526@turbolinux.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alexander Viro <viro@math.psu.edu>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0109181354470.27125-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0109181122550.9711-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109181122550.9711-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 18, 2001  11:27 -0700, Linus Torvalds wrote:
> I agree that the timing may leave something to be desired. But we had the
> discussion about fixing pagecache-bdev consistency wrt the regular buffer
> cache filesystem accesses a week or so ago, and the fact is that nobody
> really seems to have started working on it - because everybody felt that
> you have to get everything done at once.

The real question is why can't we just open 2.5 and only fix the VM to
start with?  Leave the kernel at 2.4.10-pre10, and possibly use the -ac
VM code (which has diverged from mainline), and leave people (Alan, Ben,
Marcello, et. al.) who want to tinker with it in small increments and
do the drastic stuff in 2.5.

Make it clear that 2.5 is still ONLY for VM and other bug fixes at this
point, and not all of the long-awaited 2.5 rework YET.  If it turns
out that the VM fixes are done quickly, then they can be back-ported
to 2.4.  If it takes longer than expected you can open 2.5 up to general
development.

With the right "management" it will be not much different than the current
situation, except that people won't have fits about such huge changes
going into 2.4.  I think this is your subconcious telling you that you
really wanted to start 2.5 a month ago.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

