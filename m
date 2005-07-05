Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVGELWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVGELWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 07:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVGELWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 07:22:38 -0400
Received: from alog0127.analogic.com ([208.224.220.142]:16079 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261789AbVGELKz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 07:10:55 -0400
Date: Tue, 5 Jul 2005 07:09:47 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Michal Jaegermann <michal@harddata.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A "new driver model" and EXPORT_SYMBOL_GPL question
In-Reply-To: <20050703171202.A7210@mail.harddata.com>
Message-ID: <Pine.LNX.4.61.0507050703220.20388@chaos.analogic.com>
References: <20050703171202.A7210@mail.harddata.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2005, Michal Jaegermann wrote:

> It dawned on me only now that a "new driver model" introduced
> in patches from GKH export symbols like that:
>
> EXPORT_SYMBOL_GPL(class_create);
> EXPORT_SYMBOL_GPL(class_destroy);
>
> and so on.  The problem is that corresponding old symbols, which
> are still present in 2.6.12, were exported
>
> EXPORT_SYMBOL(class_simple_create);
> EXPORT_SYMBOL(class_simple_destroy);
> ....
>
> This creates a problem.  There exist out-of-tree drivers which are
> using those symbols and, even if sources are available, are not
> licensed GPL for whatever reasons.  No, I am not the author of any
> of those so I cannot do very much about re-licensing.  As an effect
> a conversion to a "new driver model", even if simple, does not work.
> In particular I bumped into that with Myrinet card drivers.
>
> Was a decision to use EXPORT_SYMBOL_GPL deliberate and if yes then
> what considerations dictated it, other then the patch author wrote
> it that way, and what drivers in question are supposed to use when
> this change will show up in the mainline?  It looks that 2.6.13
> will do this.
>
>  Thanks,
>  Michal
> -

This problem will continue. Eventually there will be no general
exported symbols. The apparent idea is to prevent the use of the
kernel in proprietary systems.

Not to worry. The tools provided with a typical Linux distribution
are capable of resolving those symbols. You can make a script
that `greps`  System.map for the correct offsets of those symbols.
You can use those offsets in a linker script.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
