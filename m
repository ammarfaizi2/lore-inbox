Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbSJZKYl>; Sat, 26 Oct 2002 06:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSJZKY3>; Sat, 26 Oct 2002 06:24:29 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:25868 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262045AbSJZKXm>; Sat, 26 Oct 2002 06:23:42 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Wed, 23 Oct 2002 11:38:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] High-res-timers part 2 (x86 platform code) take 6
Message-ID: <20021023093815.GB3416@elf.ucw.cz>
References: <3DAFB303.4543C579@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAFB303.4543C579@mvista.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch, in conjunction with the "core" high-res-timers
> patch implements high resolution timers on the i386
> platforms.  The high-res-timers use the periodic interrupt
> to "remind" the system to look at the clock.  The clock

This scares me:

+#define fail_message \
+"High-res-timers:
>-<--><-->-<-->-<-->-<--><-->-<-->-<-->-<-->-<-->-<-->-<-->-<\n"\
+"High-res-timers: >Failed to find the ACPI pm timer
<\n"\
+"High-res-timers: >-<--><-->-<-->-<-->-<-->Boot will fail in
Calibrate Delay  <\n"\
+"High-res-timers: >Supply a valid default pm timer address
<\n"\
+"High-res-timers: >or get your BIOS to turn on ACPI support.
<\n"\
+"High-res-timers: >See CONFIGURE help for more information.
<\n"\
+"High-res-timers:
>-<--><-->-<-->-<-->-<--><-->-<-->-<-->-<-->-<-->-<-->-<-->-<\n"

Does that mean our boot has now so much junk in it that we start
adding ascii art for "important" messages?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
