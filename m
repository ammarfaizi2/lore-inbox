Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUHAXU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUHAXU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 19:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUHAXU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 19:20:59 -0400
Received: from astro.futurequest.net ([69.5.28.104]:53703 "HELO
	astro.futurequest.net") by vger.kernel.org with SMTP
	id S261239AbUHAXU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 19:20:58 -0400
From: Daniel Schmitt <pnambic@unu.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
Date: Mon, 2 Aug 2004 01:20:55 +0200
User-Agent: KMail/1.6.2
Cc: mingo@redhat.com
References: <20040713143947.GG21066@holomorphy.com> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
In-Reply-To: <20040801193043.GA20277@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408020120.55127.pnambic@unu.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 August 2004 21:30, Ingo Molnar wrote:
> here's the latest version of the voluntary-preempt patch:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-O2

One minor problem: this crashes hard (in interrupt context, stack pointer is 
bogus) during early boot iff CONFIG_REGPARM is set. With the earlier patches, 
this didn't happen. No ill effects so far with the default ABI; performance 
(apart from the usual reiserfs problems) is flawless.

Context: plain 2.6.8-rc2 + O2, gcc (GCC) 3.3.4 20040623 (Gentoo Linux 
3.3.4-r1, ssp-3.3.2-2, pie-8.7.6), EPoX 8RDA3+ (nForce2) motherboard. If you 
need more information, let me know.

Ciao,

Daniel.

