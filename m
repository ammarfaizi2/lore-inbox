Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUI0FzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUI0FzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 01:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUI0FzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 01:55:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6326 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266133AbUI0FzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 01:55:00 -0400
Date: Mon, 27 Sep 2004 07:52:38 +0200
From: Jens Axboe <axboe@suse.de>
To: gundolfk@web.de
Cc: Christoph Bartelmus <lirc@bartelmus.de>, linux-kernel@vger.kernel.org
Subject: Re: IRQ blocking when reading audio CDs
Message-ID: <20040927055234.GA2288@suse.de>
References: <20040926120849.GG3134@lilienthal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040926120849.GG3134@lilienthal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26 2004, Gundolf Kiefer wrote:
> Dear Jens (& Christoph),
> 
> on my media PC (a Pentium II 350 MHz running Debian Woody with Kernel 
> 2.4.25), I have problems using LIRC 0.6.6 with a serial IR reveiver when at 
> the same time some application (cdparanoia, xmms/Audio CD reader) is 
> reading audio data from a CD.
> 
> After some testing and exploration of the LIRC source code, I figured out 
> that during audio CD reading interrupts seem to be blocked for a longer 
> time (in the order of milliseconds), while lirc_serial measures the exact 
> time between two serial interrupts and thus relies on an accurate timing. 
> In consequence, LIRC does not recognize the IR sequences, there are no 
> errors reported. Assigning a high priority to the serial interrupt using 
> "irq_tune" did not help.
> 
> Is there a way to make the audio CD read operations less blocking? Or does 
> any of you know a different source of the problem I observed?

Upgrade to 2.6, it can use DMA for cdda extraction. If you cannot for
some reason, Andrew had an ide-cd hack to enable dma in 2.4 for this.

-- 
Jens Axboe

