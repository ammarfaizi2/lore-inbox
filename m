Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUDGLEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUDGLEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:04:06 -0400
Received: from [80.72.36.106] ([80.72.36.106]:32222 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262794AbUDGLEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:04:02 -0400
Date: Wed, 7 Apr 2004 13:03:57 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
In-Reply-To: <20040407105522.GN20293@charite.de>
Message-ID: <Pine.LNX.4.58.0404071300250.10871@alpha.polcom.net>
References: <200404071222.21397.rjwysocki@sisk.pl>
 <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net> <20040407103934.GG20293@charite.de>
 <Pine.LNX.4.58.0404071247120.10871@alpha.polcom.net> <20040407105522.GN20293@charite.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, Ralf Hildebrandt wrote:

> * Grzegorz Kulewski <kangur@polcom.net>:
> 
> > > input: AT Translated Set 2 keyboard on isa0060/serio0
> > > input: AT Translated Set 2 keyboard on isa0060/serio0
> > > input: AT Translated Set 2 keyboard on isa0060/serio0
> > > input: AT Translated Set 2 keyboard on isa0060/serio0
> > > input: AT Translated Set 2 keyboard on isa0060/serio0
> > > input: AT Translated Set 2 keyboard on isa0060/serio0
> > 
> > Did you see these messages 6 times at once?
> 
> No, I'm quite sure they happen sporadically. See:
> 
> # uptime
> 12:53:58 up 7 days,  4:14,  2 users,  load average: 3.12, 2.46, 1.93
> 
> # grep "input: AT Translated Set" syslog
> Apr  7 09:19:05 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 09:19:43 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 09:19:49 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 09:35:18 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 09:35:48 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 09:39:08 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 09:43:01 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 09:56:38 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 11:14:13 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 11:28:41 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 11:35:44 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 11:36:24 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 11:47:17 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> Apr  7 12:38:31 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> 
> > Was it after the boot process ended? 
> 
> Yes. See above.
> 
> > They only appear at boot time for me (just once of course). Maybe 
> > your keyboard was disconnected or kernel was thinking that it was 
> > disconnected and connected again?...
> 
> Nope. It's a laptop!

Ok, so it was connected (but it can still have not full electrical 
contact...).

But kernel (because of some bug) can think it was reconnected and 
initialize the driver second time making kb unusable... Can't it?


Grzegorz

