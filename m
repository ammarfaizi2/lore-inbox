Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbTAYNA5>; Sat, 25 Jan 2003 08:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbTAYNA5>; Sat, 25 Jan 2003 08:00:57 -0500
Received: from [81.2.122.30] ([81.2.122.30]:3588 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266411AbTAYNA4>;
	Sat, 25 Jan 2003 08:00:56 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301251310.h0PDAaai000191@darkstar.example.net>
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sat, 25 Jan 2003 13:10:36 +0000 (GMT)
Cc: vojtech@suse.cz, tomita@cinet.co.jpmiura@da-cha.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030125120113.B28830@ucw.cz> from "Vojtech Pavlik" at Jan 25, 2003 12:01:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The keymapping on my Japanese keyboard changes quite a bit when it's
> > set up to use set 3, instead of the default set 2.  I've temporarily
> > switched back to using set 2, until I've got time to set it up
> > properly, but the language keys don't function in set 2, (they
> > generate the same scancode as the space bar).
> > 
> > Let me know if I can provide any extra info from this keyboard - it's
> > an IBM 5576 Keyboard-2, part number 94X1110.
> 
> If you can provide the complete key -> scancode table for that keyboard,
> or at least differences against standard US keyboard for both set 2 and
> set 3, that'd be great.

OK, half way through writing it down, I've realised what is happening
- in set 2, the keyboard seems to be emulating another keyboard
layout, (but apparently not a US or UK one).

For example, ; and : are on different keys.  Shift ; gives + and shift
: gives *

The keycodes generated, though, show up as follows:

; - 39
shift ; (+) - 13
: - 42, 39, release 39, release 42
shift : (*) - 9

So, if I press : on it's own, the keyboard actually simulates pressing
shift and ;

Likewise, if I press right-shift and @ to get ` the keyboard actually
sends a release 54 as soon as I press @, even though I'm still holding
down right-shift, then sends 41, release 41, then 54

I suspect set 3 will producde a more direct mapping of a single
keycode for each key, but we shall see...

I'll send along the complete list when I've finished it, (it's taking
ages :-) ).

John.
