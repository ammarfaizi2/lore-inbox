Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbSJYMdy>; Fri, 25 Oct 2002 08:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261383AbSJYMdy>; Fri, 25 Oct 2002 08:33:54 -0400
Received: from zero.aec.at ([193.170.194.10]:12810 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261379AbSJYMdx>;
	Fri, 25 Oct 2002 08:33:53 -0400
Date: Fri, 25 Oct 2002 14:40:01 +0200
From: Andi Kleen <ak@muc.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 performance counters driver 3.0-pre2 for 2.5.44: [2/4] x86 support
Message-ID: <20021025124001.GA29937@averell>
References: <200210241500.RAA03585@kim.it.uu.se> <m3wuo7omzg.fsf@averell.firstfloor.org> <15801.14413.909403.323948@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15801.14413.909403.323948@kim.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For what values of cpu is per_cpu(var,cpu) valid? For those where
> cpu_online(cpu) is true, or those where cpu_possible(cpu) is true?
> (I need to convert a memset() on the per_cpu_cache[] array to the
> per_cpu(,) framework.)

Currently for cpu_possible(), but there is a patchkit around that
makes it only true for cpu_online() so better assume that. 
Of course that would require a hotplug CPU handler, but I would
just ignore that for now.

-Andi
