Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUEQTmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUEQTmu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUEQTmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:42:50 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:35968
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262476AbUEQTmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:42:36 -0400
From: Rob Landley <rob@landley.net>
To: Daniele Venzano <webvenza@libero.it>
Subject: Re: [PATCH] sis900 fix (Was: [CHECKER] Resource leaks in driver shutdown functions)
Date: Tue, 11 May 2004 12:35:09 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <3580.171.64.70.92.1083609961.spork@webmail.coverity.com> <200405061223.40942.rob@landley.net> <20040507150637.GB12798@picchio.gall.it>
In-Reply-To: <20040507150637.GB12798@picchio.gall.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405111235.09559.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 May 2004 10:06, Daniele Venzano wrote:
> On Thu, May 06, 2004 at 12:23:40PM -0500, Rob Landley wrote:
> > Does this fix the problem where you unplug the cat 5 cable from an SiS900
> > and then plug it back in (toggling the MII tranciever link detect status
> > and all that), and the device goes positively mental until you reboot the
> > system? (Packets randomly dropped or delayed for up to 15 seconds, and
> > arriving out of sequence with horrible impacts on performance?)
> >
> > I tried pursuing this when I first noticed it circa 2.4.4, but as you
> > say, the driver is unmaintained and I haven't got specs (or any clue
> > about) the chipset...
>
> I was not aware of this problem, the driver is slow to recognize the
> link status of the interface and often needs sending some packets before
> switching to link status on. But on my sis900 (on a laptop) I never
> observed a behavior similar to yours.
>
> The patch I submitted is a small fix in the power management code, so
> it's very unlikely that it fixes anything in the link detection,
> please also note that the patch is for kernels 2.6.x.

I've been using 2.6 exclusively since 2.6.0-test3.  Booted back into 2.4 a 
couple times for debugging purposes in 2003, but I haven't even had a 2.4 
kernel on my laptop since new year's.  (Well, source tarball...)

> The driver in 2.6 has some small differencies that probably are fixes
> never backported, is the driver in 2.4 also broken for other people ?
> Are you using the 2.6 or 2.4 driver ?

The problems were all with servers using the 2.4 driver.  I've got a machine 
in pieces upstairs with an SIS900 controller built into the motherboard, I 
can assemble that and give it a whack at some unspecified point in the 
future.  Also the machine my website and email are on has an SIS900 
on-motherboard controller connecting it to its DSL line, but that's in 
Pennsylvania and a bit difficult to debug at present.

I'll see if the problem persists under 2.6.6.

> Thanks for the feedback.

Thanks for actually taking a toothbrush to the sis900 driver.

Rob


