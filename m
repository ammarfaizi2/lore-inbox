Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUDSSMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 14:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUDSSMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 14:12:31 -0400
Received: from smtp-out8.xs4all.nl ([194.109.24.9]:32019 "EHLO
	smtp-out8.xs4all.nl") by vger.kernel.org with ESMTP id S261615AbUDSSM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 14:12:28 -0400
Date: Mon, 19 Apr 2004 20:11:59 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KVM issues with recent 2.6 kernels
Message-ID: <20040419181159.GA10708@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <Pine.LNX.4.58.0404191216020.31750@ppg_penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404191216020.31750@ppg_penguin>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ken Moffat <ken@kenmoffat.uklinux.net>
Date: Mon, Apr 19, 2004 at 12:36:30PM +0100
> Hi,
> 
>  I'm seeing some oddities on two 2.6 boxes here.  I use a Belkin Omni
> 4-way PS/2 KVM switch.  It has a "hot key" to switch boxes (scroll-lock
> twice, then number 1-4).  This has always been a little problematic on
> 2.4 (you have to get the timing of the key presses right, worst case
> when you get to the session either the number has been treated as input,
> or the display has scroll-lock turned on), but usable.

I have a 4 port Vista KVM from Rose Electronics, where hot key is a
single left control. That doesn't interfere as much.

I'm running 2.6.x on 2 machines, windows XP on a third.

> 
>  The duron is now being used to do things in xterms.  From time to time
> the alt key stops being recognised (no alt-tab to switch windows, no
> ctrl-alt-n to switch desktops).  And then after again switching machines
> it suddenly starts working properly again.
> 
>  Any suggestions on where to look, or which parts of my .config would be
> relevant ?
> 
Does your KVM also have keys on the kvm to switch? If so, does the
problem go away if you use those?

Otherwise, perhaps hack drivers/input/keyboard/atkbd.c (dunno if that is
the correct path) to log when a scroll-lock is received) and then throw
away that keypress?

Good luck,
Jurriaan
-- 
"Satire is great, but for Nazis you use baseball bats and broken bottles."
        Woody Allen
Debian (Unstable) GNU/Linux 2.6.5-mm6 2x6062 bogomips 2.86 1.98
