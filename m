Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756821AbWKWJcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbWKWJcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757279AbWKWJcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:32:18 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:31738 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1756821AbWKWJcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:32:17 -0500
Subject: Re: [BUG][REGRESSION] irda compile broken
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       "David S.Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <200611231023.34922.eike-kernel@sf-tec.de>
References: <200611231023.34922.eike-kernel@sf-tec.de>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 10:27:55 +0100
Message-Id: <1164274075.5968.203.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 10:23 +0100, Rolf Eike Beer wrote:
> Peter tried to fix a IRDA lockdep warning by commit 
> 700f9672c9a61c12334651a94d17ec04620e1976. The commit message says: "it just 
> needs a lockdep annotation." 
> 
> Compiling this gives:
> 
> WARNING: "spin_lock_irqsave_nested" [net/irda/irda.ko] undefined!
> 
> The only point in the whole kernel tree where spin_lock_irqsave_nested appears 
> is in this file. Maybe this patch was meant to go into -mm and stay there?

The original mail also contained this:
  (depends on patches in -mm for spin_lock_irqsave_nested())

Anyway, it has already been noticed, and Andrew will send the needed
bits upwards.

  http://lkml.org/lkml/2006/11/22/283




