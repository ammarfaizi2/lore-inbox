Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281142AbRKLWuo>; Mon, 12 Nov 2001 17:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281158AbRKLWud>; Mon, 12 Nov 2001 17:50:33 -0500
Received: from [62.47.19.205] ([62.47.19.205]:4255 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S281142AbRKLWuP>;
	Mon, 12 Nov 2001 17:50:15 -0500
Message-ID: <3BF04D05.2F0E18CB@webit.com>
Date: Mon, 12 Nov 2001 23:28:21 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mysterious power off problem 2.4.10-2.4.14 on laptop
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linda,

it could be a bad BIOS.

I don't know if this helps, but anyway:

I had a similar problem, but in ma case the machine just went to suspend
mode - annoying, but somewhat easier to track. Just like in your case,
nothing worked; switching off APM in BIOS, disabling APM in kernel, etc.
no matter what I did (typing, using the mouse), the machine suspended.

Well:

Question 1: Are you running Windows on that machine, too? If no, you
have a different problem; as said, most probably caused by a bad BIOS.
That it worked under a previous 2.4.x kernel doesn't mean a lot; apm
could have interpreted bad (malformed) apm messages in a different way
(just a guess).

Question 2: If yes: Did you ever happen to try to boot (ie cold boot =
switch ON) the machine with AC power chord connected after a Windows
session?

In my case, it was a bug in the BIOS. This piece of sh** - right after a
Windows session - reported a battery charging status of _more_ than
100%, leading into miscomprehending APM messages from the BIOS - leading
into APM confusion. Strange enough, this _only_ happened when _switching
on_ the machine on battery. It never happens when booting with AC
connected.

Even more strange, in my case it is sufficient to cold boot the machine
_once_ after running Windows on AC to avoid the effect in the future
(however, until running windows again).

Good luck,

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:         
mailto:tw@webit.com              *** http://www.webit.com/tw
