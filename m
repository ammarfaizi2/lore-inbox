Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbSIWUmB>; Mon, 23 Sep 2002 16:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbSIWUmB>; Mon, 23 Sep 2002 16:42:01 -0400
Received: from dsl-213-023-022-250.arcor-ip.net ([213.23.22.250]:28598 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261369AbSIWUmA>;
	Mon, 23 Sep 2002 16:42:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Dave Olien <dmo@osdl.org>
Subject: Re: DAC960 in 2.5.38, with new changes
Date: Mon, 23 Sep 2002 22:44:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: axboe@suse.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
References: <20020923120400.A15452@acpi.pdx.osdl.net> <15759.26918.381273.951266@napali.hpl.hp.com>
In-Reply-To: <15759.26918.381273.951266@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ta3t-0003bj-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 September 2002 21:19, David Mosberger wrote:
> Hi Dave,
> 
> >>>>> On Mon, 23 Sep 2002 12:04:00 -0700, Dave Olien <dmo@osdl.org> said:
> 
>   Dave> #ifdef __ia64__
>   Dave> -  writeq(Virtual_to_Bus64(CommandMailbox),
>   Dave> +  writeq(CommandMailboxDMA,
>   Dave> ControllerBaseAddress + DAC960_LP_CommandMailboxBusAddressOffset);
>   Dave> #else
>   Dave> -  writel(Virtual_to_Bus32(CommandMailbox),
>   Dave> +  writel(CommandMailboxDMA,
>   Dave> ControllerBaseAddress + DAC960_LP_CommandMailboxBusAddressOffset);
>   Dave> #endif
> 
> This looks like a porting-nightmare in the making.  There's got to be a
> better way to determine whether you need a writeq() vs. a writel().

Even if an #ifdef is necessary here (and we are in trouble if it is) it
should not trigger on __ia64__, it should trigger on the size of (long).

-- 
Daniel
