Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271559AbTGQVEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271557AbTGQVEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:04:41 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:1541 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S271567AbTGQVEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:04:34 -0400
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
References: <20030717141847.GF7864@charite.de>
	<m38yqxf2ab.fsf@lugabout.jhcloos.org>
	<20030717201039.GC25759@charite.de>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030717201039.GC25759@charite.de>
Date: 17 Jul 2003 17:18:28 -0400
Message-ID: <m365m0etsr.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ralf" == Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> writes:

Ralf> atkbd.c: Unknown key (set 2, scancode 0xb2, on isa0060/serio0) pressed.

Ralf> But this happened while typing NORMALLY, with no frills :) I
Ralf> mean, I was just typing in some unix commands - so I never even
Ralf> came close to the keys I never use anyway...

Interesting.

The one example I quoted above, atkbd_set2_keycode[0xb2] is in fact 0.

Perhaps your kb is doing something unusual w/ the key release events.

If the kb is, eg, |=ing w/ 0x80 rather than preceding w/ 0xf0 then
0xb2 would be the release event for 0x32.  atkbd_set2_keycode[0x32]
is 48 (KEY_B in input.h).  

So if you get unknown scancode 0xb2 from hitting the B key, that is
the cause.

Otherwise, perhaps a list of some keys and what they printk()
might help debug it.

-JimC

