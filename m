Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTEMHra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTEMHra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:47:30 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:20352
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263427AbTEMHr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:47:28 -0400
Date: Tue, 13 May 2003 03:50:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: STK <stk@nerim.net>
cc: "'Jos Hulzink'" <josh@stack.nl>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] How to fix MPS 1.4 + ACPI behaviour ?
In-Reply-To: <000b01c318cd$992f92e0$0200a8c0@QUASARLAND>
Message-ID: <Pine.LNX.4.50.0305130344200.5420-100000@montezuma.mastecende.com>
References: <000b01c318cd$992f92e0$0200a8c0@QUASARLAND>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003, STK wrote:

> 
> For me the linux kernel should invoke the _PIC method with the right
> parameter.
> 

Jos, if you switch to IOAPIC mode after failing you're going to have to 
reprogram the IOAPIC again as specified in the mptables, setup_IOAPIC_irqs 
does this. As well as do some other setup which ACPI let you get 
past in arch/i386/kernel/mpparse.c. In a nutshell it'll get very convoluted 
quickly.

	Zwane
-- 
function.linuxpower.ca
