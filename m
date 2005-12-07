Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVLGKjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVLGKjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVLGKjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:39:52 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:60238 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750827AbVLGKjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:39:51 -0500
Message-ID: <4396BBF4.4010609@tls.msk.ru>
Date: Wed, 07 Dec 2005 13:39:48 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
References: <43923479.3020305@tls.msk.ru> <20051204003130.GB1879@kroah.com> <386F0C1C.1040509@tls.msk.ru> <20051205132048.GB7478@elf.ucw.cz>
In-Reply-To: <20051205132048.GB7478@elf.ucw.cz>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>> ..preparing for standby...
>> ..hdd stops spinning..
>> ..monitor is turned off..
>> ..less-than-a-secound-pause..
>> Back to C!
>> ..the system goes back, restoring interrupts etc...
>>
>>I tried various 'wakeup' settings in bios, incl. turning everything
>>off in that menu - no difference.
>>
>>The same behaviour is shown by all 2.6 kernels I tried so far
>>(since 2.6.6 or so).
> 
> Try ACPI wakeup settings, and ask on ACPI lists. Unfortunately noone
> really cares about standby these days.

Which "ACPI wakeup settings" did you mean?  In BIOS or in kernel?

In my BIOS, there's a page called "Power management" (or something
of that sort), which, among other things, contains a section
"Wakeup devices" or "Wakeup events" - i tried to turn them all
on and off, all at once and in alot of different combinations -
makes no real difference, the system wakes up in a secound or
two regardless.

Too bad no one cares about standby.. :(
I've several of those systems, and I love them for their quiet
operation.  The only problem for me is the system startup time
(about 3 minutes) and applications startup time (due to the
empty filesystem cache) -- it'd be very nice to be able to
suspend the system somehow instead of turning it off...  Now,
suspend to disk does not work at all (that 4M pages stuff on
a VIA C3 CPU), suspend to mem does not work either, and "normal"
standby, while works, triggers a wakeup almost immediately.
So, in short, no suspend at all...

But Ok.  Lemme see what's going on around that file in the code..

/mjt
