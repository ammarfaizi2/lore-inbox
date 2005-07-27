Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVG0WCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVG0WCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVG0WAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:00:15 -0400
Received: from fsmlabs.com ([168.103.115.128]:50873 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261179AbVG0V6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:58:15 -0400
Date: Wed, 27 Jul 2005 16:03:27 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: "Brown, Len" <len.brown@intel.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Variable ticks
In-Reply-To: <1122496987.22844.3.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0507271602400.17956@montezuma.fsmlabs.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300424AC59@hdsmsx401.amr.corp.intel.com>
  <1122326750.1472.46.camel@mindpipe>  <Pine.LNX.4.61.0507270212080.7784@montezuma.fsmlabs.com>
 <1122496987.22844.3.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005, Lee Revell wrote:

> On Wed, 2005-07-27 at 02:13 -0600, Zwane Mwaikambo wrote: 
> > > What about audio?  If there is a sound server running then you're going
> > > to have a constant stream of interrupts and DMA activity from the sound
> > > card even if the machine is idle and there aren't any sounds playing.
> > 
> > Doesn't artsd at least close the audio device after some configurable idle 
> > time? In which case that sounds like a userspace issue.
> 
> Well, as of ALSA 1.0.9 which does software mixing and volume control by
> default, all the sound servers are obsolete.  So this should be a
> non-issue with a modern distro.
> 
> As far as legacy support, AFAIK esd and artsd both grab the sound device
> on startup and never release it.

I just setup KDE/artsd to release the sound device after 30seconds and it 
seems to work.
