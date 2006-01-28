Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422830AbWA1FXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422830AbWA1FXy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 00:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422831AbWA1FXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 00:23:54 -0500
Received: from opersys.com ([64.40.108.71]:52495 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1422830AbWA1FXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 00:23:54 -0500
Message-ID: <43DB0343.1090808@opersys.com>
Date: Sat, 28 Jan 2006 00:38:11 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Thomas Horsten <thomas@horsten.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <Pine.LNX.4.40.0601272112590.29965-100000@jehova.dsm.dk>
In-Reply-To: <Pine.LNX.4.40.0601272112590.29965-100000@jehova.dsm.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[This is a repost of the private reply given that lkml wasn't cc'ed]

Thomas Horsten wrote:
>> But when Linux is used instead (something that most major handset
>> manufacturers are working on at the moment), this whole picture changes.
>> Suddenly the whole point of "Free Software" goes away. Because the handset
>> manufacturer modifies, adapts and uses the Linux kernel (for free),
>> without having to give anything back to the community. Yes, they have to
>> make their modified source available, but there is no way a casual user
>> (read: someone not a member of the phone-unlocking mafia) can update the
>> kernel with a modified, recompiled version.

And I would contend that even if they did it wouldn't make much of a
difference. In fact, my reading of GPLv3 is that it would be quite
straight-forward to create GPLv3-compliant consumer exclusion mechanisms.

Here's from an earlier posting I did on the LWN forum discussing the topic:
----------
Prior to booting kernel, let the firmware verify the kernel's signature.
Whether or not the signature is valid, boot the thing. But, if it isn't
valid, lock up or disable or just don't enable those hardware components
that control access to the "stuff" -- and do this in a way that requires
a hard reset for another pass at lock/don't-lock. Then package all the
proprietary/DRM software into individual applications. So everything just
runs as normal up to the time these apps try to access the hardware,
and now because it's disabled, the device is useless.

Using the words of the draft, there are no codes for you to "install and/
or execute" the work. In fact, you're free to install and execute any
kernel you wish. Plus, the kernel's "functioning in all circumstances is
identical". It's just that hardware beneath it just doesn't work any more,
and that, consequently, the proprietary applications running on top can't
do anything because the hardware is disabled.

There you have it, GPL3-compatible DRM -- to the best of my understanding
of course, and mind you I'm not a lawyer.
----------

Just to make sure there is no confusion: note that both signed and
unsigned kernels behave identically here. It's the user-space applications
now that fail when attempting to access some piece of hardware. The
classic case being a mmap'ed register window, therefore both the signed
and unsigned kernel can map it to user-space (i.e. no modification in
behavior for the GPLv3'ed kernel), but the applications' read/writes on
said registers don't work on the non-signed kernel.

Like I said in the LWN forum thread, I do believe things such as DRM
are worth fighting for, but I really think the GPL is the wrong venue.

>> The only way to prevent Linux from being abused in this way is to require
>> that the end-users have a method of installing the modified code on the
>> device for which it was intended (such as your phone). If they don't want
>> to disclose their primary signing keys, fine, but then they need to make
>> another method available of replacing any free software used in the device
>> with a modified (by the end-user) version. I understand the need to
>> protect the non-GPL'ed "baseband" OS from tampering, but it has to be
>> possible to replace the GPL'ed software. This is what this provision is
>> all about (for me), and I think it is an extremely important one.

And entirely useless if you ask me. A GPLv3 could dictate that you could
replace the kernel, but it isn't a hardware license nor a license for
user-space applications -- both of which's direct interaction could not
be dictated by the license of separate "work".

So, in the end, even if this were applied, you would find yourself in a
world where you can replace kernels, but that apart from having access
to running programs on a given architecture, play around with the RAM,
and access entirely unimportant hardware, you can't do very much.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
