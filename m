Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270893AbTGNVNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270882AbTGNVLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:11:04 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:31968 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S270870AbTGNVIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:08:35 -0400
Date: Tue, 15 Jul 2003 09:20:43 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
	enhancements
In-reply-to: <20030714204335.GJ902@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058217642.4535.5.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200307121734.29941.dtor_core@ameritech.net>
 <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk>
 <20030713193114.GD570@elf.ucw.cz> <1058130071.1829.2.camel@laptop-linux>
 <20030713210934.GK570@elf.ucw.cz> <1058147684.2400.9.camel@laptop-linux>
 <20030714201245.GC24964@ucw.cz> <20030714201804.GF902@elf.ucw.cz>
 <1058214607.3987.14.camel@laptop-linux> <20030714204335.GJ902@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without debugging code it could look more like..

> > [nigel@laptop-linux nigel]$ ls -l /proc/swsusp/
> > total 0
> > -rw-------    1 root     root            0 Jul 15 08:28 enable_escape
> > -rw-------    1 root     root            0 Jul 15 08:28 image_size_limit
> > -r--------    1 root     root            0 Jul 15 08:28 interface_version
> > -r--------    1 root     root            0 Jul 15 08:28 last_result
> > -r--------    1 root     root            0 Jul 15 08:28 version
> > [nigel@laptop-linux nigel]$ 
> > 
> Ouch.. But how many of these /proc tweaks need to stay there once
> debugging is done? I do not like any configuration options for
> swsusp... It should just work. [Okay, we probably need to have resume=
> parameter.]

It does just work, but there is room for preferences too. I like
flexibility, and try to build it into my code.

> For 2.4.X I don't care. For official tree, it has to "just work" with
> as little configuration as possible. [Besides enable_escape, what else
> might user want to tweak?]

The limit on the size of the image (they may want a smaller image than
the amount of swap they have).

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

