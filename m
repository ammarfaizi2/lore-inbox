Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTHZUOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbTHZUOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:14:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:62731 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262785AbTHZUOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:14:03 -0400
Date: Tue, 26 Aug 2003 22:09:09 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.23-pre1] /proc/ikconfig support
Message-ID: <20030826200909.GK734@alpha.home.local>
References: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 04:33:09PM -0300, Marcelo Tosatti wrote:
 
> And about ikconfig, hum, I'm not sure if I want that. Its nice, yes, but I
> still wonder. You are free to convince me though: I think people usually
> know what they compile in their kernels, dont they?

Marcelo,

I can say for sure that I would really like to have ikconfig (I've been using
other sorts of proc_config patches for a long time now). It's not something
strictly necessary (otherwise it would already have been in), but it's really
userful in some situations because we're humans and not fail-safe :

  - when a default kernel and a default config doesn't work on a customer's
    system, and I insist on the fact it's someone else, you end up trying
    several tricks till the time it finally runs. When you do this at a
    customer's and you're compiling your 30rd kernel at 23h40 with the man
    behind you with red eyes, you know for sure that at the very moment he
    will see it boot, he will say "ok, thanks a lot, now let's go to bed. bye!"
    When you come again several weeks after, he tells you that /usr/src/linux
    took lots of useless space on his tapes and he removed it. Given the late
    hour the last time, you didn't save the .config and definitely lost it.
    Believe me, I was happy to see that I still had the .config for the 500+
    days uptime kernel I reported a few days ago because that's not always the
    case (even if I didn't need it this time).

  - when trying patches, config options, optimizations, etc... it's common for
    some (most ?) of us to quickly copy a bzimage.test under /boot, which entry
    is already filled in lilo.conf, reboot it with init=/bin/sh and trying lots
    of dirty tricks. After a while, you don't remember which .config was used
    for the only one which causes trouble or which works, or you simply lost it
    in a quick "make distclean" or "cd ..&&rm -rf linux&&tar x&&cd -", and being
    able to recover it from bzimage or at run time would be great.

As you see, nothing much important in my opinion, but definitely compensates
for my unreliable brain and saves me much time. I don't really matter whether
you merge it or not, since I will use it anyway, but I see no reason it couldn't
serve others as well.

Cheers,
Willy

