Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbTAUJRw>; Tue, 21 Jan 2003 04:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTAUJRw>; Tue, 21 Jan 2003 04:17:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47343 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S266859AbTAUJRv>;
	Tue, 21 Jan 2003 04:17:51 -0500
Message-ID: <3E2D1245.131E41DB@mvista.com>
Date: Tue, 21 Jan 2003 01:26:29 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Thomas Schlichter <schlicht@uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: problem using integer division in kernel modules
References: <200301151941.29690.schlicht@uni-mannheim.de> <20030115191122.GV27709@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> 
> On Wed, Jan 15, 2003 at 07:41:29PM +0100, Thomas Schlichter wrote:
> > Hi,
> >
> > I am writing at a small kernel module and have a problem now using / and %. If
> > I do so I get following unresolved symbols when the module should be loaded:
> >   __divdi3
> >   __moddi3
> 
>   64-bit division with non-constant non-power-of-two divider.
> 
> > Could you please help me and tell me what I do wrong..?
> 
>   The kernel is linked without gcc builtin libraries.
>   Reasons can be found from FAQ (see footer), or archives.

You may want to check out .../include/asm-???/div64.h.  It
allows some limited divides with 64-bit numbers.  Look at
several so you understand what it does and does not do.

-g
> 
> /Matti Aarnio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
