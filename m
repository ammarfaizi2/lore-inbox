Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266614AbRGECrg>; Wed, 4 Jul 2001 22:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266616AbRGECr0>; Wed, 4 Jul 2001 22:47:26 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:18820
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S266612AbRGECrS>; Wed, 4 Jul 2001 22:47:18 -0400
Date: Wed, 4 Jul 2001 19:51:37 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@gw.soze.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.[56] kernel + xfree 4.1.0
Message-ID: <Pine.LNX.4.33.0107041930090.32139-100000@gw.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading to xfree 4.1.0, after switching back to the console after
starting X, suspending, and resuming, the text-mode terminals are corrupt
(but look like they're in text mode).  There were some messages in the
XFree lists about X no longer restoring previous graphics state (since it
has no real way of knowing what graphics state the console you're
switching to is in), but I was hoping this was an Xserver bug with my
graphics chipset (savage ix) writing someplace it shouldn't.

I just compiled framebuffer support in, though, and when switching to a
console, it's initially corrupt (similar pretty impressionistic graphics
that look like they're in the correct video mode for the
framebuffer/console), but within a half a second the framebuffer fixes
itself.

Also with framebuffer in use, after a suspend and resume from X 4.1.0, the
mouse cursor is replaced by a large block.  With regular text-mode
consoles, this doesn't happen.  Switching away and back to X restores the
cursor properly.  This may be completely X's fault though.

Allegedly it's supposed to be bad to run non-framebuffer X-servers with
framebuffer console, is this really not considered stable or am I
mistaken?  If X isn't going to restore previous graphics modes, it doesn't
seem to matter what mode the console was in, framebuffer or not, it still
needs to be fixed regardless.

I'm presuming then that this is something the regular console driver needs
to deal with?


justin

