Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUANNyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 08:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUANNyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 08:54:36 -0500
Received: from ns.suse.de ([195.135.220.2]:22676 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261522AbUANNye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 08:54:34 -0500
Date: Wed, 14 Jan 2004 14:54:33 +0100
From: Olaf Hering <olh@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: bad scancode for USB keyboard
Message-ID: <20040114135433.GA26587@suse.de>
References: <3FF6EFE0.9030109@develer.com> <3FFB6A5D.9030606@olaussons.net> <3FFB6E9E.6040500@develer.com> <20040107085104.GA14771@ucw.cz> <20040111163050.GA28671@zombie.inka.de> <20040111184445.GA30711@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040111184445.GA30711@ucw.cz>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Jan 11, Vojtech Pavlik wrote:

> On Sun, Jan 11, 2004 at 05:30:50PM +0100, Eduard Bloch wrote:
> 
> > #include <hallo.h>
> > * Vojtech Pavlik [Wed, Jan 07 2004, 09:51:04AM]:
> > 
> > > The reason is that this key is not the ordinary backslash-bar key, it's
> > > the so-called 103rd key on some european keyboards. It generates a
> > > different scancode.
> > 
> > Fine, but there are a lot of USB keyboard that _work_ that way, where
> > the "103rd" key is really positioned as the one and the only one '# key.
> > And the current stable X release does NOT know about the new scancode.
> > You realize that you intentionaly broke compatibility within a stable
> > kernel release?
> 
> Good point. And I'm suffering the consequences already. Up to the
> change, I didn't know that so many keyboards are actually using this
> key, so I supposed it'll be a rather low-impact change. I stand
> corrected now.
> 
> Linus, Andrew, please apply this fix:
> 
> ChangeSet@1.1511, 2004-01-11 19:41:05+01:00, vojtech@suse.cz
>   input: Fix emulation of PrintScreen key and 103rd Euro key for XFree86.

I tried the 2.6.1-mm2 tree and changed the 84 to 43, but that doesnt
help my USB keyboard. Showkey does still show 84.

static unsigned short x86_keycodes[256] =
...
         80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
...

Maybe adbhid needs a similar tweak? I could not find the place, yet.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
