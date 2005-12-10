Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVLJATV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVLJATV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVLJATV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:19:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41592 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932521AbVLJATU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:19:20 -0500
Date: Fri, 09 Dec 2005 19:19:19 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: spitz: Real time clock?
In-reply-to: <20051209225312.GF4658@elf.ucw.cz>
X-X-Sender: nico@localhost.localdomain
To: Pavel Machek <pavel@suse.cz>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       kernel list <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0512091915090.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_E/jM5vtuHWojWOIU61J0HQ)"
References: <20051209212850.GE4658@elf.ucw.cz>
 <1134167947.8092.116.camel@localhost.localdomain>
 <20051209225312.GF4658@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_E/jM5vtuHWojWOIU61J0HQ)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Fri, 9 Dec 2005, Pavel Machek wrote:

> On Pá 09-12-05 22:39:06, Richard Purdie wrote:
> > On Fri, 2005-12-09 at 22:28 +0100, Pavel Machek wrote:
> > > Is there driver for real time clock for spitz? I seem to get default
> > > time each time I boot. (And thats bad because means fsck "too much time
> > > since last check, check forced).
> > 
> > There is but its already included with the kernels you have. It doesn't
> > survive reboots and this is a limitation of the PXA processor. There's
> > not a lot we can do about it I'm afraid.
> 
> Ouch, that's bad :-(. So PXA can't keep time properly...

The RTC count is lost on a hard reset.  It survives sleep mode though.

The fact is that PocketPC/WinCE is not meant to be "rebooted" and the 
RTC on the PXA was probably designed with that fact.  The normal usage 
pattern is to go into sleep mode all the time.

> could we do something like storing time on system shutdown and 
> restoring it on bootup? That way at least time will be monotonic... 
> Ok, that's userland problem.

I'd say so.

> Is there way to reboot without "really" rebooting? That would help at
> least in my usage case.

You should be able to "soft" reboot which will also preserve the RTC 
count.


Nicolas

--Boundary_(ID_E/jM5vtuHWojWOIU61J0HQ)--
