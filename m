Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUFDN6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUFDN6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 09:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbUFDN6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 09:58:39 -0400
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:18305 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265782AbUFDN6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 09:58:30 -0400
Date: Fri, 4 Jun 2004 15:58:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040604135816.GD11950@elf.ucw.cz>
References: <MPG.1b2111558bc2d299896a2@news.gmane.org> <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de> <xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de> <20040529131233.GA6185@ucw.cz> <xb7y8nab65d.fsf@savona.informatik.uni-freiburg.de> <20040530101914.GA1226@ucw.cz> <xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     >> >> What I hate is only the part where mouse/keyboard drivers
>     >> >> are now in kernel space.  The translation of raw byte
>     >> >> streams into input events should be better done in userland.
>     >> >> One important argument is: userland program may be swapped
>     >> >> out.  Kernel modules can't.
>     >> 
> 
>     Vojtech> Well, keyboard support was always in the kernel
> 
> Once in kernel space, forever in kernel space?  What's the logic?
> 
> Where  it is  now possible  to  move it  out of  kernel space  WITHOUT
> performance problems, why not move it out?

You get pretty nasty managment problems. How do you do init=/bin/bash
if your keyboard is userspace?

>     Vojtech> But still, if you have a working keyboard, the handling
>     Vojtech> is done in the kernel, and you can do a register dump,
>     Vojtech> process listing, etc, even when the system is
>     Vojtech> crashed.
> 
> Why just  the keyboard?  For that  purpose, we can  use mouse buttons,
> the  power button,  a joystick  button, or  even a  home-brewed button
> connected to the RS232 port or parallel port.  Why *limit* that to the
> keyboard?

Keyboard is historically used for that. It seems to work, no reason to
change it.

								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
