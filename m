Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTLTJws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 04:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTLTJws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 04:52:48 -0500
Received: from mx1.net.titech.ac.jp ([131.112.125.25]:49162 "HELO
	mx1.net.titech.ac.jp") by vger.kernel.org with SMTP id S264119AbTLTJwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 04:52:46 -0500
Date: Sat, 20 Dec 2003 18:52:44 +0900 (JST)
Message-Id: <20031220.185244.71103628.ryutaroh@it.ss.titech.ac.jp>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
From: ryutaroh@it.ss.titech.ac.jp
In-Reply-To: <20031220093532.GB6017@ucw.cz>
References: <20031219123645.GA28801@ucw.cz>
	<20031220.183049.74735752.ryutaroh@it.ss.titech.ac.jp>
	<20031220093532.GB6017@ucw.cz>
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
Date: Sat, 20 Dec 2003 10:35:32 +0100

> > By the way, the bar key on JP 106 keyboard is actually the backslash
> > key and bar is equal to shift-backslash on JP 106. But there is
> > another backslash key (scancode 0x73) and input of backslash is not a
> > problem.
> 
> Keycode 183 is correct for the japanese backslash key. 2.4 didn't
> differentiate, 2.6 does. You just need to update your keymap.

2.4 kernel does differentiate two backslash key on JP 106 keyboard.

When I press lower-right backslash (scancode 0x73), I get keycode
89 on both Linux 2.4 and 2.6.

When I press upper-right backslash (scancode 0x7d), whose key top is
Japanese yen and bar, I get keycode 124 on Linux 2.4 but 183 on Linux
2.6.

Is the change of keycode of upper-right backslash a new feature of
Linux 2.6? What is the advantage of this new feature?

The following is from /usr/share/keymaps/i386/qwerty/jp106.kmap in
Debian:

keycode  89 = backslash        underscore
	control	keycode  89 = Control_backslash
keycode 124 = backslash        bar
	control	keycode 124 = Control_backslash

Ryutaroh Matsumoto
