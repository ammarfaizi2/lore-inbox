Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTLTJay (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 04:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTLTJay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 04:30:54 -0500
Received: from mx1.net.titech.ac.jp ([131.112.125.25]:16658 "HELO
	mx1.net.titech.ac.jp") by vger.kernel.org with SMTP id S263913AbTLTJaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 04:30:52 -0500
Date: Sat, 20 Dec 2003 18:30:49 +0900 (JST)
Message-Id: <20031220.183049.74735752.ryutaroh@it.ss.titech.ac.jp>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
From: ryutaroh@it.ss.titech.ac.jp
In-Reply-To: <20031219123645.GA28801@ucw.cz>
References: <20031219.212456.74735601.ryutaroh@it.ss.titech.ac.jp>
	<20031219123645.GA28801@ucw.cz>
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your very quick reply.

From: Vojtech Pavlik <vojtech@suse.cz>
> Can you try the attached patch?

The problem was not solved.

When I pressed the bar key on JP 106 keyboard, the output of "showkey
-k" is

keycode   0 press
keycode   1 release
keycode  54 release
keycode   0 release
keycode   1 release
keycode  54 release

The scancode does not change. Before applying your patch to the
original kernel, the output was

keycode   0 press
keycode   1 release
keycode  55 release
keycode   0 release
keycode   1 release
keycode  55 release

which corresponds to keycode 183 (= 1*128 + 55).

The output of Linux 2.4.23 was

keycode 124 press
keycode 124 release


By the way, the bar key on JP 106 keyboard is actually the backslash
key and bar is equal to shift-backslash on JP 106. But there is
another backslash key (scancode 0x73) and input of backslash is not a
problem.

Best regards,

Ryutaroh Matsumoto, Ph.D., Research Associate
Department of Communications and Integrated Systems
Tokyo Institute of Technology, 152-8552 Japan
Web page: http://www.rmatsumoto.org/research.html
