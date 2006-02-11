Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWBKPRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWBKPRL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWBKPRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:17:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1173 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932312AbWBKPRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:17:10 -0500
Date: Sat, 11 Feb 2006 16:16:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Phillip Susi <psusi@cfl.rr.com>
cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git
In-Reply-To: <43ED04E9.9040900@cfl.rr.com>
Message-ID: <Pine.LNX.4.61.0602111614050.17942@yvahk01.tjqt.qr>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com>
 <20060210210006.GA5585@stiffy.osknowledge.org> <43ED04E9.9040900@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> If that is what is going on, there is nothing linux can do about it; it's a
> limitation of the hardware.  The IDE controller can only accept one command at
> a time, so if that command takes a while to complete, the other drive on the
> same channel can not be accessed until the first command completes. 

CD blanking only takes "one" command for the whole operation, as 
e.g. compared to CD writing where you always have to push out data packets.

Why I think it's just one (note the quotes): You can interrupt/kill 
cdrecord in the midst of blanking a CD, and blanking will continue to the 
'end' (either fast blank or full blank, whichever was sent)

As mentioned some time earlier, I had similar, but not the same issues. I 
could continue accessing the harddrive - otherwise mplayer would have 
stopped immediately, but it played at least until EOF.

> If the system doesn't come back though after sufficient time has gone by for
> the burn to complete, then this is probably not what is happening.  I'd suggest
> using magic-sysreq to force an unmount and reboot, then see if there's anything
> in the logs. 


Jan Engelhardt
-- 
