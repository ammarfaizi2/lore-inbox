Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWANLCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWANLCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 06:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWANLCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 06:02:49 -0500
Received: from boxa.alphawave.net ([207.218.5.130]:61359 "EHLO
	box.alphawave.net") by vger.kernel.org with ESMTP id S1751231AbWANLCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 06:02:48 -0500
To: Jim MacBaine <jmacbaine@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/vm/swappiness == 0 makes OOM killer go beserk
In-Reply-To: <5uzvD-8tr-19@gated-at.bofh.it>
References: <5uzvD-8tr-19@gated-at.bofh.it>
Date: Sat, 14 Jan 2006 11:02:31 +0000
Message-Id: <20060114110231.06B6F14C6FD@irishsea.home.craig-wood.com>
From: nick@craig-wood.com (Nick Craig-Wood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
>  the OOM killer just killed some of my processes while the system
>  still had >2.5 GB of free swap. I'm running vanilla 2.6.15 on my
>  desktop.  The machine is a single Athlon64, 1 GB RAM, 3 GB swap,
>  x86_64 kernel, (mostly) i386 userland.  A few days ago I have set
>  /proc/sys/vm/swappiness to 0 to see whether it would increase the
>  interactive performance.

I have to say I've noticed the same thing.

On my home workstation I do a lot of stuff with very large video
files, so set swappiness to 0 some time ago so using these large files
would stop all the applications getting pushed out into swap.

However I've noticed that ocassionally the kernel has killed large
memory processes (eg firefox!) even when there was lots of swap free.

Recently, I found I just could not use gimp to edit a very large image
(about 800MB on a 1 GB machine) without the OOM killer killing it.
When I reset swappiness to 60 I could then use gimp fine.

This doesn't seem like correct behaviour to me!  (Though I note the
caveat I read somewhere that swappiness probably doesn't do what I
think it does - it probably doesn't!)

-- 
Nick Craig-Wood <nick@craig-wood.com> -- http://www.craig-wood.com/nick
