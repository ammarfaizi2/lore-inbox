Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270823AbTGNUdC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270788AbTGNUa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:30:57 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:42650 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270829AbTGNU3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:29:09 -0400
Date: Mon, 14 Jul 2003 22:43:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030714204335.GJ902@elf.ucw.cz>
References: <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030713193114.GD570@elf.ucw.cz> <1058130071.1829.2.camel@laptop-linux> <20030713210934.GK570@elf.ucw.cz> <1058147684.2400.9.camel@laptop-linux> <20030714201245.GC24964@ucw.cz> <20030714201804.GF902@elf.ucw.cz> <1058214607.3987.14.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058214607.3987.14.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm going to stand firm on this one, Pavel.
> 
> I think being able to cancel a suspend is a really useful feature, and
> I'll be surprised if we don't see Microsoft including it in their next
> version of Windows (perhaps I should take a patent out! :>)

:-).

> That's not to say that I haven't listened to you, however. That's why I
> tightened up the requirements for using it yesterday. As to the extra
> proc entry, it's not a biggie: 2.4 swsusp now has it's own proc handling
> code which is easily extensible. I did this to make it easier to
> understand.
> 
> This...
> 
> [nigel@laptop-linux nigel]$ ls -l /proc/swsusp/
> total 0
> --w-------    1 root     root            0 Jul 15 08:28 activate
> -rw-------    1 root     root            0 Jul 15 08:28 async_io_limit
> -rw-------    1 root     root            0 Jul 15 08:28 beeping
> -rw-------    1 root     root            0 Jul 15 08:28 checkpage
> -rw-------    1 root     root            0 Jul 15 08:28 debug_sections
> -rw-------    1 root     root            0 Jul 15 08:28 default_console_level
> -rw-------    1 root     root            0 Jul 15 08:28 enable_escape
> -rw-------    1 root     root            0 Jul 15 08:28 image_size_limit
> -r--------    1 root     root            0 Jul 15 08:28 interface_version
> -r--------    1 root     root            0 Jul 15 08:28 last_result
> -rw-------    1 root     root            0 Jul 15 08:28 log_everything
> -rw-------    1 root     root            0 Jul 15 08:28 no_async_reads
> -rw-------    1 root     root            0 Jul 15 08:28 no_async_writes
> -rw-------    1 root     root            0 Jul 15 08:28 no_output
> -rw-------    1 root     root            0 Jul 15 08:28 nopageset2
> -rw-------    1 root     root            0 Jul 15 08:28 pause_between_steps
> -rw-------    1 root     root            0 Jul 15 08:28 progressbar_granularity_limit
> -rw-------    1 root     root            0 Jul 15 08:28 reboot
> -rw-------    1 root     root            0 Jul 15 08:28 slow
> -r--------    1 root     root            0 Jul 15 08:28 version
> [nigel@laptop-linux nigel]$ 
> 
> is easier to understand and configure. The /proc/sys/kernel/swsusp
> interface is still there to make it easy to save & restore them all at
> once.

Ouch.. But how many of these /proc tweaks need to stay there once
debugging is done? I do not like any configuration options for
swsusp... It should just work. [Okay, we probably need to have resume=
parameter.]

For 2.4.X I don't care. For official tree, it has to "just work" with
as little configuration as possible. [Besides enable_escape, what else
might user want to tweak?]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
