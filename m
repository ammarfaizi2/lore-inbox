Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSKIFof>; Sat, 9 Nov 2002 00:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264655AbSKIFof>; Sat, 9 Nov 2002 00:44:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25616 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264654AbSKIFoe>; Sat, 9 Nov 2002 00:44:34 -0500
Date: Fri, 8 Nov 2002 21:50:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] do_nmi needs irq_enter/irq_exit lovin...
In-Reply-To: <Pine.LNX.4.44.0211082345101.10475-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211082147380.1622-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Nov 2002, Zwane Mwaikambo wrote:
>
> You don't even want to see the oops ;) But there is some more work 
> required before this will all work. I'll require your comments on a few 
> more incoming patches.

I think it would be cleaner to have the smp_processor_id() within the 
irq_enter/exit() pair, even if the thing should be safe the way you do it 
thanks to local interrupts being disabled..

		Linus

