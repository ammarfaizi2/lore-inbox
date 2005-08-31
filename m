Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVHaO3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVHaO3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVHaO3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:29:46 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:59564 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964822AbVHaO3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:29:45 -0400
Date: Wed, 31 Aug 2005 07:29:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PREEMPT_RT vermagic
Message-ID: <20050831142944.GF3966@smtp.west.cox.net>
References: <20050829084829.GA23176@elte.hu> <1125441737.18150.43.camel@dhcp153.mvista.com> <20050831072017.GA7125@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831072017.GA7125@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 09:20:17AM +0200, Ingo Molnar wrote:
> 
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > Ingo,
> > 	This patch adds a vermagic hook so PREEMPT_RT modules can be
> > distinguished from PREEMPT_DESKTOP modules.
> 
> vermagic is very crude and there are zillions of other details and 
> .config flags that might make a module incompatible. You can use 
> CONFIG_MODVERSIONS to get a stronger protection that vermagic, but 
> that's far from perfect too. The right solution is the module signing 
> framework in Fedora. Until that gets merged upstream just dont mix 
> incompatible modules, and keep things tightly packaged.

MODVERSIONS won't get the PREEMPT_RT vs PREEMPT_DESKTOP case right
without this, unless I'm missing something.

-- 
Tom Rini
http://gate.crashing.org/~trini/
