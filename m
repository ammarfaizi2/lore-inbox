Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268290AbTGTUiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268294AbTGTUiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:38:10 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:49069 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S268290AbTGTUiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:38:08 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: junkio@cox.net, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.0-test1 JAP_86 disappeared from atkbd.c
References: <7vy8yudcec.fsf@assigned-by-dhcp.cox.net>
	<20030719181205.A3543@pclin040.win.tue.nl>
From: junkio@cox.net
Date: Sun, 20 Jul 2003 13:53:08 -0700
In-Reply-To: <20030719181205.A3543@pclin040.win.tue.nl> (Andries Brouwer's
 message of "Sat, 19 Jul 2003 18:12:05 +0200")
Message-ID: <7vhe5grkcr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AB" == Andries Brouwer <aebr@win.tue.nl> writes:

AB> Ha - really long ago I wrote that..

AB> Yes, for 2.5 things are much more involved, but I suppose that
AB> all will be well if you add the line

AB> keycode 183 = backslash bar

AB> to your keymap.

Thanks, it really was a long ago.  With the above included in
drivers/char/defkeymap.map and regenerating defkeymap.c_shipped
with loadkeys (kbd-1.08 recompiled with include/linux/keyboard.h
that comes with 2.6 kernel), things started work again.

Is there a reason not to include the above "keycode 183" line in
the shipped source (both defkeymap.map and defkeymap.c_shipped)?

The 2.6 kernel without it can be seem as a feature degradation
from 2.4 for 86/106 keyboard users, and I would like to know if
there is a case where having that line hurts.  Is "keycode 183"
generated for completely different characters on other national
keyboards, and having that line is a feature degradation for
users of such keyboards?  I have access to only 101, 86, and 106
keyboards so I cannot test this myself.  Or maybe there are
other reasons to leave the default keymap as minimal as it
currently is in 2.6 tree?

