Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVAKNLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVAKNLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 08:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVAKNLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 08:11:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63925 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262660AbVAKNLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 08:11:43 -0500
Date: Tue, 11 Jan 2005 14:10:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Bernard Blackham <bernard@blackham.com.au>, Pavel Machek <pavel@ucw.cz>,
       Shaw <shawv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050111131019.GA1324@openzaurus.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net> <20050110074422.GA17710@mussel> <20050110105759.GM1353@elf.ucw.cz> <20050110174804.GC4641@blackham.com.au> <20050111001426.GF1444@elf.ucw.cz> <20050111011611.GE4641@blackham.com.au> <16867.51258.916944.195917@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16867.51258.916944.195917@alkaid.it.uu.se>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hia

>  > Looking harder, in arch/i386/kernel/apm.c the system time is also
>  > saved and restored in a very similar way to timer_suspend/resume.
>  > Would this account for the time drift in APM mode? (sleep time being
>  > accounted for twice?)
> 
> No, apm.c's update to xtime is absolute, just like time.c's.
> Doing both is pointless but not harmful. (I've already tried
> with apm.c's xtime update commented out, but the time-warp
> bug remained.)
> 
> My 0.02 SEK says it's the jiffies update that's broken.

Okay, can you

* kill jiffie update (x86-64, too)
* remove apm.c variant
* test it (or make someone test it) with apm?

I now see the drift with acpi, too :-(. I can do the acpi testing...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

