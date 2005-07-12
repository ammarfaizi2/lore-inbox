Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVGLOJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVGLOJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVGLOJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:09:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:18395 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261573AbVGLOHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:07:04 -0400
Date: Tue, 12 Jul 2005 16:05:16 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       George Anzinger <george@mvista.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org, torvalds@osdl.org,
       christoph@lameter.org
Subject: Re: i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050712133018.GA8467@ucw.cz>
Message-ID: <Pine.LNX.4.61.0507121546160.8594@yvahk01.tjqt.qr>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <42D310ED.2000407@mvista.com>
 <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org>
 <20050712133018.GA8467@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> >     HZ   ticks/jiffie  1 second      error (ppm)
>> > ---------------------------------------------------
>> >    100      11932      1.000015238      15.2

I was not quite able to reproduce these values, probably because I got the
math wrong. I used:
  $oneSecond = $ticksJiffie * $HZ / 1193182
which yields 11932*100/1193182 = 1.00001508571198693912, !=1.000015238
Math corrections welcome.

Anyway, I've done some graphs. Intersting that the smaller the HZ, the less
error (seen on a whole, esp. view_1k and view_8k.png) we get. 20Hz seems to
be the 0.0 case, and 18Hz is not bad either. IIRC, DOS used 18HZ ;)
http://jengelh.hopto.org/tick/




Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/

