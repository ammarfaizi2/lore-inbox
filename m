Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277735AbRJRPGo>; Thu, 18 Oct 2001 11:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277746AbRJRPGe>; Thu, 18 Oct 2001 11:06:34 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:14585 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277740AbRJRPG0>; Thu, 18 Oct 2001 11:06:26 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 18 Oct 2001 09:06:46 -0600
To: linux-kernel@vger.kernel.org, forming@home.com
Subject: Re: Fwd: VM testing with mtest, 2.4.12-ac3, 2.4.12-ac3+riel's patches, and 2.4.13aa1
Message-ID: <20011018090646.B1144@turbolinux.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, forming@home.com
In-Reply-To: <20011018015112.A3763@cy599856-a.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018015112.A3763@cy599856-a.home.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2001  01:51 -0500, Josh McKinney wrote:
> This is a report of the mtest01 scripts posted by rwhron@earthlink.net
> a day orso ago.
> 
> The numbers are rather interesting.  While the latency of the ac kernels is
> definitely better, the song only dropped out for a second or two in the
> begining but that was it.  The aa kernel drops out more frequently throughout
> the test, but the amount of memory allocated is almost twice as much as with
> the ac kernels.

-ac kernel:
> Averages for 10 mtest01 runs
> bytes allocated:                    134427443.2
> User time (seconds):                2.546
> System time (seconds):              1.370
> Elapsed (wall clock) time:          4.798
> Percent of CPU this job got:        89.1%
> Major (requiring I/O) page faults:  103.8
> Minor (reclaiming a frame) faults:  32702

-ac kernel + Rik's patches:
> Averages for 10 mtest01 runs
> bytes allocated:                    124885401.6
> User time (seconds):                2.380
> System time (seconds):              1.253
> Elapsed (wall clock) time:          4.401
> Percent of CPU this job got:        89.1%
> Major (requiring I/O) page faults:  100.2
> Minor (reclaiming a frame) faults:  30363.3

Linus kernel:
> Averages for 10 mtest01 runs
> bytes allocated:                    288148684.8
> User time (seconds):                5.496
> System time (seconds):              3.003
> Elapsed (wall clock) time:          12.250
> Percent of CPU this job got:        68.9%
> Major (requiring I/O) page faults:  103.5
> Minor (reclaiming a frame) faults:  70380.6

Note that the Linus kernel has allocated twice as much memory.  What does that
mean exactly?  The user/system/wall time is also twice as high.  Somehow I
don't think you are having an equal test.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

