Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbSJTGz3>; Sun, 20 Oct 2002 02:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSJTGz2>; Sun, 20 Oct 2002 02:55:28 -0400
Received: from h-66-167-77-78.SNVACAID.covad.net ([66.167.77.78]:10171 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262243AbSJTGz2>; Sun, 20 Oct 2002 02:55:28 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 20 Oct 2002 00:01:15 -0700
Message-Id: <200210200701.AAA02683@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: ebiederm@xmission.com, eblade@blackmagik.dynup.net, mochel@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>Hopefully I am not coming off harsh but I am a little cranky this
>morning,  As before this change I thought things on the device side
>were pretty much under control they just needed a little stabilization
>and testing.  And now someone possibly me has to go through every
>driver and write a shutdown method because someone figured calling
>free was expensive.

	I think I've essentially refuted this in parts of previous
messages on this thread that Eric has basically ignored in his
responses.

	Interested readers should check the previous lkml messages
with this subject line.  Of particular relevance to this issue, see my
list of three advantages of the 2.4.x approach of not calling
unnecessary device-specific shutdown sequences in my message at
http://marc.theaimsgroup.com/?l=linux-kernel&m=103481960911183&w=2,
where I pasted in a response on the same issue that I originally
wroted in this thread to Eric Blade (after the paragraph that begins
"Changing the interface will reduce coplexity as only the code that
needs to be executed will be called.").  Also of interest is Richard
B. Johnson's example of BIOS reset code that shuts off the PCI bus
before touching any RAM at
http://marc.theaimsgroup.com/?l=linux-kernel&m=103462697923792&w=2.

	I'm willing to get into this in detail again upon request.
Otherwise, I think it would be a better use of everyone's time not to
subject linux-kernel readers to an infinite loop.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
