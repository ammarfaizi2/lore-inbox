Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbTGEV6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbTGEV6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:58:21 -0400
Received: from smtp.terra.es ([213.4.129.129]:62302 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id S266519AbTGEV6Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:58:16 -0400
Date: Sun, 6 Jul 2003 00:11:36 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-Id: <20030706001136.3a423b29.diegocg@teleline.es>
In-Reply-To: <200307052309.12680.phillips@arcor.de>
References: <20030703023714.55d13934.akpm@osdl.org>
	<200307051728.12891.phillips@arcor.de>
	<20030705121416.62afd279.akpm@osdl.org>
	<200307052309.12680.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 5 Jul 2003 23:09:12 +0200 Daniel Phillips <phillips@arcor.de>
escribió:

> The "better" mechanism for sound scheduling is SCHED_RR, which requires
> root privilege for some reason that isn't clear to me.  Or maybe there
> once was a good reason, back in the days of the dinosaurs.

I don't think mp3 playing needs nothing special.

Mp3 decoding on today's computers taks insignificant amounts of cpu time.
Having mp3 skips even in light loads in a 2x800 box seems just
unacceptable. 
If you allow users using SCHED_RR, every app will end using it.
But you can renice all other apps at +5. 

Scheduler's behaviour has been much better in the past, i don't
think it requires anything special, just fixing the bug.

But if you want to hear mp3 under crazy loads; perhaps you'd want to use
the SCHED_RR part. 
Personally I'd like to be able to hear mp3 always, no matter if there's a
heavy load in the machine. Mp3 playing is _important_ for me, i don't care
about the rest :) (xmms supports realtime, but you need root)
