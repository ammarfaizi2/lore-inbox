Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTDURSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTDURSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:18:38 -0400
Received: from [66.212.224.118] ([66.212.224.118]:37639 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S261757AbTDURSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:18:38 -0400
Date: Mon, 21 Apr 2003 13:22:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
In-Reply-To: <3EA41684.6030502@kolumbus.fi>
Message-ID: <Pine.LNX.4.50.0304211314040.2085-100000@montezuma.mastecende.com>
References: <200304210351_MC3-1-3544-3713@compuserve.com>
 <Pine.LNX.4.50.0304211008110.2085-100000@montezuma.mastecende.com>
 <3EA41684.6030502@kolumbus.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Mika Penttilä wrote:

> Why can't we use the same vector for multiple ioapic entrys? After all, 
> we are already sharing irqs, and an irq is just a cookie for a vector. 
> What do you mean with "lost irq routing" ?

Each ioredtbl can take a vector, if you assign another ioredtbl with the 
same vector and different IRQ then you collide with the previous entry and 
wipe it from the IDT. Also irq != vector

	Zwane

