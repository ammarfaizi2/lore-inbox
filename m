Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTLTJfn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 04:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTLTJfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 04:35:43 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:43196 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263956AbTLTJfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 04:35:41 -0500
Date: Sat, 20 Dec 2003 10:35:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: ryutaroh@it.ss.titech.ac.jp
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
Message-ID: <20031220093532.GB6017@ucw.cz>
References: <20031219.212456.74735601.ryutaroh@it.ss.titech.ac.jp> <20031219123645.GA28801@ucw.cz> <20031220.183049.74735752.ryutaroh@it.ss.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220.183049.74735752.ryutaroh@it.ss.titech.ac.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 20, 2003 at 06:30:49PM +0900, ryutaroh@it.ss.titech.ac.jp wrote:

> Thank you for your very quick reply.
> 
> From: Vojtech Pavlik <vojtech@suse.cz>
> > Can you try the attached patch?
> 
> The problem was not solved.
> 
> When I pressed the bar key on JP 106 keyboard, the output of "showkey
> -k" is
> 
> keycode   0 press
> keycode   1 release
> keycode  54 release
> keycode   0 release
> keycode   1 release
> keycode  54 release
> 
> The scancode does not change. Before applying your patch to the
> original kernel, the output was
> 
> keycode   0 press
> keycode   1 release
> keycode  55 release
> keycode   0 release
> keycode   1 release
> keycode  55 release
> 
> which corresponds to keycode 183 (= 1*128 + 55).
> 
> The output of Linux 2.4.23 was
> 
> keycode 124 press
> keycode 124 release
> 
> 
> By the way, the bar key on JP 106 keyboard is actually the backslash
> key and bar is equal to shift-backslash on JP 106. But there is
> another backslash key (scancode 0x73) and input of backslash is not a
> problem.

Keycode 183 is correct for the japanese backslash key. 2.4 didn't
differentiate, 2.6 does. You just need to update your keymap.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
