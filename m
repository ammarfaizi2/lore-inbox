Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270856AbTHAR5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 13:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270869AbTHAR5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 13:57:33 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:46492 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S270856AbTHAR5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 13:57:30 -0400
Subject: Re: 2.6.0-test1/2: keyboard funnies in textmode
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030801163759.GA3343@win.tue.nl>
References: <1059747945.2809.2.camel@paragon.slim>
	 <20030801145223.GA3308@win.tue.nl> <1059752011.2691.13.camel@paragon.slim>
	 <20030801163759.GA3343@win.tue.nl>
Content-Type: text/plain
Message-Id: <1059760564.3404.9.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-1) 
Date: 01 Aug 2003 19:56:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-01 at 18:37, Andries Brouwer wrote:

> The usual answer is "showkeys" for keycodes, "showkeys -s"
> for scancodes. On 2.6 some cheating is involved, since the
> driver first translates and then untranslates, so raw mode
> is not exactly raw anymore, and replies may be wrong.
> 

OK here it goes:

Laptop 2.4 showkey:
kb mode was UNICODE
[ if you are trying this under X, it might not work
since the X server is also reading /dev/console ]

press any key (program terminates 10s after last keypress)...
keycode  28 release
keycode 124 press
keycode 124 release
keycode 124 press
keycode 124 release
keycode 124 press
keycode 124 release

Laptop 2.4 showkey -s:
0x7d
0xfd
0x7d
0xfd
0x7d
0xfd
0x2a
0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a
0x2a 0x2a
0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a
0x7d
0xfd
0x7d
0xfd
0x7d
0xfd 0xaa



Laptop 2.6 showkey:
keycode	0 press
keycode 1 release
keycode 55 release
keycode 0 release
keycode 1 release
keycode 55 release

Laptop 2.6 showkey -s:
0x7d
0xfd
0x7d
0xfd
0x7d
0xfd


PC 2.4 showkey:
keycode  43 release
keycode  43 press
keycode  43 release
keycode  43 press
keycode  43 release

PC 2.4 showkey -s:
0x2b 0xab
0x2b 0xab
0x2a
0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2b 0xab
0x2b
0xab 0xaa

PC 2.6 showkey:
keycode  84 press
keycode  84 release
keycode  84 press
keycode  84 release

PC 2.6 showkey -s:
0x2b 0xab
0x2b 0xab
0x2a
0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2a 0x2b 0xab
0x2b 0xab 0xaa

The difference between 2.4 and 2.6 on the laptop are very weird. 
Hope this helps.

Greetings,

Jurgen


