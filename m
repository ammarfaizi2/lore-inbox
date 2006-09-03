Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751925AbWICCuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbWICCuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 22:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWICCuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 22:50:08 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:27335 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751925AbWICCuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 22:50:06 -0400
Message-Id: <200609030157.k831vaDY018465@laptop13.inf.utfsm.cl>
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - sysctl or module parameters. 
In-Reply-To: Message from Neil Brown <neilb@suse.de> 
   of "Fri, 01 Sep 2006 12:02:52 +1000." <17655.38092.888976.846697@cse.unsw.edu.au> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Sat, 02 Sep 2006 21:57:36 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:52:03 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 02 Sep 2006 22:49:40 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
> There are so many ways to feed configuration parameters into the
> kernel these days.  

;-)

> There is sysctl.  There is sysfs. And there are module paramters.
> (procfs? who said procfs? I certainly didn't).

And kernel parameters.

> I have a module - let's call it 'lockd'.
> I want to make it configurable - say to be able to identify
>  peers by IP address (as it currently does) or host name
>  (good for multi homed peers, if you trust them).

[...]

> It occurs to me that since we have /sys/module/X/parameters,
> it wouldn't be too hard to have some functionality, possibly
> in modprobe, that looked for all the 'options' lines in
> modprobe config files, checked to see if the modules was loaded,
> and then imposed those options that could be imposed.
> 
> Thus we could just have a module option, just add module config
> information to /etc/modprobe.d and run
>   modprobe --apply-option-to-active-modules
> at the same time as "sysctl -p" and it would all 'just work'
> whether the module were compiled in to not.

No, please. Not across the board. That will screw up hand-tuned parameters

And in any case, make sysctl do it (it should not matter if it is module
configuration or built-in configuration, just for consistency).

[I seem to remember a similar thread perhaps one month back?]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513


-- 
VGER BF report: U 0.5
