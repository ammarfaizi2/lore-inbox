Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274288AbRJEWuG>; Fri, 5 Oct 2001 18:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274287AbRJEWt4>; Fri, 5 Oct 2001 18:49:56 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:7434 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S274236AbRJEWtl>;
	Fri, 5 Oct 2001 18:49:41 -0400
Date: Sat, 6 Oct 2001 00:50:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Etienne Lorrain <etienne_lorrain@yahoo.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Input PS/2 driver
Message-ID: <20011006005006.A17152@suse.cz>
In-Reply-To: <20011003133440.28925.qmail@web11804.mail.yahoo.com> <Pine.LNX.4.10.10110031217300.32026-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10110031217300.32026-100000@transvirtual.com>; from jsimmons@transvirtual.com on Wed, Oct 03, 2001 at 12:28:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 12:28:34PM -0700, James Simmons wrote:
> 
> >   Would be nice to change the comment describing the Keyboard core
> >  support (CONFIG_INPUT_KEYBDEV) in this patch: people (as dumb me)
> >  may read the help in menuconfig and say:
> >  I have no USB HID or ADB keyboard...
> >  Recompile, reboot => no keyboard, no control-alt-del => Reset (fsck...).
> 
> Yeah. That does need to be added. 
> 
> >   Else it is working here on a P133 with nothing special (std PS2 mouse).
> 
> >From the several reports I have had with the driver it looks pretty
> stable. Alan what do you think about adding it to the ac tree?
> 
> >   BTW you just undefine I8042_OVERRIDE_KEYLOCK but this define is
> >  never used.
> 
> Not implemented yet.

Quite the opposite: #undef was forgotten in the .h file after the .c
file converted to a runtime option instead of a compiletime one. I
removed it in the CVS now.

-- 
Vojtech Pavlik
SuSE Labs
