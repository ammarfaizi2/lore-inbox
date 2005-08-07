Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbVHGKha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVHGKha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 06:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVHGKha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 06:37:30 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:39073 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751445AbVHGKh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 06:37:29 -0400
Message-ID: <42F5E6DB.E43112FE@tv-sign.ru>
Date: Sun, 07 Aug 2005 14:47:55 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] i386: Per node IDT
References: <42D26604.66A75939@tv-sign.ru> <Pine.LNX.4.61.0507110747480.16055@montezuma.fsmlabs.com>
	 <42D285CD.CF9389F8@tv-sign.ru> <42D28DE4.B5B17853@tv-sign.ru> <Pine.LNX.4.61.0508061906050.470@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> On Mon, 11 Jul 2005, Oleg Nesterov wrote:
> 
> > Please note that entry.S:BUILD_INTERRUPT() also does this trick:
> >       pushl $nr-256;
> >
> > so it should be changed as well.
> 
> I was making these changes and noticed that those were for the various SMP
> interrupts so they are real vectors. These will always remain within the
> 256 range.

Yes, you are right. I suggested it for consistency only.
Afaics, none of the smp_xxx_interrupt uses this value, so
it it safe to change the pushed number.

But it is very minor issue indeed, and probably you are
right not doing so.

Oleg.
