Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSEQSaN>; Fri, 17 May 2002 14:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316638AbSEQSaM>; Fri, 17 May 2002 14:30:12 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48145
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314284AbSEQSaL>; Fri, 17 May 2002 14:30:11 -0400
Date: Fri, 17 May 2002 11:29:42 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Thoughts on using fs/jbd from drivers/md
Message-ID: <20020517182942.GF627@matchmail.com>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <15587.18828.934431.941516@notabene.cse.unsw.edu.au> <20020516161749.D2410@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 04:17:49PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, May 16, 2002 at 03:54:20PM +1000, Neil Brown wrote:
> > The basic idea is to provide journaling for md/RAID arrays.  There
> > are two reasons that one might want to do this:
> >  1/ crash recovery.  Both raid1 and raid5 need to reconstruct the
> >    redundancy after a crash.  For a degraded raid5 array, this is not
> >    possible and you can suffer undetected data corruption.
> >    If we have a journal of recent changes we can avoid the
> >    reconstruction and the risk of corruption.
> 
> Right.  The ability of soft raid5 to lose data in degraded mode over a
> reboot (including data that was not being modified at the time of the
> crash) is something that is not nearly as widely understood as it
> should be, and I'd love for us to do something about it.

Are there workarounds to avoid this problem?

What does it take to trigger the corruption?

I ask this because I have used a degraded raid5 because the source drive
would become a member, but I needed to copy the data first.  While doing so,
I had to reboot a couple times to reconfigure the boot loader.  All seems to
be working fine on the system today though.

Thanks,

Mike
