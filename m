Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSKDAGv>; Sun, 3 Nov 2002 19:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSKDAGv>; Sun, 3 Nov 2002 19:06:51 -0500
Received: from adsl-66-125-65-154.dsl.sntc01.pacbell.net ([66.125.65.154]:56561
	"EHLO dual.pharr.org") by vger.kernel.org with ESMTP
	id <S263899AbSKDAGu>; Sun, 3 Nov 2002 19:06:50 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard not recognized with 2.5 kernels
References: <m2lm4az1jj.fsf@dual.pharr.org>
	<20021103232507.GE20338@pasky.ji.cz>
X-Face: C!.oGaE]n@p)VF9Ss3]f'|<)kRrtpG)^^b^X-3_zhUHp\jBj29jaoTItqWR>mHa+v-{/!jx7OA@!cV0>Fm-b:zEL<`oOXG[BFQ\<q:TwWP@JNZu+VXcD2viySG/R_/|6UDo,W;w^z^NK)F\YM|xjvI[MH,"iQ~mT<g`H6;x8}8j|miQUQ&fw|!V~.N+[#69iY?|ypa*[.{bEm\JDlI<<!}p}xeb7[N-!3nT^i3Rr#M"{a@+k.QZnnuzDcre%C6}qkv$fTsSJ
From: Matt Pharr <matt@pharr.org>
Date: Sun, 03 Nov 2002 16:13:22 -0800
In-Reply-To: <20021103232507.GE20338@pasky.ji.cz> (Petr Baudis's message of
 "Mon, 4 Nov 2002 00:25:08 +0100")
Message-ID: <m2y98ambtp.fsf@dual.pharr.org>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Honest Recruiter,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr Baudis <pasky@ucw.cz> writes:
> Dear diary, on Mon, Nov 04, 2002 at 12:17:04AM CET, I got a letter,
> where Matt Pharr <matt@pharr.org> told me, that...
> ..snip..
>> After 2.5 boots, my keyboard doesn't seem to be recognized (it's an
>> old-style one plugged into the keyboard port, not a USB keyboard).
>> Everything is fine up to the login: prompt, but then any key I hit doesn't
>> cause anything to happen (including ctrl-alt-del).
> ..snip..
>> I don't think I did anything dumb in the configuration step--I used my
>> working 2.4.19 .config file, did a 'make oldconfig', and answered questions
>> in conservative ways.  In particular, I do have CONFIG_INPUT_KEYBOARD set
>> properly: [...]
>
> Try to answer yes to the Serial i/o support (under Input device support) and
> then enable support of the i8042 PC Keyboard controller.

Hmm, I didn't have that set before, but setting it and rebuilding doesn't
make things better, with or without the 'i8042_direct=1' flag at boot-time.
(I've rebuilt it all twice now, with an extra 'make clean' in the middle,
just to be sure.)

bash-2.05a# grep SERI !$
grep SERI .config
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_SERIAL_8250 is not set
# CONFIG_SND_SERIAL_U16550 is not set

Any other ideas?

> Making the keyboard configuration under 2.5.x more obvious is currently in the
> process of discussion.

Sounds good.  I'm guessing that I missed some other important config option
here.  Perhaps someone could send me their .config file, I can enable what
extra stuff I need (xfs, etc), and I can then figure out what else I needed
to enable?

thanks,
-matt
-- 
Matt Pharr    matt@pharr.org    <URL:http://graphics.stanford.edu/~mmp>
=======================================================================
In a cruel and evil world, being cynical can allow you to get some
entertainment out of it. --Daniel Waters
