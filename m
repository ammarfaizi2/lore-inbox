Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTJVVo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 17:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTJVVo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 17:44:26 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:15566
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261190AbTJVVoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 17:44:06 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: grendel@caudium.net
Subject: Re: [2.6.0-test8] swsusp errors (was: Wow.  Suspend to disk works for me in test8.)
Date: Wed, 22 Oct 2003 16:40:50 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200310200225.11367.rob@landley.net> <200310201556.43520.rob@landley.net> <20031022184358.GB1453@thanes.org>
In-Reply-To: <20031022184358.GB1453@thanes.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310221640.50711.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 October 2003 13:43, Marek Habersack wrote:
> On Mon, Oct 20, 2003 at 03:56:43PM -0500, Rob Landley scribbled:
> > On Monday 20 October 2003 05:45, Voicu Liviu wrote:
> > > Rob Landley wrote:
> > > >Good grief.  It worked.
> > > >
> > > >echo -n disk > /sys/power/state
> > >
> > > How long does it take to do suspend to disk?
>
> [snip]
>
> > you resume (ouch).  And because of that, things that should time out and
> > renew themselves (like dhcp leases) have to be thumped manually.
> >
> > But other than that... :)
>
> I've had some problems with swsusp, alas. Suspending worked perfectly, but
> resuming resulted in a series of call traces and the network interfaces
> being unreachable:

Apparently, it likes this particular set of hardware:

00:00.0 Host bridge: ALi Corporation M1621 (rev 01)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (rev 01)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:13.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 5d)

My pad of thinkness.  As long as I don't have the lid closed while I suspend, 
anyway.  (It can shutdown with the lid closed just fine.  My guess is that 
closing the lid powers down the video hardware, and when suspend tries to 
power down the video hardware it gets confused.  This is just a guess, I have 
to stick beeps in the code to see what it's actually doing, and that's pretty 
far down on my to-do list since I have a reliable "don't do that then" 
workaround...)

Rob
