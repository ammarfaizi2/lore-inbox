Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTJ3JJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 04:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTJ3JJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 04:09:50 -0500
Received: from gprs197-81.eurotel.cz ([160.218.197.81]:56704 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262057AbTJ3JJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 04:09:48 -0500
Date: Thu, 30 Oct 2003 10:09:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, geert@linux-m68k.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Cursor problems still in test9
Message-ID: <20031030090934.GC295@elf.ucw.cz>
References: <20031028094907.GA1319@elf.ucw.cz> <Pine.LNX.4.44.0310300436440.28721-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310300436440.28721-100000@phoenix.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [And they get worse in fbcon-test patches I tried].
> > 
> > Try this on 2.4 (with vesafb).
> > 
> > echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"
> > 
> > ...then try it on 2.6, type foo in bash then delete it using
> > backspace; ghost cursors stay there. Run emacs and quit it (it sets
> > cursor to very visible). Boom, special cursor settings are gone.
> 
> I experimented with the above. I tried it out on vgacon, fbcon 2.4.X and 
> fbcon 2.6.X. All give different results. What are suppose to see? 

Well, we certainly do not want to see artifacts leaved behind cursor,
which is what 2.6 currently does. (Type something in bash, backspace
over it).

Making it behave like it does now with 2.6, but with cursor properly
deleted after after backspace, it would be okay.

[It should behave the same way on 2.4 vgacon and fbcon... with
possible difference that "bright background" might cause characters to
blink on vgacon. That depends on vga card setting and is not really
important.]

> > And now, use gpm on text console to select some text. Hold down left
> > button, move mouse a bit. Sometimes cursor gets corrupted and stays
> > there.
> 
> Will try.

Were you able to reproduce it?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
