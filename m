Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265160AbUEYUT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265160AbUEYUT3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUEYUT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:19:29 -0400
Received: from 217-162-94-183.dclient.hispeed.ch ([217.162.94.183]:57861 "EHLO
	gw.osk.ch") by vger.kernel.org with ESMTP id S265160AbUEYUTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:19:21 -0400
Date: Tue, 25 May 2004 22:16:16 +0200
From: Chris Osicki <osk@osk.ch>
To: linux-kernel@vger.kernel.org
Subject: keyboard problem with 2.6.6
Message-ID: <20040525201616.GE6512@gucio>
Reply-To: osk@osk.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Using Microsoft software might be a security risk
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I recently moved to kernel 2.6.6 from 2.4.26 and noticed that four keys
on my keyboard stopped working.
The kernel reports:

	keyboard: unrecognized scancode (XX) - ignored

Where XX is 71, 72, 74, 75.

My setup is quite unusual as I'm using Sun type 5 keyboard on my
PC with a self-made adapter. However, this setup has worked for at 
least six years with different kernel versions.
The four keys which don't work anymore are from the function-key-set
on the left hand side of the keyboard, if you know what a Sun
keyboard looks like.

I tried to solve my problem using setkeycodes and tried:

setkeycodes 71 101

as 101 was unused keycode (according to getkeycodes)

getkeycodes reported after that:

# getkeycodes | grep 0x70
 0x70:   93 101   0  89   0   0  85  91

But showkeys -s shows 0x5b when the key in question is pressed
(and no release event!!??)
Which is what I don't understand but what probably is out of the scope
of this list.

Under XFree86 this key is then keycode 99 and keysym ff55 which
confuses me totally, but the question "why" belongs probably not to
this list either.

All mentioned keyboard related programs come from the latest
kbd-package - kbd-1.12.

I would be very thankful if somebody could help me to understand
what's going on and how can I get my keys working again.
There must be a good reason for the change from 2.4.x to 2.6.x
which escapes me.

Thanks for your time.

Regards,
Chris

PS Please Cc: me if possible
-- 

Chris Osicki osk@osk.ch
Dipl. Informatik-Ing. HTL

