Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbTCaSrg>; Mon, 31 Mar 2003 13:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbTCaSrg>; Mon, 31 Mar 2003 13:47:36 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261767AbTCaSre>;
	Mon, 31 Mar 2003 13:47:34 -0500
Date: Mon, 31 Mar 2003 10:53:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nicholas Wourms <nwourms@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [announce] kmsgdump for 2.5.65/66
Message-Id: <20030331105341.72ec6b8a.rddunlap@osdl.org>
In-Reply-To: <3E7CBB27.8090506@myrealbox.com>
References: <20030319141048.GA19361@suse.de>
	<20030320112559.A12732@namesys.com>
	<20030320132409.GA19042@suse.de>
	<20030320165941.0d19d09d.akpm@digeo.com>
	<20030320231335.GB4638@suse.de>
	<20030320153427.6265e864.rddunlap@osdl.org>
	<3E7CBB27.8090506@myrealbox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003 14:36:07 -0500 Nicholas Wourms <nwourms@myrealbox.com> wrote:

| Randy.Dunlap wrote:
|
| > I've done some 2.5.xyz work on kmsgdump (dump kernel messages to
| > floppy).  I'll try to get back to it soon.
| > 
| 
| Thank you!  That'd be a god-send for those of us w/o serial 
| ports and who have very cramped hands from hand-copying 
| panics :-D.  Frankly, I can't imagine why something a simple 
| as this isn't in the kernel.  Technically, it isn't a 
| debugger, so I don't think it violates Linus' "No Kernel 
| Debuggers in the Kernel" rule.


so.....

kmsgdump for Linux 2.5.65/2.5.66
2003-03-31
version 0.4.5

kmsgdump home:  http://w.ods.org/tools/kmsgdump/ (Willy Tarreau)
my kmsgdump patches:  http://www.xenotime.net/linux/kmsgdump/

'kmsgdump-2565.diff' applies cleanly to Linux 2.5.65 and with
just a few patch offsets to Linux 2.5.66.

Tested on P4 UP and P4 SMP (Linux 2.5.65/66).

======================================================================

kmsgdump is a Linux kernel patch for x86 that can be used to dump the
contents of the kernel log buffer to a floppy disk or to a printer
(one that the system BIOS knows about) after a kernel panic happens.

======================================================================

caveats:

1.  This version of kmsgdump doesn't support kernel log buffers of more
than 60 KB (due to x86 real-mode segment addressing).  However, the
kernel log buffer is currently always a power of 2 (like 16 or 32 or
64 KB), so a 32 KB log buffer is the largest that is currently supported.

2.  The kmsgdump text-mode interface doesn't work with a USB-only keyboard
setup.  I had to add a PS/2 keyboard to my test system to use it.

======================================================================

TODO:

1.  Limit LOG_BUF_LEN to 60 KB then fix this limit by having a moving
    segment register value

###
--
~Randy
