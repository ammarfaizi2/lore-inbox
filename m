Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277278AbRJJP4J>; Wed, 10 Oct 2001 11:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277293AbRJJPz6>; Wed, 10 Oct 2001 11:55:58 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:59389 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277285AbRJJPzl>; Wed, 10 Oct 2001 11:55:41 -0400
Date: Wed, 10 Oct 2001 09:55:36 -0600
From: "'adilger@turbolabs.com'" <adilger@turbolabs.com>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'xuan--lkml@baldauf.org'" <xuan--lkml@baldauf.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: dynamic swap prioritizing
Message-ID: <20011010095536.C10443@turbolinux.com>
Mail-Followup-To: Venkatesh Ramamurthy <Venkateshr@ami.com>,
	"'xuan--lkml@baldauf.org'" <xuan--lkml@baldauf.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9E013@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9E013@ATL_MS1>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 10, 2001  11:23 -0400, Venkatesh Ramamurthy wrote:
> > If this is to be generally useful, it would be good to find things
> > like max sequential read speed, max sequential write speed, and max
> > seek time (at least). Estimates for max sequential read speed and
> > seek time could be found at boot time for each disk relatively
> > easily, but write speed may have to be found only at runtime (or
> > it could all be fed in to the kernel from user space from benchmarks
> > run previously).
> 
> Maybe we can find out the statistics for the first time (or when swap is
> created) and store this information in the swap partition itself. This would
> allow us to compute time consuming statistics only once. Also we need to
> create new fields in the swap structure for this purpose.

I'd rather just have the statistic data in a regular file for ALL disks,
and then send it to the kernel via ioctl or write to a special file that
the kernel will read from.  I don't think it is critical to have this
data right at boot time, since it would only be used for optimizing I/O
access and would not be required for a disk to actually work.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

