Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbVIMNIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbVIMNIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 09:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVIMNIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 09:08:06 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34213 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932641AbVIMNIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 09:08:04 -0400
Message-ID: <01ac01c5b864$291f1370$dba0220a@CARREN>
From: "Hironobu Ishii" <hishii@soft.fujitsu.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Taku Izumi" <izumi2005@soft.fujitsu.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
References: <200509072146.j87LkNv8004076@shell0.pdx.osdl.net> <20050907224911.H19199@flint.arm.linux.org.uk> <4394.10.124.102.246.1126165652.squirrel@dominion> <20050913091740.A8256@flint.arm.linux.org.uk> <00b601c5b858$8a8c4ad0$dba0220a@CARREN> <20050913125326.A14342@flint.arm.linux.org.uk> <20050913130229.B14342@flint.arm.linux.org.uk>
Subject: Re: performance-improvement-of-serial-console-via-virtual.patch added to -mm tree
Date: Tue, 13 Sep 2005 22:07:55 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> Additionally, once all architectures convert to initialising their
> serial ports via platform devices (which means include/asm-*/serial.h
> becomes essentially empty) and we eliminate serial8250_console_init(),
> the 8250 console code can start assuming that more of the uart_port
> structure will be initialised.
> 
> At that point, we can start to think about using FIFOs for the
> console.

Thank you for FIFO consideration.

me> Before initialization, does tx_loadsz left 0?
me> If so, we can easily solve the problem:

I confirmed this assumption is OK in current code,
because seiral8250_ports[] is static variable.

We will release revised patch later,
please apply our patch until your serial driver 
re-organization completes.

Thank you.
Hironobu Ishii

