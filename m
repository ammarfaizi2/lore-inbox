Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263838AbUDFNsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbUDFNrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:47:41 -0400
Received: from mail5.atl.registeredsite.com ([64.224.219.79]:61779 "EHLO
	mail5.atl.registeredsite.com") by vger.kernel.org with ESMTP
	id S263826AbUDFNn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:43:59 -0400
To: kevin@scrye.com
Subject: Re: 2.6.5, ACPI, suspend and ThinkPad R40
Newsgroups: linux.kernel
In-Reply-To: <1HPBr-5yC-5@gated-at.bofh.it>
References: <1HjUX-5pa-3@gated-at.bofh.it> <1HnYA-hr-9@gated-at.bofh.it> <1HKVd-1Uf-3@gated-at.bofh.it>
Organization: 
Cc: linux-kernel@vger.kernel.org
Message-Id: <20040406131602.CCED21421B@x23.networkingunlimited.com>
Date: Tue,  6 Apr 2004 09:16:02 -0400 (EDT)
From: vcjones@NetworkingUnlimited.com (Vincent C Jones)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1HPBr-5yC-5@gated-at.bofh.it> you write:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>>>>>> "Olivier" == Olivier Bornet <Olivier.Bornet@puck.ch> writes:
>
>Olivier> Hi,
>Olivier> On Mon, Apr 05, 2004 at 12:00:09AM +0200, Michal Schmidt wrote:
>>> Yes, see: http://bugzilla.kernel.org/show_bug.cgi?id=1415 There is
>>> a patch which worked for me.
>
>Olivier> Thanks a lot. :-) This patch is working as expected for
>Olivier> me. Now, after doing a:
>
>Olivier>   echo LID > /proc/acpi/wakeup_devices echo SLPB >
>Olivier> /proc/acpi/wakeup_devices
>
>Olivier> I can resume by opening the laptop, or by using the Fn
>Olivier> button, or by using the power button. :-)
>
>Alas, I would like to report it doesn't work for me. 
>
>My laptop suspends, but never comes back from suspend as well. 
>It doesn't seem like the LID or power buttons are a possible setting
>for me. Doing a 'cat /proc/acpi/wakeup_devices' gives:
>
>Device  Speep state     Status
>C04E       5            disabled
>C0A0       3            disabled
>C0A6       3            disabled
>C0A9       3            disabled
>C161       3            disabled
>C162       3            disabled
>C177       4            disabled
>C11E       4            disabled
>
>C11E is my suspend button, but it doesn't seem like it will allow S3? 
>I have no idea what the other addresses are. I tried enabling them
>all, and got a big pile of oopses (which I can duplicate if anyone
>wants)
>
>Any ideas?
>
>Olivier> This patch seems "very" old (first release 2003-10-28).
>
>Olivier> Anyone know why this patch is not in the kernel source tree
>Olivier> at this time ?
>
>Yeah, if it helps some people then it should go in I would think. 
>
>It would be nice if we could just set the list of wakeup devices to a
>sane list for everyone tho. Power/lid/suspend button. 
>
>Back to using nigels swsusp2... at least it's quite fast and the
>latest one seems pretty stable with 2.6 for me at least. ;) 
>
>kevin

Is it my imagination or is there an acute lack of interest in supporting 
notebook features in 2.6.X? Since the early days of 2.5.X, there have
been questions raised regarding suspend/resume and related questions of
critical importance to mobile users. All (at least those associated with
IBM ThinkPads) have been ignored by developers, with the only responses
coming from other notebook users expressing similar concerns.

Is the answer to upgrade to a faster notebook so I can get adequate
performance using the 2.4 kernel in order to retain the ability to
quickly and safely suspend / resume while on the road?

Side note: X23, kernel 2.6.5, SuSE 9.0 with Kraxel fixes. Suspend only
works while on battery, forgetting to unplug the AC first fails every
time and intermittently locks up the box.

-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
14 Dogwood Lane, Tenafly, NJ 07670
http://www.networkingunlimited.com
VCJones@NetworkingUnlimited.com  +1 201 568-7810  Fax: +1 201 568-7269 
