Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318497AbSGSKfY>; Fri, 19 Jul 2002 06:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318498AbSGSKfY>; Fri, 19 Jul 2002 06:35:24 -0400
Received: from ns.suse.de ([213.95.15.193]:12556 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318497AbSGSKfX>;
	Fri, 19 Jul 2002 06:35:23 -0400
To: Andrew Rodland <arodland@noln.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH -ac] Panicking in morse code
References: <20020719011300.548d72d5.arodland@noln.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Jul 2002 12:38:24 +0200
In-Reply-To: Andrew Rodland's message of "19 Jul 2002 07:17:08 +0200"
Message-ID: <p737kjsuhnj.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Rodland <arodland@noln.com> writes:

> I was researching panic_blink() for someone who needed a little help,
> when I noticed the comment above the function definition, not being the
> kind to step down from a challenge (unless it's just really hard), I
> decided to write morse code output code.

Great. Congratulations (having written the original comment).

I would encode the morse strings as bits in a integer instead of strings
though (perhaps with some macros to make it readable), that should shrink 
it quite a bit.

> 
> The option panicblink= has been hijacked to be a simple bitfield: 
> bit 1 : blink LEDs
> bit 2 : sound the PC speaker.
> 
> the blinking option depends only on pc_keyb.c. the pcspeaker option
> depends on kb_mksound() actually doing something. At the moment, both of
> these mean i386. The call to panic_blink() in panic() is still guarded
> by an i386 #ifdef, anyway, for the moment. The default is to blink only,
> because I figured the beeps would be too annoying. Opinions?

I would consider beeps annoying, but then I usually just cut the beeper
line on any new PC I install so personally I do not care. Still imagine
what a machine room that overheated and caused several boxes to panic
would sound like...

-Andi
