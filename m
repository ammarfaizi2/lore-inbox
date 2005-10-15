Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVJOGXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVJOGXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 02:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVJOGXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 02:23:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:61191 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751091AbVJOGXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 02:23:21 -0400
Date: Sat, 15 Oct 2005 08:21:25 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Forcing an immediate reboot
Message-ID: <20051015062125.GK22601@alpha.home.local>
References: <43505F86.1050701@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43505F86.1050701@perkel.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 06:46:46PM -0700, Marc Perkel wrote:
> Is there any way to force an immediate reboot as if to push the reset 
> button in software? Got a remote server that i need to reboot and 
> shutdown isn't working.

If you can telnet it, simply use this :

# echo 1 >/proc/sys/kernel/sysrq
# echo b >/proc/sysrq-trigger

It's dirty and you'll have an fsck. But it will nearly always work.
I use it a lot in local on distros on which the shutdown process is
as long as the boot process (you know, the ones which display lots
of 'OK' or wait indefinitely for some dead services to stop, when
you really want them to reboot quickly).

Cheers,
Willy

