Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264622AbUEaMum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbUEaMum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 08:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUEaMul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 08:50:41 -0400
Received: from main.gmane.org ([80.91.224.249]:37085 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264622AbUEaMud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 08:50:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Date: Mon, 31 May 2004 14:43:20 +0200
Message-ID: <MPG.1b25456596db4c5f9896b2@news.gmane.org>
References: <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org> <20040530114332.GA1441@ucw.cz> <MPG.1b23f41bee99410e9896a8@news.gmane.org> <20040530125918.GA1611@ucw.cz> <MPG.1b2424ed871e68c89896aa@news.gmane.org> <20040530203146.GA1941@ucw.cz> <MPG.1b2467af841573119896ae@news.gmane.org> <20040530212816.GA2987@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oblomov.dipmat.unict.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sun, May 30, 2004 at 10:51:18PM +0200, Giuseppe Bilotta wrote:
> 
> > > Interesting. Nevertheless it's just a naming difference, and thus
> > > shouldn't be a problem.
> > 
> > Well, it's not just that, not if we want Meta kernel keys to 
> > become Meta X keys. Which wouldn't be a bad thing, since it 
> > would mean we'd have the keyboard acting the same under console 
> > and X. But in this case it would be nice if Linux knew about 
> > more modifiers than just shift, ctrl, alt, meta.
> 
> Keep in mind that the kernel keys we're talking about are keycodes, not
> keysyms, and thus are not a result of a keymap. On the other hand, the
> xkb tables you've shown are for keysyms.
> 
> The equivalences are:
> 
> Kernel		   XKB
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> KEY_LEFTALT    ==  key <LALT> 
> KEY_RIGHTALT   ==  key <RALT> 
> KEY_LEFTMETA   ==  key <LWIN> 
> KEY_RIGHTMETA  ==  key <RWIN> 
> KEY_COMPOSE    ==  key <MENU> 
> 
> There is a 1:1 mapping. 
> 
> Now, if you want to make them _do_ the same both in X and on console,
> then we're talking keymaps, and there I think is no problem again,
> because the kernel can handle up to 9 modifiers as far as I know,
> although they don't all have names.
> 
> linux/keyboard.h:#define NR_SHIFT       9

Point fully taken. I retreat in a corner with a big 'A' cone 
cap on my head.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

