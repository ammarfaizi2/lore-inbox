Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287244AbSAXLCY>; Thu, 24 Jan 2002 06:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287333AbSAXLCQ>; Thu, 24 Jan 2002 06:02:16 -0500
Received: from relay03.valueweb.net ([216.219.253.237]:48388 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S287289AbSAXLCA>; Thu, 24 Jan 2002 06:02:00 -0500
Message-ID: <3C4FEBB3.16CB46E8@opersys.com>
Date: Thu, 24 Jan 2002 06:10:43 -0500
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16rthal5-TRACE i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] LTT 0.9.5pre5: S/390, SuperH, autoconf, RTAI, etc.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LTT 0.9.5pre5 is now out. It contains quite a few enhancements.
Most importantly, LTT now supports 4 different architectures:
i386, PPC, S/390 and SuperH.

Adding further ports is only a matter of adding the appropriate
architecture-specific trace statements for the following types
of events:
-System call entry/exit (usually in entry.S)
-IRQ entry/exit (usually in irq.c)
-Trap entry/exit (both in the appropriate files in arch/XYZ/kernel,
such as traps.c, and in arch/XYZ/mm/fault.c where page faults are usually
handled)
-Kernel thread creation (process.c)
-IPC call (syscalls.c)
and adding the appropriate configuration option in the architecture's
config.in file.

The following is a summary of changes and comments:
o S/390 port by Theresa Halloran. I've been told that there are
some minor issues with the way this has been integrated. They
should be fixed for pre6.
o SuperH port by Greg Banks and port update by Andrea Cisternino.
o Conversion of LTT build system to autoconf by Philippe Gerum.
o Update of RTAI support to RTAI 24.1.7 (the trace graphs won't
display correctly, still, but the event sequences can be retrieved
without a problem).
o Many bug fixes by Frank Rowand.
o Addition of "Architecture Variant" property of traces in addition
to "Architecture Type" (many types of PPCs, ARMs and MIPS' for
example).
o Fix for death of visualizer on empty traces.
o Fix for improper PID display when tracing only one PID.
o Miscallaneous option parsing fixes for Daemon.

For a complete description of each of these additions, check out
the news section of the web site.

It is no longer required to get approval to subscribe to the
development mailing list. If you're interested to contribute, feel
free to subscribe.

I've noticed that LTT is on the 2.5 status list with the "beta"
branding. I'm not sure how a project's status is evaluated and
attributed a rating, but LTT having been around since July '99,
it's been pretty much in the "ready" state for a while. Any thoughts
are welcomed.

As always, LTT can be found on the project's web site:
http://www.opersys.com/LTT

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
