Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUE3V1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUE3V1y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 17:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUE3V1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 17:27:54 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:29312 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264411AbUE3V1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 17:27:52 -0400
Date: Sun, 30 May 2004 23:28:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040530212816.GA2987@ucw.cz>
References: <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org> <20040530114332.GA1441@ucw.cz> <MPG.1b23f41bee99410e9896a8@news.gmane.org> <20040530125918.GA1611@ucw.cz> <MPG.1b2424ed871e68c89896aa@news.gmane.org> <20040530203146.GA1941@ucw.cz> <MPG.1b2467af841573119896ae@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b2467af841573119896ae@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 10:51:18PM +0200, Giuseppe Bilotta wrote:

> > Interesting. Nevertheless it's just a naming difference, and thus
> > shouldn't be a problem.
> 
> Well, it's not just that, not if we want Meta kernel keys to 
> become Meta X keys. Which wouldn't be a bad thing, since it 
> would mean we'd have the keyboard acting the same under console 
> and X. But in this case it would be nice if Linux knew about 
> more modifiers than just shift, ctrl, alt, meta.

Keep in mind that the kernel keys we're talking about are keycodes, not
keysyms, and thus are not a result of a keymap. On the other hand, the
xkb tables you've shown are for keysyms.

The equivalences are:

Kernel		   XKB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
KEY_LEFTALT    ==  key <LALT> 
KEY_RIGHTALT   ==  key <RALT> 
KEY_LEFTMETA   ==  key <LWIN> 
KEY_RIGHTMETA  ==  key <RWIN> 
KEY_COMPOSE    ==  key <MENU> 

There is a 1:1 mapping. 

Now, if you want to make them _do_ the same both in X and on console,
then we're talking keymaps, and there I think is no problem again,
because the kernel can handle up to 9 modifiers as far as I know,
although they don't all have names.

linux/keyboard.h:#define NR_SHIFT       9

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
