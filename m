Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUIAErs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUIAErs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 00:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUIAErs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 00:47:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:18313 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268083AbUIAErq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 00:47:46 -0400
Date: Tue, 31 Aug 2004 21:45:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: orders@nodivisions.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfsd stuck in D state
Message-Id: <20040831214554.03fe70e7.akpm@osdl.org>
In-Reply-To: <41353913.70102@nodivisions.com>
References: <41353913.70102@nodivisions.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony DiSante <orders@nodivisions.com> wrote:
>
> I'm running devfs v1.22 on this Gentoo system:
> 
> 
>  Linux soma 2.6.3 #8 Thu Jun 10 00:17:31 EDT 2004 i686 Pentium III 
>  (Coppermine) GenuineIntel GNU/Linux
> 
> 
>  ...and I just unplugged my USB memory-stick reader.  That apparently caused 
>  devfsd to go into "D" state (uninterruptible sleep, right?):
> 
> 
>  root       118  0.0  0.1  1832  924 ?        D    Aug27   0:01 /sbin/devfsd /dev
> 
> 
>  ...and it won't come back.  CPU is idle, but load is:
> 
> 
>  load average: 52.90, 51.41, 49.48
> 
> 
>  ...and now some weird stuff is happening, for example man doesn't work, and 
>  ps works but doesn't return.  (top works, vmstat works...)
> 
>  killall -HUP devfsd doesn't do anything.
> 
>  Is it possible to fix this without rebooting?

Probably not.

Please do

	dmesg -c
	echo t > /proc/sysrq-trigger
	dmesg -s 1000000 > foo

then send us foo.  Then reboot.
