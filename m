Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVBVKND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVBVKND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 05:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVBVKND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 05:13:03 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:30348 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262257AbVBVKNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 05:13:00 -0500
Message-ID: <421B05EE.8000700@uni-muenster.de>
Date: Tue, 22 Feb 2005 11:14:06 +0100
From: Martin Drohmann <m_droh01@uni-muenster.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Why does printk helps PCMCIA card to initialise?
References: <3zXLc-3vg-13@gated-at.bofh.it> <3zYxA-4dY-13@gated-at.bofh.it> <3AhTz-3pR-15@gated-at.bofh.it>
In-Reply-To: <3AhTz-3pR-15@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, Feb 20, 2005 at 12:38:17PM +0000, Russell King wrote:
> 
>>The first thing that needs solving is why you're getting the "odd IO
>>request" crap.  That may explain why the resource can't be allocated.
> 
> 
> In cs.c, alloc_io_space(), find the line:
> 
>     if (*base & ~(align-1)) {
> 
> delete the ~ and rebuild.  This may resolve your problem.
> 
> This looks like a long standing bug in the PCMCIA code, going back to
> 2.4 kernels.
> 
I tried that, but it didn't work. Just the "odd IO request" is away. But
  the error remains the same.

