Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293256AbSBWXNg>; Sat, 23 Feb 2002 18:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293257AbSBWXNQ>; Sat, 23 Feb 2002 18:13:16 -0500
Received: from zero.tech9.net ([209.61.188.187]:55563 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293256AbSBWXNH>;
	Sat, 23 Feb 2002 18:13:07 -0500
Subject: Re: [PATCH] only irq-safe atomic ops
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3C781351.DCB40AD3@zip.com.au>
In-Reply-To: <3C773C02.93C7753E@zip.com.au>,
	<1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au>
	<1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au>
	<20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy>
	<20020223120648.A1295@hq.fsmlabs.com> <3C781037.EA4ADEF5@linux-m68k.org> 
	<3C781351.DCB40AD3@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 Feb 2002 18:13:06 -0500
Message-Id: <1014505987.1003.1104.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-02-23 at 17:10, Andrew Morton wrote:

> ooh.  me likee.
> 
> #define smp_get_cpuid() ({ preempt_disable(); smp_processor_id(); })
> #define smp_put_cpuid() preempt_enable()
> 
> Does rml likee?

Yah, that works.

All we need to do is wrap the smp_processor_id references (however many
- it does not matter) in preempt_disable ... preempt_enable.  This does
that cleanly.

	Robert Love

