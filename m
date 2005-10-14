Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVJNEeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVJNEeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 00:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVJNEeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 00:34:03 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:56583 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751203AbVJNEeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 00:34:01 -0400
Date: Fri, 14 Oct 2005 06:32:34 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4.31] Reintroduction i386 CONFIG_DUMMY_KEYB option
Message-ID: <20051014043234.GJ22601@alpha.home.local>
References: <200510131838.45082.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510131838.45082.nick@linicks.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Oct 13, 2005 at 06:38:44PM +0100, Nick Warne wrote:
(...)
> diff -Naur linux-2.4.31.orig/arch/i386/kernel/dmi_scan.c 
> linux-2.4.31n/arch/i386/kernel/dmi_scan.c
> --- linux-2.4.31.orig/arch/i386/kernel/dmi_scan.c	Wed Nov 17 11:54:21 2004
> +++ linux-2.4.31n/arch/i386/kernel/dmi_scan.c	Wed Oct 12 15:57:27 2005
> @@ -412,11 +412,13 @@
>  static __init int broken_ps2_resume(struct dmi_blacklist *d)
>  {
>  #ifdef CONFIG_VT
> +#ifndef CONFIG_DUMMY_KEYB

Please could you change this to #if defined(CONFIG_VT) && !defined(CONFIG_DUMMY_KEYB) ?

Marcelo, I'd like this one to be merged, as it is useful to many of us, and
is already fixed in 2.6 (where you're not forced to have a keyboard). It's
not intrusive and at most a build fix. Would you please accept Nick's patch
after the little clean-up above ?

Thanks in advance,
Willy

