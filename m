Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbUKNM0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUKNM0m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 07:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUKNM0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 07:26:41 -0500
Received: from mail.gmx.de ([213.165.64.20]:48063 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261294AbUKNM0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 07:26:40 -0500
X-Authenticated: #4399952
Date: Sun, 14 Nov 2004 13:27:10 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: linux-os@analogic.com
Cc: linux-os@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTC Chip and IRQ8 on 2.6.9
Message-ID: <20041114132710.09533649@mango.fruits.de>
In-Reply-To: <Pine.LNX.4.61.0411121145520.14827@chaos.analogic.com>
References: <Pine.LNX.4.61.0411121145520.14827@chaos.analogic.com>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004 11:47:10 -0500 (EST)
linux-os <linux-os@chaos.analogic.com> wrote:

> 
> I must use the RTC and IRQ8 in a driver being ported from
> 2.4.20 to 2.6.9. When I attempt request_irq(8,...), it
> returns -EBUSY. I have disabled everything in .config
> that has "RTC" in it.
> 
> The RTC interrupt is used to precisely time the sequencing
> of a precision A/D converter. It is mandatory that I use
> it because the precise interval is essential for its
> IIR filter that produces 20 bits of resolution from a
> 16 bit A/D.
> 
>    8:          1    IO-APIC-edge  rtc

maybe it's the HPET timer providing rtc emulation?

flo
