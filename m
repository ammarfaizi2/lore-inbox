Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933753AbWKWTzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933753AbWKWTzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933874AbWKWTzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:55:42 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60053
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933753AbWKWTzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:55:41 -0500
Date: Thu, 23 Nov 2006 11:55:47 -0800 (PST)
Message-Id: <20061123.115547.66177234.davem@davemloft.net>
To: eike-kernel@sf-tec.de
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [BUG][REGRESSION] irda compile broken
From: David Miller <davem@davemloft.net>
In-Reply-To: <200611231023.34922.eike-kernel@sf-tec.de>
References: <200611231023.34922.eike-kernel@sf-tec.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Thu, 23 Nov 2006 10:23:28 +0100

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

As Andrew posted elsewhere, I accidently put that change in before the
infrastructure, and Andrew will push the necessary infrastructure
patch to Linus to fix this build failure.

Sorry for that, but it'll get fixed up soon.
