Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263108AbRE1Rp5>; Mon, 28 May 2001 13:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263109AbRE1Rpq>; Mon, 28 May 2001 13:45:46 -0400
Received: from dewey.mindlink.net ([204.174.16.4]:18443 "EHLO
	dewey.paralynx.net") by vger.kernel.org with ESMTP
	id <S263108AbRE1Rp3>; Mon, 28 May 2001 13:45:29 -0400
Subject: [SOLVED] PROBLEM: Alpha SMP Low Outbound Bandwidth
From: Jay Thorne <Yohimbe@userfriendly.org>
To: George France <france@handhelds.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>
In-Reply-To: <01052523163402.28075@shadowfax.middleearth>
In-Reply-To: <990827407.27355.2.camel@gracie.userfriendly.org>
	<990836703.27355.6.camel@gracie.userfriendly.org>
	<20010526025119.L9634@athlon.random> 
	<01052523163402.28075@shadowfax.middleearth>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 28 May 2001 10:45:22 -0700
Message-Id: <991071923.25870.0.camel@gracie.userfriendly.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved, thanks to the rawhide patch from Richard Henderson
(rth@twiddle.net) posted on Sunday. Performance is ~10megs/second both
directions, using tulip, de4x5 or via-rhine.

Using 2.4.4-ac15 it works fine. I'm now trying 2.4.5

Andrea, 2.4.5aa1 oopses just after probing the scsi cards. I've tried
the 2.4.4 series aa patches and had similar failure on boot. 

Its too fast to see the error, so I'm building a serial console version
to capture it. Is an easy way to tell an alpha to stop dead so I can
copy the oops?


On 25 May 2001 23:16:34 -0400, George France wrote:
> Hello Andrea,
> 
> Jay, if the problem still exist in 2.4.5-pre6aa1 (please try the new kernel), 
> then I will have tech op's check this on Tuesday (Monday is a US holiday).  
> We should be able to duplicate this in the hardware lab and find the problem 
> with a logic analyser.
> 
> Best Regards,
> 
> 
> --George
> 
> On Friday 25 May 2001 20:51, Andrea Arcangeli wrote:
> > On Fri, May 25, 2001 at 05:25:03PM -0700, Jay Thorne wrote:
> > > But Wu-ftpd is an easy to set up test bench, and is ubiquitous enough
> > > that anyone with an alpha running SMP can test it. Note that this
> >
> > My smp alpha box drives a single tulip over 12MB/sec in full duplex
> > using tcp without any problem at all. So I definitely cannot reproduce.
> > You may want to try to reproduce with 2.4.5pre6aa1 btw. If you've not
> > tried it yet you can consider also using egcs 1.1.2 as compiler just in
> > case.
> >
> > You may also want to keep an eye on the VM, on alpha I see very weird
> > things happening.
> >
> > Andrea
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
--
Jay Thorne Manager, Systems & Technology, UserFriendly Media, Inc.

