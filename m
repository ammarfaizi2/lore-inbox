Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbSKCXKc>; Sun, 3 Nov 2002 18:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSKCXKc>; Sun, 3 Nov 2002 18:10:32 -0500
Received: from adsl-66-125-65-154.dsl.sntc01.pacbell.net ([66.125.65.154]:46065
	"EHLO dual.pharr.org") by vger.kernel.org with ESMTP
	id <S263281AbSKCXKc>; Sun, 3 Nov 2002 18:10:32 -0500
To: linux-kernel@vger.kernel.org
Subject: keyboard not recognized with 2.5 kernels
X-Face: C!.oGaE]n@p)VF9Ss3]f'|<)kRrtpG)^^b^X-3_zhUHp\jBj29jaoTItqWR>mHa+v-{/!jx7OA@!cV0>Fm-b:zEL<`oOXG[BFQ\<q:TwWP@JNZu+VXcD2viySG/R_/|6UDo,W;w^z^NK)F\YM|xjvI[MH,"iQ~mT<g`H6;x8}8j|miQUQ&fw|!V~.N+[#69iY?|ypa*[.{bEm\JDlI<<!}p}xeb7[N-!3nT^i3Rr#M"{a@+k.QZnnuzDcre%C6}qkv$fTsSJ
From: Matt Pharr <matt@pharr.org>
Date: Sun, 03 Nov 2002 15:17:04 -0800
Message-ID: <m2lm4az1jj.fsf@dual.pharr.org>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Honest Recruiter,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I've had this problem with both 2.5.39 and 2.5.45; haven't tried any other
versions.)

After 2.5 boots, my keyboard doesn't seem to be recognized (it's an
old-style one plugged into the keyboard port, not a USB keyboard).
Everything is fine up to the login: prompt, but then any key I hit doesn't
cause anything to happen (including ctrl-alt-del).

I have tried booting with "i8042_direct=1" on the kernel command line (as
suggested in another thread about other keyboard problems), and that didn't
help, and I have tried plugging in a plain old Dell keyboard instead of the
Logitech iTouch I've got plugged in now.  Neither of those helped.  I also
tried building without SMP support, and that didn't change the situation
either.

This is on a home-built machine, Asus A7M266-D motherboard, dual athlon
1900MPs, etc.

I don't think I did anything dumb in the configuration step--I used my
working 2.4.19 .config file, did a 'make oldconfig', and answered questions
in conservative ways.  In particular, I do have CONFIG_INPUT_KEYBOARD set
properly:

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

Any thoughts about how to debug further?  I fear that I've forgotten
something obvious, but can't think of anything else to try.

thanks,
-matt

