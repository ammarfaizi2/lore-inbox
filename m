Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293218AbSBWV5e>; Sat, 23 Feb 2002 16:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293220AbSBWV5X>; Sat, 23 Feb 2002 16:57:23 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:42247 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S293218AbSBWV5T>; Sat, 23 Feb 2002 16:57:19 -0500
Message-ID: <3C781037.EA4ADEF5@linux-m68k.org>
Date: Sat, 23 Feb 2002 22:57:11 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au>, <1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy> <20020223120648.A1295@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> Right. Without preemption it is safe to do
>         c = smp_get_cpuid();
>        ...
>         x = ++local_cache[c]
>        ..
> 
>        y = ++different_local_cache[c];
>       ..

Just add:
	smp_put_cpuid();

Is that so much worse?

bye, Roman
