Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVIHHrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVIHHrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVIHHrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:47:41 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:22234 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751337AbVIHHrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:47:39 -0400
Message-ID: <4394.10.124.102.246.1126165652.squirrel@dominion>
In-Reply-To: <20050907224911.H19199@flint.arm.linux.org.uk>
References: <200509072146.j87LkNv8004076@shell0.pdx.osdl.net>
    <20050907224911.H19199@flint.arm.linux.org.uk>
Date: Thu, 8 Sep 2005 16:47:32 +0900 (JST)
Subject: Re: performance-improvement-of-serial-console-via-virtual.patch
 added to -mm tree
From: "Taku Izumi" <izumi2005@soft.fujitsu.com>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: akpm@osdl.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: izumi2005@soft.fujitsu.com
User-Agent: SquirrelMail/1.4.5-1_rh4
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-2022-jp
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Russell:

>I don't think we want this.  With early serial console, tx_loadsz is
>not guaranteed to be initialised, and may in fact be zero.

>Plus there's no guarantee that the FIFOs will actually be enabled, so
>I think it's better that this patch doesn't go to mainline.

Our server has a virtual serial port, but its performance seems to be poor.
It takes 10 seconds to output 4000 characters (from kernel) to serial
console. By applying my patch, its peformance could be improved. ( 0.4
seconds / 4000 characters output), so I think it is useful to use FIFO at
serial8250_console_write function like transmit_chars function. Where
should I correct in order to use FIFO?

Taku Izumi <izumi2005@soft.fujitsu.com>


