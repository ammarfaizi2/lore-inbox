Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272927AbRIHAyD>; Fri, 7 Sep 2001 20:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272928AbRIHAx4>; Fri, 7 Sep 2001 20:53:56 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:17144
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S272927AbRIHAxi>; Fri, 7 Sep 2001 20:53:38 -0400
Date: Fri, 7 Sep 2001 17:53:52 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: VM improvement in -ac [was: "Cached" grows and grows and grows...]
Message-ID: <20010907175352.U29607@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010907191349.457cad95.skraw@ithnet.com> <E15fTuS-0002g1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15fTuS-0002g1-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 11:15:36PM +0100, Alan Cox wrote:
> > To tell you the honest truth: you are not alone in cosmos (with this problem)
> > ;-)
> > To give you that explicit hint for saving money: do not buy mem, it will be
> > eaten up by recent kernels without any performance gain or other positive
> > impact whatsoever. 
> 
> Pick up a 2.4.9-ac kernel, and you shouldnt be seeing the problem (I say
> shouldnt, I'm not 100% convinced its all under control)
> 

I have to agree for the most part.  My system used to use a lot of cache,
and swapped all of the time with 300+MBs of ram on a Linus 2.4 kernel, now with
-ac my swap is under 1kB with the same apps and load.  I can even run ext3
now without another patch :).

One thing I have noticed is that I still see my system accessing the drive
softly for about 30 second time periods a few times a day.  I didn't see
this on 2.2, and vmstat doesn't show any paging traffic, but it does show
about 48 avg pages/sec going out to the disk.  I haven't really looked very
hard to find the culprit.  Has anyone else noticed this?

[OT] Hmm, why isn't ext3 in the Linus kernel yet?  It seems more mature than
reiserfs was when it was included back in 2.4.1...
