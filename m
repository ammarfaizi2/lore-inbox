Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUJaLsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUJaLsq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUJaLra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:47:30 -0500
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:21632 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261552AbUJaLb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 06:31:59 -0500
Date: Sun, 31 Oct 2004 12:30:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/8] sonypi: rework input support
Message-ID: <20041031113015.GA1044@elf.ucw.cz>
References: <20041028100525.GA3893@crusoe.alcove-fr> <20041028100823.GE3893@crusoe.alcove-fr> <20041029101050.GA1183@elf.ucw.cz> <20041029104138.GA3222@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029104138.GA3222@crusoe.alcove-fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +	{ SONYPI_EVENT_FNKEY_F1, 		KEY_FN_F1 },
> > > +	{ SONYPI_EVENT_FNKEY_F2, 		KEY_FN_F2 },
> > > +	{ SONYPI_EVENT_FNKEY_F3, 		KEY_FN_F3 },
> [...]
> 
> > KEY_FN_D does not sound too usefull (similar for FN_F1..FN_F12). Are
> > there some pictures on those keys? 
> 
> Some of them have pictures (Fn-Esc for suspend to ram, Fn-F12 for
> suspend to disk, Fn-F3 for mute, Fn-F4 for launching the volume
> controls, Fn-F5 for launching the brightness controls, Fn-F7/F8 for
> changing from LCD to external monitor or TV). All the others have
> no pictures on them.

In such case I'd assign meaningfull events at least to keys with
labels?

> > Mapping FN_F3 to for example
> > KEY_SUSPEND would be usefull...
> 
> This sound like policy to me and should not be done into the
> kernel but somewhere you can configure it, like in a keyboard 
> keymap or something like that.

Eh? You are basically doing arbitrary mapping between sony events to
linux keycodes. You might as well make the mapping usefull while you
are at it.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
