Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVG0UrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVG0UrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVG0UpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:45:01 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55732 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262433AbVG0UnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:43:12 -0400
Subject: RE: Variable ticks
From: Lee Revell <rlrevell@joe-job.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Brown, Len" <len.brown@intel.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0507270212080.7784@montezuma.fsmlabs.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300424AC59@hdsmsx401.amr.corp.intel.com>
	 <1122326750.1472.46.camel@mindpipe>
	 <Pine.LNX.4.61.0507270212080.7784@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 16:43:07 -0400
Message-Id: <1122496987.22844.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 02:13 -0600, Zwane Mwaikambo wrote: 
> > What about audio?  If there is a sound server running then you're going
> > to have a constant stream of interrupts and DMA activity from the sound
> > card even if the machine is idle and there aren't any sounds playing.
> 
> Doesn't artsd at least close the audio device after some configurable idle 
> time? In which case that sounds like a userspace issue.

Well, as of ALSA 1.0.9 which does software mixing and volume control by
default, all the sound servers are obsolete.  So this should be a
non-issue with a modern distro.

As far as legacy support, AFAIK esd and artsd both grab the sound device
on startup and never release it.

Lee

