Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282187AbRLMLdQ>; Thu, 13 Dec 2001 06:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282190AbRLMLdG>; Thu, 13 Dec 2001 06:33:06 -0500
Received: from HETZMANNSEDER.inst-4.ufg.ac.at ([193.170.97.254]:13324 "EHLO
	hetzmannseder.inst-4.ufg.ac.at") by vger.kernel.org with ESMTP
	id <S280771AbRLMLcx>; Thu, 13 Dec 2001 06:32:53 -0500
Date: Thu, 13 Dec 2001 12:32:27 +0100 (CET)
From: Markus Hetzmannseder <hetzi@hetzi.at>
To: "Jonathan D. Amery" <jdamery@chiark.greenend.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C686 && APM deadlock bug?
In-Reply-To: <Pine.LNX.4.21.0112121632440.4294-100000@chiark.greenend.org.uk>
Message-ID: <Pine.LNX.4.40.0112131125540.26191-100000@hetzmannseder.inst-4.ufg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Jonathan D. Amery wrote:

>  in 2.4.9 and 2.4.16 with APM compiled in on my Sony Vaio FX201 laptop
> (Via VT82C686 chipset) sometimes when the hardware screensaver comes on
> (as a result of APM) the machine deadlocks and has to be powered off and
> on again.  (Lots of fscking).

I have the same deadlock problem like you with the same VIA-chipset, my
Laptop is a gericom hydrospeed. I can reproduce it by mounting a cd in the
cd-drive. (My kernel is a 2.4.16 with ide-cd modules)

Steps to generate a deadlock on my notebook:

1. mount a normal cd
2. unmount the cd-drive
3. make a apm --suspend
4. wake up the laptop
5. try to remount the cd
6. the laptop get immediately lockt!

Please try out this, i think it could be the same problem?

Hetzmannseder Markus		http://www.hetzi.at/hetzi/
--------------------------------------------------------------------------
"If I do not return to the pulpit this weekend, millions of people will go
to hell."
-- Jimmy Swaggart, 5/20/88

