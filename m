Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTIYHUC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTIYHSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:18:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52903 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261744AbTIYHS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:18:26 -0400
Date: Wed, 24 Sep 2003 12:02:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030924100233.GC11901@openzaurus.ucw.cz>
References: <1b7301c37a73_861bea70_2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2_6a8033e0_2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl> <20030921110629.GC18677@ucw.cz> <20030921143934.A11315@pclin040.win.tue.nl> <20030921124817.GA19820@ucw.cz> <20030921164914.C11315@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921164914.C11315@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > #define KEY_TEEN                0x19e
> > #define KEY_TWEN                0x19f
> > #define KEY_DEL_EOL             0x1c0
> > #define KEY_DEL_EOS             0x1c1
> > 
> > So far the last defined key is KEY_DEL_LINE, with a code of 0x1c3.
> > That's above 256. If there are other places that require less than 256,
> > well, then those will need to be fixed or we're heading for trouble.
> 
> Hmm. The kernel assumes today that keycodes have 8 bits:
> 
> In drivers/char/keyboard.c emulate_raw() tries to invent
> the codes that the keyboard probably sent and resulted in a given
> keycode. It starts out
> 	if (keycode > 255)
> 		return -1;
> 
> In drivers/input/keyboards/atkbd.c we have tables that convert
> scancodes to keycodes. The declaration is
> 	static unsigned char atkbd_set2_keycode[512];
> the unsigned char means that no keycodes larger than 255 can be returned.
> 
> It really seems a pity to have to add new ioctls, and to have to release
> a new version of the kbd package, and to waste a lot of kernel space,
> while essentially nobody needs the resulting functionality.

Multimedia keyboards are very common today,
and tv cards with their remote controls need it,
too.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

