Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVHOUYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVHOUYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVHOUYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:24:15 -0400
Received: from loihi.boulder.swri.edu ([65.241.78.2]:3551 "EHLO
	perseus.boulder.swri.edu") by vger.kernel.org with ESMTP
	id S964946AbVHOUYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:24:14 -0400
Message-ID: <4300F9DD.8090005@skyrush.com>
Date: Mon, 15 Aug 2005 14:23:57 -0600
From: Joe Peterson <joe@skyrush.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mr.fred.smoothie@pobox.com
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
References: <4300D09C.4030702@skyrush.com> <20050815174558.GB1450@ucw.cz>	 <4300D845.8070605@skyrush.com> <20050815185729.GA1450@ucw.cz>	 <4300EF7C.9020500@skyrush.com> <161717d505081513066c660129@mail.gmail.com>
In-Reply-To: <161717d505081513066c660129@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Neuer wrote:
> On 8/15/05, Joe Peterson <joe@skyrush.com> wrote:
> 
>>So, overall, I agree that we should not invent hacks to make up for
>>another software package's problems...
> 
> 
> but also wrote:
> 
> 
>>If the kernel could handle that aspect, it would make all programs more stable.
> 
> 
> which seems a little contradictory.

What I was trying to say (and didn't say very well!) is that I agree
that "hacks" should not be created to mask other problems, but perhaps
there are ways to solve the problem in the kernel (or in user-space
programs like udev) that are not hacks and that generally make things
more elegant all around.

> However, Joe continued with:
> 
> 
>>It does not sound right to push the handling of the intermittent nature
>>to each user program.
> 
> 
> Indeed. Each user program should not care about it. An event/hotplug
> library should, and the user programs should use that. Like d-bus/HAL.

Right.  Or, if it makes sense, I was proposing that a new kind of device
(or device mode) that makes a device ever-present could prevent needless
handling of plugs and unplugs in applications or X, if that's
appropriate.  /dev/input/mice is such a device, acting as a catch-all
for mouse events (and as a byproduct, the specific mouse device chosen
arbitrarily does not matter to the app).  If it's a hack (as Vojtech
says), maybe there is a way to get the same functionality in a less
hackish way.  But Vojtech is right that the kernel should not read
config files or set "policy," so perhaps something like udev is the
right place for that kind of thing...

	-Joe
