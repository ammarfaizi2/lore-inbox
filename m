Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbULBXro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbULBXro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 18:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULBXro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 18:47:44 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:59311 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261750AbULBXrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 18:47:42 -0500
Date: Fri, 3 Dec 2004 00:47:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041202234723.GG32635@dualathlon.random>
References: <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202110729.57deaf02.akpm@osdl.org> <1102014493.13353.239.camel@tglx.tec.linutronix.de> <20041202112208.34150647.akpm@osdl.org> <1102015450.13353.245.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102015450.13353.245.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 08:24:10PM +0100, Thomas Gleixner wrote:
> because oom killed sshd. So I cannot send anything except a service man,
> who drives 150km to hit sysrq-F or the reset button.

You'd need a little old computer next to your server with serial console
attached to it for it to be effective. But it sounds more like a last
resort and it makes economical sense only if you're not hosting your
server and you've your own server room. Normally one doesn't need to
drive 150km just because you can call somebody at the phone to click
reboot (worse than SYSRQ+F [unless it was the critical app itself
hitting a memleak], but much cheaper than hosting a serial console
server too).

The SYSRQ+F sounds more useful on a desktop usage, if you've tons and
tons of swap. Don't forget that with an huge amount of swap, you're
telling the kernel "please make my machine extremely slow if all apps
uses the ram at the same time". In many situations it may be more
efficicient for you to kill one of these apps, wait the other to finish,
and restart the killed app from scratch (to avoid trashing, and the
kernel _can't_ avoid trashing or it wouldn't be fair anymore). So if you
do a mistake and you want to recover responsiveness in less than a
second, the SYSRQ+F trick should make it.
