Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbTIZBbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 21:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTIZBbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 21:31:09 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:57728
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262333AbTIZBbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 21:31:06 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: Keyboard oddness.
Date: Thu, 25 Sep 2003 20:27:57 -0500
User-Agent: KMail/1.5
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <200309201633.22414.rob@landley.net> <200309221506.08331.rob@landley.net> <20030923000647.A1128@pclin040.win.tue.nl>
In-Reply-To: <20030923000647.A1128@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309252027.57512.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 17:06, Andries Brouwer wrote:

> > Any clues?  (This happens to me at least once an hour...)
>
> Some people have been reporting missing key releases (maybe also you),
> but these are all missing key presses. It is easiest to blame the
> keyboard, even though I could imagine ways to blame the kernel.
>
> What about 2.4? Do you have to go back once an hour and add a symbol
> that was not transmitted correctly? Does 2.4 work perfectly for you?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Okay, a little fresh data:

I just had the keyboard key sticking problem occur, 2.6.0-test5-mm4.

Sep 25 20:06:25 localhost dhclient: DHCPREQUEST on eth0 to 128.83.185.55 port 
67
Sep 25 20:06:25 localhost dhclient: DHCPACK from 128.83.185.55
Sep 25 20:06:25 localhost dhclient: bound to 128.62.240.239 -- renewal in 1608 
seconds.
Sep 25 20:22:22 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd1, 
on isa0060/serio0) pressed.
Sep 25 20:22:22 localhost kernel: i8042 history: d1 e0 51 e0 d1 e0 51 e0 d1 e0 
51 e0 d1 e0 51 d1
Sep 25 20:22:42 localhost su(pam_unix)[2047]: session opened for user root by 
landley(uid=500)

The page down key is the one that stuck.  I pressed another key (possibly 
either cursor up or page up) to unstick it, and then the next time I pressed 
page down it didn't register, but the time after that it did.

Checking the log, I saw the above message.  This is the first time since the 
last reboot the problem has occurred, and the first such message since the 
last reboot.  The message IS occurring when I have the key sticking problem, 
as shown by the timestamps.

You're talking about missed keypresses, but the end-user symptom I'm seeing is 
definitely a missed key release, and it's associated with the above log 
message.

Rob
