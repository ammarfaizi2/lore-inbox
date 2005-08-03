Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVHCOiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVHCOiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVHCOiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:38:05 -0400
Received: from isdns2.is.l-3com.com ([148.104.5.19]:35481 "EHLO
	isDNS2.is.l-3com.com") by vger.kernel.org with ESMTP
	id S261712AbVHCOgI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:36:08 -0400
Message-ID: <43AD24418F7C0E45B645991A6F46865908C98B88@gvlexch03.gvl.is.l-3com.com>
From: "Mock, JV Jason (6278) @ IS" <Jason.V.Mock@L-3Com.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.6.9 Kernel + 3780 Keyboard
Date: Wed, 3 Aug 2005 09:36:02 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I’m doing some work on attempting to get an old 3780 keyboard (yes
those old 34 function key IBM/AT keyboards are still wondering around)
working on a 2.6.9 kernel system.  The keyboard of course use to work on
2.4.x system, as long as we forced the keyboard to scancode set 3 (some keys
were creating the same keycodes with scancode set 2).  Now, with the 2.6.x
kernel, we are seeing a much more serious problem as many scancodes appear
to be “moved” from one key to another (I.E.  I can run showkey –s against
the 2.4 system, and document the scancodes for specific keys, and if I do
the same for 2.6, many of the function buttons, including home, insert, and
etc are different).  That being said they are at least consistently
different in a way that can be documented and mapped.  The problem then
become, the second I start mapping these scancodes to they keys dictated by
“include/linux/input.h”, I start loosing other keys.  Then, after they are
mapped, showkey –s reports different scancodes for the mapped keys.  ???
This is only the beginning as the left control key never reports a break (as
showkey –s indicates) and even if I do get keys mapped…  if I verify the
keycode they are mapped to against showkey and xev, I get two completely
different answers.   (I.E.  I map scancode 64 (which is what the F13 button
is coming up as) to keycode 108 (indicated by input.h).  I run showkey,
press the F13 key, and I get keycode 108… what I expect…  then I run xev and
get 105?!).  I guess we are just trying to understand how much of this is
due to the changes in keyboard input between the 2.4 kernel and the 2.6
kernel and if there is a simple solution to our problem.  While I realize
the xev issue is probably better directed at Xorg, because even if I get
that fixed, I have keys that die the second I map and others that don’t have
breaks.  Vojetch, what am I doing wrong? ☺

Thanks,

Jason Mock
