Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWAFAJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWAFAJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWAFAJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:09:26 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:60324 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932310AbWAFAJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:09:24 -0500
Date: Fri, 6 Jan 2006 01:09:21 +0100
From: Tino Keitel <tino.keitel@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No Coax digital out with SB Live! and 2.6.15
Message-ID: <20060106000921.GA4867@localhost.localdomain>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	linux-kernel@vger.kernel.org
References: <20060103180831.GA5265@localhost.localdomain> <20060104072618.GA10973@localhost.localdomain> <20060104073617.GA15342@localhost.localdomain> <1136498477.847.52.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136498477.847.52.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 17:01:17 -0500, Lee Revell wrote:
> On Wed, 2006-01-04 at 08:36 +0100, Tino Keitel wrote:
> > On Wed, Jan 04, 2006 at 08:26:18 +0100, Tino Keitel wrote:
> > > On Tue, Jan 03, 2006 at 19:08:31 +0100, Tino Keitel wrote:
> > > > Hi folks,
> > > > 
> > > > since I upgraded to 2.6.15, the Coax digital output of my SB Live!
> > > > stays silent. Analog output works. After reverting to 2.6.14.3 the
> > > > digital output works again. Does anyone have a solution for this or at
> > > > least the same problem?
> > > 
> > > I just tried alsa-driver 1.0.11-rc2 and now the digital out works again.
> > 
> > alsa-driver 1.0.10 works, too.
> 
> Are you sure it was not a mixer settings issue?
> 
> If you can confirm that this is a regression try to narrow it down by
> code inspection or binary search by date with ALSA CVS it can be fixed
> for 2.6.15.x.

I booted with the 2.6.15 driver and got a silent digital out, like
reported. The headphone which is plugged into the analog output gives
sound.

If I load the 1.0.10 driver, sound works in xmms. If I unload it and
reload the original 2.6.15 driver, sound still works. If I reboot with
the original 2.6.15 driver, the digital out is silent again, while the
analog output works.

However, if I now chose a specific output device in xmms, hw:0,2,
instead of the default device, digital out gives sound. With the 1.0.10
driver, this hw:0,2 device stays completely silent (digital and
analog). With this version, the hw:0,0 device (which seems to be the
default) gives analog and digital sound.

So IMHO this mixup of the devices is a regression, since it breaks
existing setups and is also fixed in newer versions. It would be nice
the see a fix for this in 2.6.15.x.

Regards,
Tino

