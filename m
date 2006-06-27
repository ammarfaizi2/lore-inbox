Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161284AbWF0Urs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161284AbWF0Urs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbWF0Urs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:47:48 -0400
Received: from terminus.zytor.com ([192.83.249.54]:2500 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161284AbWF0Urr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:47:47 -0400
Message-ID: <44A19966.7060808@zytor.com>
Date: Tue, 27 Jun 2006 13:47:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Ingo van Lil <inguin@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Serial: UART_BUG_TXEN race conditions
References: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de> <Pine.LNX.4.61.0606270813380.2135@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0606270813380.2135@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> 
> With 8250 UARTs and clones, an interrupt occurs when the
> transmitter holding register __becomes__ empty. That means
> it must have had something in it.
> 

Dear Wrongbot,

That's what some people think, and that's how they end up shipping buggy 
hardware.

With 16x50 UARTs, an interrupt occurs *when an interrupt condition is 
asserted*, which can happen either though a state change or on a change 
in IER.

	-hpa
