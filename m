Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSIZIxt>; Thu, 26 Sep 2002 04:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbSIZIxt>; Thu, 26 Sep 2002 04:53:49 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:52107 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262137AbSIZIxt>;
	Thu, 26 Sep 2002 04:53:49 -0400
Date: Thu, 26 Sep 2002 10:58:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse/Keyboard problems with 2.5.38
Message-ID: <20020926105853.A168142@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1032996672.11642.6.camel@chevrolet>; from liste@jordet.nu on Thu, Sep 26, 2002 at 01:31:12AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 01:31:12AM +0200, Stian Jordet wrote:

> I haven't really tried a 2.5 kernel for a very long time. I used some of
> the earliest, but then I suddenly had problems booting one of them, and
> haven't really taken much effort in getting it boot lately.
> 
> But now I decided I should try again. I got 2.5.38 booted after some
> initial trouble. But, I have a couple of weird problems. First, the
> mouse. I have a Logitech Cordless Optical mouse. With kernel 2.4.x I use
> MouseManPlusPS/2 as the XFree mouse-driver. Then I can use the wheel and
> the fourth button just as expected. But with kernel 2.5.38 neither the
> wheel or the fourth button works. I change protocol to IMPS/2 in XFree,
> and everything works like expected, but the fourth button works just
> like pussing the wheel (third button). This is excactly the same
> behavior as with 2.4.20-pre7 (that's why I use MouseManPlusPS/2). Anyone
> have a clue why this doesn't work with kernel 2.5.38?

Use ExplorerPS/2 in XFree to get access to all the buttons. The new
input drivers handle the MouseMan protocol right in the kernel, and
independently on the real mouse type (ImPS/2, ImExPS/2, GenPS/2,
Logitech PS2++ USB, Busmouse, whatever) export an ExplorerPS/2-like
virtual mouse to userspace. This is what most applications support
correctly, and is compatible with generic PS/2 and ImPS/2 protocols also.

> Second problem, if I press SHIFT+PAGEUP, my computer freezes. It spits
> out this message: "input: AT Set 2 keyboard on isa0060/serio0, and then
> it's dead. I have a Logitech cordless keyboard. 
> 
> Anyone else experienced this?

I fixed this in about 2.5.36. Please #define ATKBD_DEBUG in
drivers/input/keyboard/atkbd.c, and send me the kernel output just
before the crash, please. I'll try to reproduce it here meanwhile.

-- 
Vojtech Pavlik
SuSE Labs
