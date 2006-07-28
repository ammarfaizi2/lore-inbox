Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752054AbWG1RMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbWG1RMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWG1RMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:12:31 -0400
Received: from terminus.zytor.com ([192.83.249.54]:47765 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1752052AbWG1RM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:12:29 -0400
Message-ID: <44CA453D.20700@zytor.com>
Date: Fri, 28 Jul 2006 10:11:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Neil Horman <nhorman@tuxdriver.com>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: A better interface, perhaps: a timed signal flag
References: <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain> <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org> <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com> <20060726002043.GA5192@localhost.localdomain> <20060726144536.GA28597@thunk.org>
In-Reply-To: <20060726144536.GA28597@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> So maybe what we need is an interface where a particular memory
> location gets incremented when a timeout has happened.  It's probably
> enough to say that each thread (task_struct) can have one of these
> (another problem with using /dev/rtc and tieing it directly to
> interrupts is that what happens if two processes want to use this
> facility?), and what hardware timer source gets used is hidden from
> the user application.  In fact, depending on the resolution which is
> specified (i.e., 100's of microseconds versus 10's of milliseconds),
> different hardware might get used; we should leave that up to the
> kernel.
> 
> The other thing which would be nice is if the application could
> specify whether it is interested in CPU time or wall clock time for
> this timeout.
> 

It seems to me that this still assumes that we need to take an interrupt 
in the kernel.  If so, why not just use the timers already present in 
the kernel as opposed to polling gettimeofday()?

	-hpa
