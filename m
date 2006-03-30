Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWC3MBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWC3MBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWC3MBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:01:36 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:61870 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932182AbWC3MBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:01:35 -0500
Date: Thu, 30 Mar 2006 14:01:24 +0200
From: Voluspa <lista1@telia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-gitX] initcall at 0xffffffff804615d1: returned with
 error code -1
Message-Id: <20060330140124.3f67a17b.lista1@telia.com>
In-Reply-To: <20060330031949.2febaf62.akpm@osdl.org>
References: <20060330131115.73886fd4.lista1@telia.com>
	<20060330031949.2febaf62.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006 03:19:49 -0800 Andrew Morton wrote:
> Voluspa wrote:
[..]
> > 
> > Since then (now at 2.6.16-git18) the last/lower one has vanished, but the
> > first one remains. The patch says that the initcall function should be
> > printed, but it seems to need some debugging option set. Please advice if
> > this is of interest (the addresses do not stay constant). 
> > 
> 
> If you have CONFIG_KALLSYMS enabled then the kernel should print the name
> of the function at that address.  It's pretty hard to turn off
> CONFIG_KALLSYMS, actually.

Ah ok, kallsyms... I've been pampered by good quality kernels and turned it
off a long time ago.

initcall at 0xffffffff8049a5b0: late_hpet_init+0x0/0xb0(): returned with error code -1

loke@sleipner:/home/git$ grep -i hpet 2.6.16-git-kallsyms-.config
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y

Those options are just wish-thinking since the machine doesn't have that kind of timer.
So the warning should go away when I turn them off. Sorry about the noise.

Mvh
Mats Johannesson
--
