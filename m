Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313947AbSDZM7A>; Fri, 26 Apr 2002 08:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313943AbSDZM66>; Fri, 26 Apr 2002 08:58:58 -0400
Received: from gwsmtp.thomson-csf.com ([195.101.39.226]:3335 "EHLO
	gwsmtp.thomson-csf.com") by vger.kernel.org with ESMTP
	id <S313947AbSDZM6b> convert rfc822-to-8bit; Fri, 26 Apr 2002 08:58:31 -0400
Message-ID: <3CC58155000078A8@bgxplex3.bgx.airsys.thomson-csf.com> (added by
	    postmaster@bgxplex3.bgx.airsys.thomson-csf.com)
Content-Type: text/plain; charset=US-ASCII
From: Nicolas Bonnefon <nicolas.bonnefon@fr.thalesgroup.com>
Organization: Thales Air Defence
To: Eldor =?iso-8859-1?q?R=F8dseth?= (ETO) 
	<Eldor.Rodseth@eto.ericsson.se>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: SCHED_FIFO and SCHED_RR in 2.4.7-10custom kernel
Date: Fri, 26 Apr 2002 14:52:24 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <F9CC1B4C20A0D411A99E00508BDFA6A203D8AB00@enoasnt101.eto.ericsson.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My application uses the possibility to change scheduling mechanism. When
> changing from SCHED_OTHER to SCHED_FIFO or SCHED_RR, my application causes
> the whole Linux PC to "hang". Prior to launching my own application, I
> launch a "superbash" application with higher priority than my own
> application. But I am not able to switch to the window where this
> "superbash" application is running to kill my own application. The PC
> simply does not respond to any input from the keyboard.

Have you tried without running X ?
A SCHED_FIFO or SCHED_RR task has ALWAYS priority over any SCHED_OTHER
task, so if your application sits in an infinite loop without blocking, the 
window manager cannot preempt it and you simply cannot switch x-term.
I think you should carefully debug your app in SCHED_OTHER mode first, and 
then switch to some real-time policy.

>
> I have used this mechanism before, and I am quite confident that this
> worked under kernel 2.4.2. Are you aware of anything that could explain
> this behaviour?

It would be surprising, but if you were sure of that, it would deserve some 
deeper investigations !

Regards
-- 
Nicolas Bonnefon
Radar Development/Digital Processing Engineer
Thales Air Defence - 7-9 rue des Mathurins
92223 Bagneux - France
