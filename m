Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTJXHse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJXHse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:48:34 -0400
Received: from gprs146-220.eurotel.cz ([160.218.146.220]:36225 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262055AbTJXHsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:48:33 -0400
Date: Fri, 24 Oct 2003 09:48:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: John stultz <johnstul@us.ibm.com>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031024074811.GA1519@elf.ucw.cz>
References: <20031022233306.GA6461@elf.ucw.cz> <1066866741.1114.71.camel@cog.beaverton.ibm.com> <20031023081750.GB854@openzaurus.ucw.cz> <3F9838B4.5010401@mvista.com> <1066942532.1119.98.camel@cog.beaverton.ibm.com> <3F985FB0.1070901@mvista.com> <1066955396.1122.133.camel@cog.beaverton.ibm.com> <3F988A0B.4010803@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F988A0B.4010803@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The request can be on the wall clock or on clock_monotonic.  Still, we went 
> round and round about how a tick on one should be a tick on the other.  My 
> understanding is that the pm_timer was put in the ACPIC to handle this, but 
> then I don't know how far down power is going, nor for how long.  I would 
> think at some point the discontinuity would be large enough that one would 
> want some user service to run and "fix" all the broken time assumptions.  
> Some sort of a soft reboot that would kick the ntp code, cron and so on, 
> much as is done at boot.

Well, it is well possible that discontinuity is days (it usually is 8
hours for me -- I suspend-to-disk before going to sleep), and nothing
prevents you from suspending machine for half a year.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
