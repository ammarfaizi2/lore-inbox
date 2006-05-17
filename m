Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWEQAa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWEQAa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWEQAa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:30:26 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.24]:9819 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932396AbWEQAaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:30:02 -0400
X-ME-UUID: 20060517002959209.3326D1400089@mwinf0704.wanadoo.fr
Date: Wed, 17 May 2006 02:26:00 +0200
To: Junichi Uekawa <dancer@netfort.gr.jp>
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
Subject: Re: ppc: bogomips at 73 when CPU is at 1GHz
Message-ID: <20060517002600.GA10966@powerlinux.fr>
References: <87ac9hzn1g.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ac9hzn1g.dancerj%dancer@netfort.gr.jp>
User-Agent: Mutt/1.5.9i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 06:18:19AM +0900, Junichi Uekawa wrote:
> Hi,
> 
> I've noticed the very log value on bogomips on self-compiled 2.6.16.16
> on iBook G4.
> 
> [06:12:59]ibookg4:~> cat /proc/cpuinfo
> processor       : 0
> cpu             : 7447A, altivec supported
> clock           : 1066.666000MHz
> revision        : 0.1 (pvr 8003 0101)
> bogomips        : 73.47
> timebase        : 18432000
> machine         : PowerBook6,5
> motherboard     : PowerBook6,5 MacRISC3 Power Macintosh
> detected as     : 287 (iBook G4)
> pmac flags      : 0000001b
> L2 cache        : 512K unified
> pmac-generation : NewWorld
> 
> 
> It was somewhat higher on 2.6.14.
> 
> 
> Apparently I'm not the only person who noticed something similar; 
> but I can't really read spanish:
> 
> https://listas.hispalinux.es/pipermail/linux-ppc-es/2006-May/000820.html
> 
> Am I missing something or is everyone seeing this?

2.6.16 doesn't use the some kind of do-nothing loop anymore to set the
bogomips value, but some internal cpu counter or something such. I don't know
the details.

As such, the bogomips value changed radically, and what you see is normal.
bogomips values are bogus anyway, so this change should not have any other
major effect.

Friendly,

Sven Luther

