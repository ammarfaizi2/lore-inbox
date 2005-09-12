Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVILKP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVILKP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 06:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVILKP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 06:15:58 -0400
Received: from koto.vergenet.net ([210.128.90.7]:43669 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750702AbVILKP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 06:15:57 -0400
Date: Mon, 12 Sep 2005 18:48:30 +0900
From: Horms <horms@debian.org>
To: Anthony DeRobertis <anthony@derobert.net>, 327355@bugs.debian.org
Cc: Gadi Oxman <gadio@netvision.net.il>, linux-kernel@vger.kernel.org
Subject: Re: Bug#327355: linux-image-2.6.12-1-k7: amverify w/ ide-tape causes bug, then kernel panic
Message-ID: <20050912094828.GP19201@verge.net.au>
References: <E1EDiEU-0003Sa-00@Maxwell.derobert.net> <handler.327355.B.112626983510089.ack@bugs.debian.org> <43228009.30705@derobert.net> <E1EDiEU-0003Sa-00@Maxwell.derobert.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43228009.30705@derobert.net> <E1EDiEU-0003Sa-00@Maxwell.derobert.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anthony,

I am forwarding this to the IDE Tape maintainer for his consideration.

-- 
Horms

On Fri, Sep 09, 2005 at 08:43:54AM -0400, Anthony DeRobertis wrote:
> Package: linux-image-2.6.12-1-k7
> Version: 2.6.12-6
> Severity: important
> 
> amverify started, then shortly later (after the first thing was done
> verifying, I think) these managed to make it to syslog. As you can see,
> it got the bug message, then rebooted itself a few minutes later:
> 
> Sep  9 01:12:27 Maxwell kernel: ide-tape: bug: tape->next_stage != NULL
> Sep  9 01:16:14 Maxwell kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
> Sep  9 01:16:14 Maxwell kernel: Inspecting /boot/System.map-2.6.12-1-k7
> 
> This is quite repeatable, and I never saw it on 2.6.8 (sarge). I'll test
> that particular tape on 2.6.8 just to be sure.
> 
> Shortly (as in a second at most) after that, it panics (with the "in the
> interrupt handler, not syncing" message), which doesn't make it to the
> log. If that info is imporant, I'll work on getting a serial console to
> capture it.
> 
> -- System Information:
> Debian Release: 3.1
>   APT prefers unstable
>   APT policy: (101, 'unstable')
> Architecture: i386 (i686)
> Kernel: Linux 2.6.12-1-k7
> Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)
> 
> Versions of packages linux-image-2.6.12-1-k7 depends on:
> ii  coreutils [fileutils]         5.2.1-2    The GNU core utilities
> ii  fileutils                     5.2.1-2    The GNU file management utilities 
> ii  initrd-tools                  0.1.81.1   tools to create initrd image for p
> ii  module-init-tools             3.2-pre1-2 tools for managing Linux kernel mo
> 
> -- no debconf information
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-kernel-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org

On Sat, Sep 10, 2005 at 02:41:13AM -0400, Anthony DeRobertis wrote:
> Oh, btw, it just died on a different tape tonight... I rebooted to
> 2.6.8, and it works fine there. So its definitely a regression from 2.6.8.
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-kernel-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
