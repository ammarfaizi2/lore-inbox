Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTE0M07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTE0M07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:26:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50189 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263540AbTE0M05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:26:57 -0400
Date: Tue, 27 May 2003 13:40:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 - IRQs+PCMCIA: Nobody cares! *sniff*
Message-ID: <20030527134005.C16734@flint.arm.linux.org.uk>
Mail-Followup-To: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
References: <20030527120346.GB497@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030527120346.GB497@zip.com.au>; from cat@zip.com.au on Tue, May 27, 2003 at 10:03:46PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 10:03:46PM +1000, CaT wrote:
> I think back then someone said that Russel King was working on a fix.

The deadlock-on-boot-with-card-inserted is solved and in Linus' kernel.

> irq 10: nobody cared!
> Call Trace:
>  [<c010a2d1>] handle_IRQ_event+0x91/0x100
>  [<c010a2d9>] handle_IRQ_event+0x99/0x100
>  [<c010a4f5>] do_IRQ+0xb9/0x130
>  [<c0108f9c>] common_interrupt+0x18/0x20
>  [<c0113236>] delay_tsc+0x12/0x1c
>  [<c0201152>] __delay+0x12/0x18
>  [<c02011c1>] __const_udelay+0x21/0x30

These aren't oopses.  They're reports with a call trace that someone
didn't find something to service when an interrupt occurred.  Earlier
kernels ignored this condition.  You can safely ignore them for now,
but at some point they do need to be cleaned up.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

