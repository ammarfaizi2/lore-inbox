Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132472AbRCZQgx>; Mon, 26 Mar 2001 11:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132473AbRCZQgn>; Mon, 26 Mar 2001 11:36:43 -0500
Received: from hercules.telenet-ops.be ([195.130.132.33]:49576 "HELO
	smtp1.pandora.be") by vger.kernel.org with SMTP id <S132472AbRCZQg2>;
	Mon, 26 Mar 2001 11:36:28 -0500
Date: Mon, 26 Mar 2001 18:56:41 +0200
From: wing tung Leung <tg@skynet.be>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine driver: wicked 2005 problem
Message-ID: <20010326185641.A19619@skynet.be>
In-Reply-To: <3ABEEAFE.81CA76A3@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3ABEEAFE.81CA76A3@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 09:08:46AM +0200, Manfred Spraul wrote:
> > [Kernel 2.4.2,
> 
> the -ac kernels contain a patch that automatically resets the nic if it
> dies. I've attached my old patch, it applies to 2.4.2.
 
Your patch works fine for resetting the NIC. There are some a one or two
log messages coming up, but the transfer continues after a small delay.

It doesn't solve the (less urgent) problem of not being able the use the
NIC after a warm boot in M$ Windows. As I said, pulling the power cord from
the ATX power supply and reinserting it, makes it go away.

> > I tried the diagnostic utilities from Donald Becker at Scyld.com,
> > but I don't  know what I should be looking for. The text output
> > seems ok to me. 
> >
> Could you post the output?
> And a few more lines from your kernel log.

It's rather much to post the the mailing list, I think, so I've put it online
at [http://win-www.uia.ac.be/u/s965817/via-rhine.report/]. If you prefer
otherwise, just tell me. I can always send a tarball of the logs.

Some explanation of the logs:

report: script for creating the device status dumps
hang/:      about the "timed out" problem receiving much data
    242/:      using the default module from 2.4.2 release
         before/:   device status before the lock, while NIC works well
         after/:    device status after the lock, during timeout messages
    242patch/: using the patched version
         before/:   device status before the timeout or wicked messages
         after/:    device status afterwards (NIC keeps working fine)
windoze:/   about the warm-boot-after-windoze problem
    winboot/:  device info booting after warm boot (problem case)
    coldboot/: device info booting after total cold boot (no problem)


Thanks a lot for the patch.

Tung

