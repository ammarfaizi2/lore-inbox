Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264076AbUFBUUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUFBUUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbUFBUTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:19:12 -0400
Received: from cits-darla.robins.af.mil ([137.244.215.8]:48843 "EHLO
	cits-darla.robins.af.mil") by vger.kernel.org with ESMTP
	id S264085AbUFBURK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:17:10 -0400
Message-ID: <200406022013.i52KDu1l025256@cits-darla.robins.af.mil>
From: Garboua Nahil Y Contr WRALC/MASFE <Nahil.Garboua@robins.af.mil>
To: Mathieu Segaud <matt@minas-morgul.org>, linux-kernel@vger.kernel.org
Subject: RE: Context switch Tick
Date: Wed, 2 Jun 2004 20:15:50 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, vmstat show me the cs according to current load, what is the Maximum
tick rate? 
A process requests a 1 microseconds sleep, or even 500 nanoseconds, how long
does it actually sleep, that is why I need to know max tick rate for context
switch for a given CPU.

-----Original Message-----
From: Mathieu Segaud [mailto:matt@minas-morgul.org] 
Sent: Wednesday, June 02, 2004 3:52 PM
To: Garboua Nahil Y Contr WRALC/MASFE
Subject: Re: Context switch Tick

Garboua Nahil Y Contr WRALC/MASFE <Nahil.Garboua@robins.af.mil> writes:

> How fast does the kernel switches contexts, and does it dependent on type
> and speed of cpu?   
> Where/how can I find current system tick rate for the Linux kernel 
> context switch?

The context switch tick rate depends on many things:
- any time an interrupt is triggered, there is a ctx switch,
- schedule() performs a context switch if it finds a suitable process,
- schedule() is called on every blocking io that a process calls for,

so the rate is quite changing ;)
if you want to know the current ctx switch rate, use vmstat

vmstat 1 will gives a line per second on system info:
process statistics, io stats, memory stats, and cpu stats

the one you want is denoted "cs"

--
Mathieu Segaud

> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
