Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267503AbUGWCkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267503AbUGWCkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 22:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267504AbUGWCkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 22:40:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:62594 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267503AbUGWCkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 22:40:37 -0400
Date: Thu, 22 Jul 2004 22:39:24 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Maikon Bueno <maikon@gmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: interrupt function
In-Reply-To: <757c55c604072219086df290f6@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0407222234120.21588@chaos>
References: <757c55c604072219086df290f6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the device at 0x300 was interrupting, you would get an
interrupt and it will bump the count shown in your ISR.

Whatever that device at 0x300 is, needs to be programmed
to generate hardware interrupts. They don't happen by
magic. Usually, if edge triggered, you will only get
one interrupt until you put some code in your ISR to
handle that interrpt (make the hardware happy so it will
generate another).

If the interrupt is level triggered, code such as yours
will hang the machine because there is no ISR code to
service the hardware so the interrupt will be TRUE forever.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


