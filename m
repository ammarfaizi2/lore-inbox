Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbTGHAvg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbTGHAvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:51:36 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:19666 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S265943AbTGHAvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:51:35 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: 2.5.74-mm1
Date: Tue, 8 Jul 2003 03:07:18 +0200
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703023714.55d13934.akpm@osdl.org> <200307080213.53203.phillips@arcor.de> <Pine.LNX.4.55.0307071724540.3524@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307071724540.3524@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307080307.18018.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 July 2003 02:29, Davide Libenzi wrote:
> On Tue, 8 Jul 2003, Daniel Phillips wrote:
> > On Tuesday 08 July 2003 00:03, Davide Libenzi wrote:
> > > > > Try to play with SNDCTL_DSP_SETFRAGMENT. Last time I checked the
> > > > > kernel let you set a dma buf for 0.5 up to 1 sec of play (upper
> > > > > limited by 64Kb). Feeding the sound card with 4Kb writes will make
> > > > > you skip after about 50ms CPU blackout at 44KHz 16 bit. RealPlayer
> > > > > uses 16Kb feeding chunks that makes it able to sustain up to 200ms
> > > > > of blackout.
> > > >
> > > > That's just fiddling, it doesn't deal with the basic problem. 
> > > > Anyway, big buffers have their own annoyances.  Have you tried the
> > > > graphic equalizer in xmms lately?  A one second lag on slider
> > > > adjustment is not nice.
> > >
> > > That's not fiddling. It is tuning your app so that it won't require
> > > realtime when it is not needed.
> >
> > But realtime is needed, because there is a deadline for each buffer-fill.
>
> Yes, in theory it is needed since you have to meet a deadline. But if
> you program you timings such that your deadline is 400-500ms it is really
> hard to lose it against one of 50-100ms.

1. 400ms buffers are hated by users, as was noted previously.  They are 
passable for some applications, but way too laggy for others.

2. Even if you are will to have a 400-500 ms buffer, if you can prove that you 
will always meet that deadline, then it's a realtime system.

3. If you can show logically that you will nearly always meet the deadline, 
it's a soft realtime system.  That's what we're after here.  From a design 
standpoint, there are elegant soft realtime systems, and there are sucky 
ones.

4. So how do you propose to "program timings" so that it's really hard to miss  
those deadlines?

Regards,

Daniel

